import { PostgrestError } from "https://esm.sh/v84/@supabase/supabase-js@1.35.3/dist/module/index";
import { supabaseClient } from "../_shared/supabaseClient.ts";

export default async function (
  user_id: string
  // deno-lint-ignore no-explicit-any
): Promise<{ data: any; error: PostgrestError | null }> {
  let { data, error } = await supabaseClient
    .from("user")
    .select(
      `
    *,
    address(*),
    roles_user:role(*),
    therapist_patient_user:therapist_patient_patient_user(therapist_patient_id),
    therapist_patient:patient_user_id(*)
`
    )
    .eq("id", user_id)
    .single();

  if (data == null) throw new Error("User not found");

  const userData = structuredClone(data);
  delete userData.address;
  delete userData.roles_user;
  delete userData.therapist_patient_user;
  delete userData.therapist_patient;

  data.therapist_patient =
    data.therapist_patient.length == 0 ? {} : data.therapist_patient[0];

  console.log({ data, error });

  const resTherapistPatientsResponsible = await supabaseClient
    .from("therapist_patient")
    .select("*")
    .in(
      "id",
      data.therapist_patient_user.map(
        (e: { therapist_patient_id: string }) => e.therapist_patient_id
      )
    );

  data.therapist_patients_responsible = resTherapistPatientsResponsible.data;
  delete data.therapist_patient_user;
  error = resTherapistPatientsResponsible.error;
  console.log({ data, error });

  const usersId = new Set<string>([data.therapist_patient.therapist_user_id]);

  data.therapist_patients_responsible.forEach(
    (e: { patient_user_id: string; therapist_user_id: string }) => {
      usersId.add(e.patient_user_id);
      usersId.add(e.therapist_user_id);
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
    data.therapist_patients_responsible =
      data.therapist_patients_responsible.map(
        (e: { patient_user_id: string; therapist_user_id: string }) => {
          const patient = users.find(
            (e2: { id: string }) => e2.id === e.patient_user_id
          );
          const therapist = users.find(
            (e2: { id: string }) => e2.id === e.therapist_user_id
          );
          return { ...e, patient, therapist };
        }
      );
    if (Object.keys(data.therapist_patient).length === 0) {
      delete data.therapist_patient;
    } else {
      const therapistUserId = data.therapist_patient.therapist_user_id;
      data.therapist_patient.therapist = therapistUserId
        ? users.find((e: { id: string }) => e.id === therapistUserId)
        : null;
      data.therapist_patient.patient = userData;
    }
  }

  console.log({ data, error });

  return { data, error };
}
