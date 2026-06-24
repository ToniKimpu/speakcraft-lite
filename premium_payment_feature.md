# Premium Payment Feature — Manual Screenshot Verification

Manual payment + admin review flow for premium upgrades. Users pay via a
mobile-wallet (KPay now; bank/others later), upload a screenshot, and an admin
approves or rejects from the admin panel. Approval extends `users.premium_until`.

## Build status

- ✅ **Supabase schema + RLS + RPCs** — `pmp_english_admin/supabase/migrations/20260625120000_premium_payment_submissions.sql` (applied to remote).
- ✅ **Admin panel** (`pmp_english_admin`, `/payments` route) — payment-methods CRUD + review queue (approve/reject). Type-checks + lints clean.
- ✅ **Mobile** — payment screen + status screen + realtime live-unlock + `refreshUser` + resume lifecycle hook. Codegen + analyze clean.
  - Models: `lib/model/payment_method/`, `lib/model/payment_submission/`
  - Repo: `lib/repositories/payment/` (+ `paymentQr` bucket enum); bloc: `lib/bloc/payment/`
  - Screens: `lib/screens/premium/{premium_payment_page,payment_status_page}.dart`; routes `premiumPaymentPage` / `paymentStatusPage`
  - Entry: `showPremiumSheet` CTA now defaults to the payment route (no call-site changes)
  - Freshness: `AuthEvent.refreshUser` (silent), realtime channel on own `users` row in `AuthBloc`, `WidgetsBindingObserver` resume hook in `speakcraft_app.dart`; status screen uses `.stream()` on its submission
- ✅ **Push notifications** on approve/reject — new `notify-user` edge function (targeted, data-only, backend-only) + admin actions invoke it + mobile tap-routing to the status page.
- ✅ **`users` self-grant hole closed** — `20260625130000_harden_users_premium_until.sql`: revoked blanket UPDATE from `authenticated`, granted UPDATE only on `name, profile_path, device_id, total_token_used`. `premium_until` (and other sensitive cols) are no longer client-writable; `service_role` RPCs unaffected.
- ⏳ **Remaining**: terminated-cold-start tap routing is best-effort only.

### Push notifications (done)
- **Edge function** `pmp_english_admin/supabase/functions/notify-user/index.ts` — sends a **data-only** FCM v1 message to a caller-supplied `topic` (the user's auth uid). Mirrors the existing broadcast `send-notification` but targeted; reuses the `FIREBASE_SERVICE_ACCOUNT_PROD` secret; rejects callers not using the service-role key. Deployed to project `yoolagzhgxilukjsypbh`.
- **Admin** `payment-submissions.ts` → `notifyBuyer()` looks up the buyer's `users.user_id` and invokes `notify-user` after approve/reject (best-effort try/catch). Approve = "Premium activated 🎉"; reject = the reason.
- **Why data-only, not a `notification` block:** the app displays via `flutter_local_notifications` from `data['title']`/`data['message']` in both foreground (`onMessage`) and background (`_firebaseMessagingBackgroundHandler`). A `notification` block would double-notify on Android.
- **Mobile tap-routing:** `lib/services/navigation_service.dart` (shared `navigatorKey`); `main.dart` `onDidReceiveNotificationResponse` parses the payload (`jsonEncode(message.data)`) and routes `type == 'payment_review'` → `paymentStatusPage`. `speakcraft_app.dart` now uses the shared key.

Key discovery during build: a full subscriptions system **already existed**
(`subscription_plans`, `subscriptions` ledger, `grant_subscription()` with the
extend/stack math, `get_user()` deriving `is_premium_user`). The new work builds
on it — **approval calls the existing `grant_subscription()`** rather than writing
`premium_until` directly. The admin (`pmp_english_admin`) lives at
`D:\PMP_Projects\pmp_english_admin`; migrations live there, not in this repo.

## Decisions locked

| Topic | Decision |
|---|---|
| Source of truth | `users.premium_until` (already exists); premium boolean derived **server-side** |
| Plan | One-time purchase, **365 days** |
| Stacking | **Extend**: `premium_until = max(premium_until, now) + 365 days` |
| Revoke | Set `premium_until` to past/null — no separate "deactivate" feature in v1 |
| Deactivate/ban | Skipped for v1 (optional unused `is_active` column for future) |
| Payment methods | Admin-managed table (KPay now, bank later); number to copy + optional QR |
| Amount | **Stored** on method and snapshotted on submission |
| Reject | Save reason → push as notification → allow resubmit (new row, history kept) |
| Revoke (post-approval) | `revoke_payment_submission(id, reason)`: `premium_until=now()` (kill now) + linked subscription → `refunded` + submission → `rejected`(+reason) + push "Premium revoked". Admin **Revoke premium** action shown on approved rows. Migration `20260625140000`. |
| Freshness | **Realtime** on own-row `premium_until` (live unlock) + cold-start fetch + lightweight `refreshUser` on resume |
| Entry point | Existing `showPremiumSheet` → `onGetPremium` → new payment screen |

## End-to-end flow

1. Free user taps a gated feature → existing `showPremiumSheet` → taps **Get Premium**.
2. App shows active **payment methods** (from `payment_methods`). User picks one,
   sees the account name/number (copyable) and/or QR, and the **amount**.
3. User pays in their wallet app, screenshots the receipt.
4. User uploads the screenshot in-app → creates a `payment_submissions` row
   (`status = pending`), snapshotting amount + method.
5. App shows a **Pending** status screen. A realtime subscription on the user's
   own row is live.
6. Admin sees the submission in the **review queue**, opens it, views the
   screenshot, and **Approves** or **Rejects (with reason)**.
   - **Approve** → `premium_until = max(premium_until, now) + 365d`,
     submission `status = approved`, push "You're Premium for 1 year 🎉".
   - **Reject** → submission `status = rejected`, `reject_reason` saved, push the
     reason as the notification body. User can resubmit (new row).
7. The user's premium flips:
   - **App open** → realtime pushes new `premium_until` → gates unlock live.
   - **Backgrounded then reopened** → `refreshUser` on resume re-fetches.
   - **Killed then relaunched** → cold-start `authCheck` re-fetches.

---

## 1. Supabase — data model

### 1.1 `payment_methods` (admin-managed)

```sql
create table public.payment_methods (
  id            bigint generated always as identity primary key,
  type          text    not null,           -- 'kpay' | 'wave' | 'bank' | ...
  display_name  text    not null,           -- "KBZPay", "AYA Bank", ...
  account_name  text    not null,           -- account holder name
  account_number text   not null,           -- phone / account no to copy
  qr_image_url  text,                        -- optional QR (storage URL)
  amount        numeric not null,           -- price in MMK for the 365-day plan
  currency      text    not null default 'MMK',
  instructions  text,                        -- free-text notes shown to user
  is_active     boolean not null default true,
  sort_order    int     not null default 0,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);
```

- Mobile reads `where is_active = true order by sort_order`.
- Adding a bank later = insert a row. No app release needed.

### 1.2 `payment_submissions`

```sql
create table public.payment_submissions (
  id                bigint generated always as identity primary key,
  user_id           uuid not null references auth.users(id),
  payment_method_id bigint references public.payment_methods(id),
  -- snapshots (so later edits to the method don't rewrite history)
  method_label      text   not null,
  amount            numeric not null,
  currency          text   not null default 'MMK',
  plan_days         int    not null default 365,
  screenshot_url    text   not null,
  status            text   not null default 'pending', -- pending|approved|rejected
  reject_reason     text,
  reviewed_by       uuid references auth.users(id),
  reviewed_at       timestamptz,
  created_at        timestamptz not null default now()
);

create index on public.payment_submissions (status, created_at);
create index on public.payment_submissions (user_id, created_at desc);
```

- We **snapshot** `method_label`, `amount`, `currency`, `plan_days` so the audit
  trail is stable even if the admin later edits or deletes the method.
- Resubmit after rejection = a brand-new row (history preserved).

### 1.3 RLS

```sql
-- payment_methods: anyone authenticated can read active methods; only admins write.
alter table public.payment_methods enable row level security;

create policy pm_read on public.payment_methods
  for select to authenticated using (is_active = true);
-- (admin writes go through service-role / admin policy — see admin section)

-- payment_submissions: a user sees & inserts only their own; cannot change status.
alter table public.payment_submissions enable row level security;

create policy ps_read_own on public.payment_submissions
  for select to authenticated using (auth.uid() = user_id);

create policy ps_insert_own on public.payment_submissions
  for insert to authenticated
  with check (auth.uid() = user_id and status = 'pending');
-- No user UPDATE policy: only the server/admin moves status & sets premium_until.
```

> Important: the user can **only** insert `pending` rows and **cannot** update
> them — status changes and `premium_until` writes happen server-side (admin /
> RPC with elevated rights). Premium can never be self-granted from the client.

### 1.4 Approval as an RPC (atomic + safe)

Do the approval in one Postgres function so the extend math and the status flip
are atomic and run with the right privileges:

```sql
create or replace function public.approve_payment(submission_id bigint)
returns void
language plpgsql
security definer
as $$
declare
  s public.payment_submissions;
begin
  -- (admin authorization check goes here — verify caller is an admin)
  select * into s from public.payment_submissions where id = submission_id for update;
  if s.status <> 'pending' then
    raise exception 'submission % is not pending', submission_id;
  end if;

  update public.users
     set premium_until = greatest(coalesce(premium_until, now()), now())
                         + make_interval(days => s.plan_days)
   where id = s.user_id;          -- adjust to your users table key

  update public.payment_submissions
     set status = 'approved', reviewed_at = now(), reviewed_by = auth.uid()
   where id = submission_id;
end;
$$;
```

A matching `reject_payment(submission_id, reason)` sets `status='rejected'`,
`reject_reason`, `reviewed_at/by`. Notifications are triggered after these (admin
backend or a DB trigger / Edge Function — see §4.4).

### 1.5 Realtime

- Enable Realtime replication on `public.users` (or a minimal premium view).
- Mobile subscribes to `postgres_changes` on `users` filtered to its own row
  (`id = <current user>`). RLS must permit the user to read their own row so the
  change payload is delivered. On `UPDATE`, read `premium_until` from the payload
  and update `GlobalAppState.currentUser` / `ValueNotifier<AppUser>`.

### 1.6 Storage

- New bucket folder `payment-screenshots` (add to `SupabaseBucketFolders`).
- Path convention: `payment-screenshots/<user_id>/<submission_uuid>.jpg`.
- Bucket policy: a user can upload to / read their own folder; admins read all.

---

## 2. Mobile — UI/UX

### 2.1 Entry point (no new gate UI)

`lib/shared_widgets/premium_gate.dart` already has `showPremiumSheet(... onGetPremium)`
with the CTA wired but the callback unused. Wire `onGetPremium` to navigate to the
new **Payment** route. Add the route to `lib/config/pmp_routes.dart`.

### 2.2 Screens

```
lib/screens/premium/
  premium_payment_page.dart     — method picker + pay instructions + upload
  payment_status_page.dart      — pending/approved/rejected + resubmit
  widgets/
    payment_method_card.dart    — one selectable method (name, number, QR, amount)
```

**`premium_payment_page.dart`**
- Header: "Premium — 1 year". Shows the **amount** prominently.
- List of active `payment_methods` as selectable cards. Each card:
  - `display_name` + type icon
  - `account_name`
  - `account_number` with a **Copy** button (copies to clipboard, toast)
  - QR image (tappable to enlarge) if `qr_image_url` present
  - `instructions` text if any
- Step hint: "1. Pay the amount  2. Screenshot the receipt  3. Upload below".
- **Upload screenshot** button → image picker → preview → **Submit**.
- On submit: upload to storage, insert `payment_submissions` (pending), navigate
  to status page.

**`payment_status_page.dart`**
- Reads the user's latest submission.
- **Pending**: animated "Under review — we'll notify you" + the realtime
  subscription is live so an approval flips this screen automatically.
- **Approved**: success state → "You're Premium until <date>" → Continue.
- **Rejected**: shows `reject_reason` + **Resubmit** (back to payment page).
- Premium expiry date shown from `premium_until`.

### 2.3 Model changes

- `AppUser`: add `@JsonKey(name: 'premium_until') DateTime? premiumUntil;`
  (currently only the derived `is_premium_user` bool is mapped). Keep the derived
  bool too. Regenerate freezed/json. Lets the status screen show the real date.
- New `PaymentMethod` and `PaymentSubmission` freezed models under `lib/model/`.

### 2.4 Repository / BLoC

- `lib/repositories/payment/payment_repository.dart`:
  - `fetchActiveMethods()`
  - `uploadScreenshot(file)` → returns URL
  - `submitPayment({methodId, amount, screenshotUrl})`
  - `latestSubmission()` / `watchLatestSubmission()`
- `lib/bloc/payment/payment_bloc.dart`: loading methods, submitting, status.
  Add to `mainBlocProviders()` only if it needs to be global; otherwise scope it
  to the payment screens.

### 2.5 Freshness wiring (the auth changes)

This is the only existing code we touch on the auth side.

1. **Realtime subscription** (live unlock):
   - On `AuthState.authenticated`, subscribe to `users` own-row changes; on
     update, set `ValueNotifier<AppUser>` with the new `premium_until` /
     `is_premium_user`. Unsubscribe on logout.

2. **`AuthEvent.refreshUser`** (new, lightweight): re-fetches `getCurrentUser()`
   and updates the `ValueNotifier` **without** emitting `loading()` and **without**
   the app-version / device-lock side effects in `_mapAuthCheckToState`. Used by
   the resume handler so there's no flicker / no surprise version screen.

3. **Lifecycle observer** (resume backstop): add a `WidgetsBindingObserver` at the
   app root (e.g. in `SpeakCraftApp` or `MainScaffold`) — there is currently none
   anywhere. On `AppLifecycleState.resumed`, dispatch `AuthEvent.refreshUser`.
   Covers "approved while the app was backgrounded."

> Cold start already re-fetches fresh via splash → `authCheck` → `getCurrentUser`,
> so no change needed there.

### 2.6 Notifications

Firebase is already wired. On approve/reject, the backend (or DB trigger / Edge
Function) sends a push to the user's device:
- Approve: "You're Premium for 1 year 🎉"
- Reject: the `reject_reason` text.
Tapping the notification opens `payment_status_page`.

---

## 3. Admin panel (`pmp_english_admin` — Next.js/TS)

> Repo not open in this session — **point me at its disk path** when we build it.
> Same Supabase project; admin writes use service-role / an admin-gated policy.

### 3.1 Payment Methods management
- Page: list methods (drag/sort by `sort_order`, toggle `is_active`).
- Create/edit form: `type`, `display_name`, `account_name`, `account_number`,
  `amount`, `currency`, `instructions`, QR upload (→ storage `qr_image_url`).
- Adding a bank later = just a new row here.

### 3.2 Review queue
- Page: submissions filtered by `status` (default **pending**), newest first.
- Row: user (name/email), method label, amount, submitted-at, thumbnail.
- Detail / drawer: full-size screenshot, user's current `premium_until`,
  computed "new expiry if approved", and **Approve** / **Reject** actions.
  - **Approve** → call `approve_payment(id)` RPC.
  - **Reject** → modal for `reason` → call `reject_payment(id, reason)`.
- After action, show the user's updated `premium_until`.

### 3.3 Existing "grant user"
- Keep it. It's the same write (set `premium_until`). Optionally route it through
  the same extend logic for consistency.

### 3.4 Notifications trigger
- Decide where push fires: from the admin backend after the RPC call, or via a DB
  trigger / Supabase Edge Function on status change. A DB-side trigger is more
  reliable (fires regardless of which client did the approval).

---

## 4. Build order

1. **Schema + RLS + RPCs + storage bucket + realtime** (foundation; both apps depend on it).
2. **Mobile models** (`AppUser.premiumUntil`, `PaymentMethod`, `PaymentSubmission`) + regenerate.
3. **Mobile auth freshness**: `refreshUser` event, realtime subscription, lifecycle observer.
4. **Mobile payment screens** + repository/bloc; wire `onGetPremium`.
5. **Admin**: payment-methods CRUD, then review queue + approve/reject.
6. **Notifications** on approve/reject + deep-link to status page.
7. End-to-end test: pay → submit → approve (live unlock) + reject (reason + resubmit).

## 5. Open items / to confirm during build

- Admin authorization check inside the RPCs (how admins are identified in your schema).
- Exact `users` table key used by `premium_until` (id type / FK to `auth.users`).
- Where push notifications fire (admin backend vs DB trigger / Edge Function).
- Screenshot size/format limits + compression before upload.
- Anti-dupe: block a new `pending` submission while one is already pending.
```
