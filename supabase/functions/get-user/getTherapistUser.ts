import { PostgrestError } from "https://esm.sh/v84/@supabase/supabase-js@1.35.3/dist/module/index";
import { supabaseClient } from "../_shared/supabaseClient.ts";

export default async function (
  user_id: string
  // deno-lint-ignore no-explicit-any
): Promise<{ data: any; error: PostgrestError | null }> {
  const { data, error } = await supabaseClient
    .from("user")
    .select(
      `
    *,
    address(*),
    roles_user:role(*)
`
    )
    .eq("id", user_id)
    .single();

  console.log({ data, error });

  if (error != null) throw error;
  if (data == null) throw new Error("User not found");

  return { data, error };
}
