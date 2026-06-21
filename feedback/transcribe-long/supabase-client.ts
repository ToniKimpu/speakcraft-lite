import { createClient } from '@supabase/supabase-js'

/** Service client — bypasses RLS. Use for all DB operations in edge functions. */
export function createServiceClient() {
  return createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  )
}

/** Extract the authenticated user from the request's Authorization header. */
export async function getUser(
  req: Request,
): Promise<{ id: string; email: string } | null> {
  const authHeader = req.headers.get('Authorization')
  if (!authHeader) return null

  const client = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_ANON_KEY')!,
    { global: { headers: { Authorization: authHeader } } },
  )

  const {
    data: { user },
    error,
  } = await client.auth.getUser()

  if (error || !user) return null
  return { id: user.id, email: user.email ?? '' }
}
