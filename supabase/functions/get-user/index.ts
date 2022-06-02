// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import { supabaseClient } from '../_shared/supabaseClient.ts';
import { corsHeaders } from '../_shared/cors.ts';
import { PostgrestError } from "https://esm.sh/v84/@supabase/supabase-js@1.35.3/dist/module/index";

console.log("Hello from Functions!")

serve(async (req: Request) => {
  let data;
  let error: PostgrestError | null;

  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Set the Auth context of the user that called the function.
    // This way your row-level-security (RLS) policies are applied.
    supabaseClient.auth.setAuth(req.headers.get('Authorization')!.replace('Bearer ', ''))

    let { user_id, user_role } = await req.json();

    if (user_role == null) {
      const { data, error } = await supabaseClient.from('user').select('id, user_role:role!inner(name)').eq('id', user_id).select('role').single();
      console.log({ data, error })
      user_role = data.user_role.name;
    }

    // switch (user_role) {
    //   case 'responsible':
    const res = await supabaseClient.from('user').select(`
    *,
    address(*),
    role_user:role(*),
    therapist_patient_user:therapist_patient_patient_user(therapist_patient_id),
    therapist_patient:patient_user_id(*)
`).eq('id', user_id).single();
    data = res.data;
    error = res.error;

    if(data == null) throw new Error('User not found')

    data.therapist_patient = data.therapist_patient.isEmpty ? {} : data.therapist_patient[0]

    console.log({ data, error })

    const resTherapistPatientsResponsible = await supabaseClient.from('therapist_patient').select('*').in('id', data.therapist_patient_user.map((e: { therapist_patient_id: string; }) => e.therapist_patient_id));

    data.therapist_patients_responsible = resTherapistPatientsResponsible.data;
    delete data.therapist_patient_user;
    error = resTherapistPatientsResponsible.error;
    console.log({ data, error })

    const usersId = new Set<string>([data.therapist_patient.therapist_user_id]);

    data.therapist_patients_responsible.forEach((e: { patient_user_id: string; therapist_user_id: string; }) => {
      usersId.add(e.patient_user_id);
      usersId.add(e.therapist_user_id);
    });

    const resUsers = await supabaseClient.from('user').select('*').in('id', Array.from(usersId));

    const users = resUsers.data;
    error = resUsers.error;
    console.log({ data, error });

    if (users instanceof Array) {
      data.therapist_patients_responsible = data.therapist_patients_responsible.map((e: { patient_user_id: string; therapist_user_id: string; }) => {
        const patient = users.find((e2: { id: string; }) => e2.id === e.patient_user_id);
        const therapist = users.find((e2: { id: string; }) => e2.id === e.therapist_user_id);
        return { ...e, patient, therapist };
      });
      const therapistUserId = data.therapist_patient.therapist_user_id;
      data.therapist_patient.therapist = therapistUserId ? users.find((e: { id: string; }) => e.id === therapistUserId) : null;
    }

    console.log({ data, error })

    //     break;
    //   default:
    //     break;
    // }

    return new Response(JSON.stringify({ data, error }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})

// function organizeDataResultInObjects(data: any) {
//   const result = {};
//   for (const key in data) {
//     if(key.includes('therapist_')) {
//       result[key.replace('therapist_', '')] = data[key]; 
//     }
//   }
//   return result;
// }

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24ifQ.625_WdcF3KHqz5amU0x2X5WWHP-OEs_4qj0ssLNHzTs' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
