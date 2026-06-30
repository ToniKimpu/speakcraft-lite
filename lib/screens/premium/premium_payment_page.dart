import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:speakcraft/bloc/payment/payment_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/payment_method/payment_method.dart';
import 'package:speakcraft/services/analytics_service.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

class PremiumPaymentPage extends StatelessWidget {
  const PremiumPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc()..add(const PaymentEvent.loadMethods()),
      child: const _PaymentView(),
    );
  }
}

class _PaymentView extends StatefulWidget {
  const _PaymentView();

  @override
  State<_PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<_PaymentView> {
  List<PaymentMethod> _methods = [];
  PaymentMethod? _selected;
  File? _proof;
  bool _submitting = false;

  String _money(num amount, String currency) =>
      '${NumberFormat.decimalPattern().format(amount)} $currency';

  Future<void> _pickProof() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    final path = result?.files.single.path;
    if (path != null) {
      setState(() => _proof = File(path));
    }
  }

  void _submit() {
    final method = _selected;
    final proof = _proof;
    if (method == null || proof == null) return;
    AnalyticsService.instance.paymentSubmitted(method.displayName);
    context
        .read<PaymentBloc>()
        .add(PaymentEvent.submitPayment(method, proof));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassScaffold(
      title: const Text('Get Premium'),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, PmpRoutes.paymentStatusPage),
          child: const Text('Status'),
        ),
      ],
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          state.whenOrNull(
            methodsLoaded: (methods) {
              setState(() {
                _methods = methods;
                _selected ??= methods.isNotEmpty ? methods.first : null;
              });
            },
            submitting: () => setState(() => _submitting = true),
            submitted: (_) {
              Navigator.pushReplacementNamed(
                  context, PmpRoutes.paymentStatusPage);
            },
            submitError: (message) {
              setState(() => _submitting = false);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
            methodsError: (message) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        builder: (context, state) {
          final loadingMethods = state.maybeWhen(
              loadingMethods: () => true, orElse: () => false);
          if (loadingMethods && _methods.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_methods.isEmpty) {
            return _EmptyOrError(
              message: state.maybeWhen(
                methodsError: (m) => m,
                orElse: () => 'No payment methods are available right now.',
              ),
              onRetry: () => context
                  .read<PaymentBloc>()
                  .add(const PaymentEvent.loadMethods()),
            );
          }
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                children: [
                  _PlanHeader(
                    amountLabel: _selected == null
                        ? null
                        : _money(_selected!.amount, _selected!.currency),
                  ),
                  const SizedBox(height: 14),
                  const _PremiumBenefits(),
                  const SizedBox(height: 18),
                  Text('1. Pick how you want to pay', style: PmpTextStyles.body1Semi
                      .copyWith(color: cs.onSurface)),
                  const SizedBox(height: 10),
                  ..._methods.map((m) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _MethodCard(
                          method: m,
                          selected: _selected?.id == m.id,
                          money: _money(m.amount, m.currency),
                          onTap: () => setState(() => _selected = m),
                        ),
                      )),
                  const SizedBox(height: 14),
                  Text('2. Pay, then upload your screenshot',
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: cs.onSurface)),
                  const SizedBox(height: 10),
                  _ProofUpload(
                    proof: _proof,
                    onPick: _pickProof,
                    onClear: () => setState(() => _proof = null),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: (_selected != null &&
                            _proof != null &&
                            !_submitting)
                        ? _submit
                        : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: PmpColors.premiumGold,
                      foregroundColor: PmpColors.onPremium,
                    ),
                    child: const Text('Submit for review'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We review payments manually — you\'ll be notified once it\'s confirmed.',
                    textAlign: TextAlign.center,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
              if (_submitting)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0x66000000),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PlanHeader extends StatelessWidget {
  const _PlanHeader({required this.amountLabel});
  final String? amountLabel;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      highlight: true,
      child: Row(
        children: [
          const Icon(Icons.workspace_premium_rounded,
              color: PmpColors.premiumGold, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Premium — 1 year', style: PmpTextStyles.title1SemiBold),
                const SizedBox(height: 2),
                Text(
                  'Full access to every module for a whole year.',
                  style: PmpTextStyles.label2Regular,
                ),
              ],
            ),
          ),
          if (amountLabel != null) ...[
            const SizedBox(width: 8),
            Text(amountLabel!,
                style: PmpTextStyles.title2SemiBold
                    .copyWith(color: PmpColors.premiumGoldDeep)),
          ],
        ],
      ),
    );
  }
}

/// What Premium unlocks, across every module — the value pitch. Kept accurate
/// to the actual gating (SYM L2/L3 + more AI feedback, Vocabulary Intermediate/
/// Upper, Grammar beyond basics, Listening shadowing/speech/explanations).
class _PremiumBenefits extends StatelessWidget {
  const _PremiumBenefits();

  static const _items = <({IconData icon, String title, String sub})>[
    (
      icon: Icons.record_voice_over_outlined,
      title: 'Speak Your Mind — Levels 2 & 3',
      sub: 'Tell stories, give opinions & discuss real issues — plus more daily '
          'AI feedback on your writing.',
    ),
    (
      icon: Icons.menu_book_outlined,
      title: 'Vocabulary — Intermediate & Upper',
      sub: 'Hundreds more words & expressions, each with audio.',
    ),
    (
      icon: Icons.spellcheck_rounded,
      title: 'Grammar — every level',
      sub: 'All grammar levels beyond the basics.',
    ),
    (
      icon: Icons.headphones_outlined,
      title: 'Listening & Shadowing',
      sub: 'Shadowing, speech practice & sentence explanations on every video.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      highlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle,
                  color: PmpColors.premiumGold, size: 18),
              const SizedBox(width: 8),
              Text('Everything in Free, plus:',
                  style:
                      PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
            ],
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < _items.length; i++) ...[
            _BenefitRow(item: _items[i]),
            if (i != _items.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.item});
  final ({IconData icon, String title, String sub}) item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: PmpColors.premiumGold.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, size: 19, color: PmpColors.premiumGoldDeep),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title,
                  style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
              const SizedBox(height: 2),
              Text(item.sub,
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.method,
    required this.selected,
    required this.money,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final String money;
  final VoidCallback onTap;

  void _copyNumber(BuildContext context) {
    Clipboard.setData(ClipboardData(text: method.accountNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Number copied')),
    );
  }

  void _showQr(BuildContext context) {
    if (method.qrObjectPath == null) return;
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.network(method.qrObjectPath!, fit: BoxFit.contain),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      onTap: onTap,
      borderRadius: 16,
      highlight: selected,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? PmpColors.premiumGold : cs.outline,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(method.displayName,
                    style: PmpTextStyles.body1Semi
                        .copyWith(color: cs.onSurface)),
              ),
              Text(money,
                  style: PmpTextStyles.labelSemi
                      .copyWith(color: PmpColors.premiumGoldDeep)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(method.accountName,
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                    Text(method.accountNumber,
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: cs.onSurface)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _copyNumber(context),
                icon: const Icon(Icons.copy_rounded, size: 18),
                tooltip: 'Copy number',
              ),
              if (method.qrObjectPath != null)
                IconButton(
                  onPressed: () => _showQr(context),
                  icon: const Icon(Icons.qr_code_2_rounded, size: 22),
                  tooltip: 'Show QR',
                ),
            ],
          ),
          if (method.instructions != null &&
              method.instructions!.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(method.instructions!.trim(),
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
          ],
        ],
      ),
    );
  }
}

class _ProofUpload extends StatelessWidget {
  const _ProofUpload({
    required this.proof,
    required this.onPick,
    required this.onClear,
  });

  final File? proof;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (proof != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(proof!,
                height: 220, width: double.infinity, fit: BoxFit.cover),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onClear,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xCC000000),
                child: Icon(Icons.close, size: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline, style: BorderStyle.solid),
          color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined,
                size: 34, color: cs.onSurfaceVariant),
            const SizedBox(height: 8),
            Text('Upload payment screenshot',
                style: PmpTextStyles.body2Semi
                    .copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _EmptyOrError extends StatelessWidget {
  const _EmptyOrError({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message,
                textAlign: TextAlign.center, style: PmpTextStyles.body2Regular),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
