// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import { supabaseClient } from "../_shared/supabaseClient.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { PostgrestError } from "https://esm.sh/v84/@supabase/supabase-js@1.35.3/dist/module/index";
import getResponsibleUser from "./getResponsibleUser.ts";
import getPatientUser from "./getPatientUser.ts";
import getTherapistUser from "./getTherapistUser.ts";
import getUser from "./getUser.ts";

console.log("Hello from Functions!");

serve(async (req: Request) => {
  let data;
  let error: PostgrestError | null = null;

  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Set the Auth context of the user that called the function.
    // This way your row-level-security (RLS) policies are applied.
    supabaseClient.auth.setAuth(
      req.headers.get("Authorization")!.replace("Bearer ", "")
    );

    const res = await req.json();
    const user_id: string = res.user_id;
    const user_role: string | null = res.user_role ?? "";

    switch (user_role) {
      case "responsible": {
        const res = await getResponsibleUser(user_id);
        data = res.data;
        error = res.error;
        break;
      }
      case "patient": {
        const res = await getPatientUser(user_id);
        data = res.data;
        error = res.error;
        break;
      }
      case "therapist": {
        const res = await getTherapistUser(user_id);
        data = res.data;
        error = res.error;
        break;
      }
      default:
        {
          const res = await getUser(user_id);
          data = res.data;
          error = res.error;
        }
        break;
    }

    return new Response(JSON.stringify({ data, error }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 400,
    });
  }
});

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24ifQ.625_WdcF3KHqz5amU0x2X5WWHP-OEs_4qj0ssLNHzTs' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
