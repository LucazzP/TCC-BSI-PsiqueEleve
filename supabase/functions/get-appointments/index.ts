// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import { supabaseClient } from "../_shared/supabaseClient.ts";
import { corsHeaders } from "../_shared/cors.ts";

console.log("Hello from Functions!");

serve(async (req) => {
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

    let { data, error } = await supabaseClient.from("appointment").select(`
        *,
        therapist_patient(*)
      `);

    if (error != null) throw error;
    if (data == null) throw new Error("Appointments error");

    const usersId = new Set<string>();

    data?.forEach(
      (e: {
        therapist_patient: {
          patient_user_id: string;
          therapist_user_id: string;
        };
      }) => {
        usersId.add(e.therapist_patient.patient_user_id);
        usersId.add(e.therapist_patient.therapist_user_id);
      }
    );

    const resUsers = await supabaseClient
      .from("user")
      .select("*")
      .in("id", Array.from(usersId));

    const users = resUsers.data;
    error = resUsers.error;
    console.log({ data, error });

    if (users instanceof Array) {
      for (let index = 0; index < data.length; index++) {
        const therapist_patient = data[index].therapist_patient;
        therapist_patient.patient = users.find(
          (user: { id: string }) =>
            user.id === therapist_patient.patient_user_id
        );
        therapist_patient.therapist = users.find(
          (user: { id: string }) =>
            user.id === therapist_patient.therapist_user_id
        );
        data[index].therapist_patient = therapist_patient;
      }
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
