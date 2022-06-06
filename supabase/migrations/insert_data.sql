insert into public.user (
        id,
        full_name,
        email,
        cpf,
        cellphone,
        created_at,
        updated_at,
        image_url
    )
values (
        'cadfacf2-4927-4e95-8822-59199557228e',
        'Lucas Paciente',
        'lucashpolazzo2013@gmail.com',
        '79793690097',
        '84986489498',
        '2022-04-20 02:12:10.214455 +00:00',
        '2022-04-20 02:12:10.214455 +00:00',
        ''
    ),
    (
        '835c6bf6-30af-47d0-ac4f-83e02680f105',
        'Alencar Moreira',
        'alencar@gmail.com',
        '73348465087',
        '51454584584',
        '2022-04-24 23:26:02.791980 +00:00',
        '2022-04-24 23:26:02.791980 +00:00',
        ''
    ),
    (
        'ecfac25d-3941-40b3-a949-ffefb019b52d',
        'New Patient',
        'newpatient@gmail.com',
        '27314775044',
        '78484848484',
        '2022-04-25 00:52:55.953303 +00:00',
        '2022-04-25 00:52:55.953303 +00:00',
        ''
    ),
    (
        'bd6d430e-e067-4b87-9749-627f9cf17b7c',
        'Paciente A',
        'pacientea@gmail.com',
        '74220682058',
        '48748484848',
        '2022-04-25 01:00:57.588059 +00:00',
        '2022-04-25 01:00:57.588059 +00:00',
        ''
    ),
    (
        '5c68ce06-f559-49c1-b0c6-610413813b7c',
        'Alexandre Ap',
        'lsudhsh@irjfjf.com',
        '03446780165',
        '41664656465',
        '2022-04-22 02:00:42.629202 +00:00',
        '2022-04-22 02:00:42.629202 +00:00',
        ''
    ),
    (
        '7fc38961-92b0-4bd5-bd56-d10a3ad78bec',
        'Julio Terapeuta',
        'jkq2000@gmail.com',
        '29318160003',
        '12387182738',
        '2022-04-18 23:41:16.611845 +00:00',
        '2022-04-18 23:41:16.611845 +00:00',
        ''
    ),
    (
        'eea76d53-d673-470b-9558-c128a72f5d1c',
        'Novo Paciente',
        'novopaciente@gmail.com',
        '09756024038',
        '48748488488',
        '2022-04-25 00:28:30.001381 +00:00',
        '2022-04-25 00:28:30.001381 +00:00',
        ''
    ),
    (
        'f74e69e4-0c68-49cc-a49b-caf9339128e2',
        'Lucas Admin',
        'admin@polazzo.dev',
        '19136474045',
        '4199912345',
        '2022-04-13 01:19:59.000000 +00:00',
        '2022-04-13 01:19:59.000000 +00:00',
        ''
    ),
    (
        'f6249935-f8e4-45c4-a0d3-d2bf346d64d2',
        'Fulano Jorger',
        'fj@juliokrause.com',
        '29697124078',
        '3030303030',
        '2022-05-29 23:04:43.570858 +00:00',
        '2022-05-29 23:04:43.570858 +00:00',
        ''
    ),
    (
        '4359f7bc-62bb-4a36-87b3-f394a96aedbb',
        'Polazzo Terapeuta',
        'polaziter@juliokrause.com',
        '07967058011',
        '3030303030',
        '2022-05-30 00:50:10.120888 +00:00',
        '2022-05-30 00:50:10.120888 +00:00',
        ''
    ),
    (
        'df006e3d-18c6-4a86-8aa6-6e79c35c8413',
        'Responsavel Vinte',
        'email@email.com',
        '98385315020',
        '49999999999',
        '2022-05-29 22:51:41.709663 +00:00',
        '2022-05-29 22:51:41.709663 +00:00',
        ''
    );
insert into public.therapist_patient (
        id,
        active,
        created_at,
        updated_at,
        patient_user_id,
        therapist_user_id,
        xp
    )
values (
        'ec13e1e6-47d3-425b-891d-a45dd0370ac8',
        true,
        '2022-04-24 19:27:00.613575 +00:00',
        '2022-04-24 19:27:00.613575 +00:00',
        'cadfacf2-4927-4e95-8822-59199557228e',
        '7fc38961-92b0-4bd5-bd56-d10a3ad78bec',
        0
    ),
    (
        '1570dd7c-77b2-4af1-8b17-7c7c464c5868',
        true,
        '2022-04-25 01:00:57.664343 +00:00',
        '2022-04-25 01:00:57.664343 +00:00',
        'bd6d430e-e067-4b87-9749-627f9cf17b7c',
        'f74e69e4-0c68-49cc-a49b-caf9339128e2',
        0
    ),
    (
        '50a246ed-d2f7-4de2-92f5-86b5665eff85',
        true,
        '2022-05-27 02:11:38.461079 +00:00',
        '2022-05-27 02:11:38.461079 +00:00',
        'eea76d53-d673-470b-9558-c128a72f5d1c',
        'f74e69e4-0c68-49cc-a49b-caf9339128e2',
        0
    ),
    (
        '2b811c0d-b998-4d36-b6db-fbe3d14eceec',
        true,
        '2022-05-29 23:13:58.368432 +00:00',
        '2022-05-29 23:13:58.368432 +00:00',
        'f6249935-f8e4-45c4-a0d3-d2bf346d64d2',
        '835c6bf6-30af-47d0-ac4f-83e02680f105',
        0
    ),
    (
        'fc2e9a2a-3307-4fac-80d4-bfe2bd29bd35',
        true,
        '2022-05-29 22:51:41.822804 +00:00',
        '2022-05-29 22:51:41.822804 +00:00',
        'df006e3d-18c6-4a86-8aa6-6e79c35c8413',
        'f74e69e4-0c68-49cc-a49b-caf9339128e2',
        0
    );
insert into public.task (
        id,
        therapist_patient_id,
        status,
        task,
        xp,
        created_at,
        updated_at
    )
values (
        'f6726b9c-9cc2-47e5-8628-ff81e7aeddc7',
        'ec13e1e6-47d3-425b-891d-a45dd0370ac8',
        'todo',
        'Task do Julio',
        3,
        '2022-05-26 23:36:54.000000 +00:00',
        '2022-05-26 23:36:54.000000 +00:00'
    );
insert into public.therapist_patient_user (id, therapist_patient_id, responsible_user_id)
values (
        'd5d46009-a85a-4ad1-bbe3-91e7cc52163e',
        '50a246ed-d2f7-4de2-92f5-86b5665eff85',
        'df006e3d-18c6-4a86-8aa6-6e79c35c8413'
    );
insert into public.address (
        id,
        user_id,
        street,
        number,
        zip_code,
        city,
        state,
        country,
        district,
        created_at,
        updated_at,
        complement
    )
values (
        'abd3fdc2-75f9-4624-9d4f-ca25a0f6be03',
        '7fc38961-92b0-4bd5-bd56-d10a3ad78bec',
        'Rua João Alencar Guimarães',
        '1234',
        '80310420',
        'Curitiba',
        'PR',
        'Brasil',
        'Santa Quitéria',
        '2022-04-18 23:41:16.898790 +00:00',
        '2022-04-18 23:41:16.898790 +00:00',
        ''
    ),
    (
        'e4e954d3-c0b2-408d-8248-8ec09a0c9151',
        'cadfacf2-4927-4e95-8822-59199557228e',
        'Travessa Graciosa',
        '1200',
        '80035200',
        'Curitiba',
        'PR',
        'Brasil',
        'Cabral',
        '2022-04-20 02:12:10.411161 +00:00',
        '2022-04-20 02:12:10.411161 +00:00',
        'Apto 1'
    ),
    (
        '252571d7-ea6c-4083-9bad-d0d3f5849ffb',
        '5c68ce06-f559-49c1-b0c6-610413813b7c',
        'Rua Coronel Amazonas Marcondes',
        '123465',
        '80035230',
        'Curitiba',
        'PR',
        'Brasil',
        'Cabral',
        '2022-04-22 02:00:42.823496 +00:00',
        '2022-04-22 02:00:42.823496 +00:00',
        ''
    ),
    (
        '230e9ca7-598c-4ac2-897e-827ff972beea',
        'f74e69e4-0c68-49cc-a49b-caf9339128e2',
        'Rua dos Açores',
        '1234',
        '80015215',
        'Curitiba',
        'PR',
        'Brasil',
        'Centro',
        '2022-04-14 12:58:26.000000 +00:00',
        '2022-04-14 12:58:26.000000 +00:00',
        'Compt'
    );
insert into public.role (
        id,
        name,
        can_manage_therapists,
        can_manage_patients,
        can_manage_responsibles,
        can_manage_patient_therapist_relationships,
        can_manage_appointments,
        can_manage_tasks,
        can_manage_achivements,
        can_manage_rewards,
        created_at,
        updated_at
    )
values (
        '0bfb1fa8-ac48-4c59-92dd-716219a60a8b',
        'admin',
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        '2022-04-13 00:52:35.000000 +00:00',
        '2022-04-13 00:52:35.000000 +00:00'
    ),
    (
        'c3b4e826-403c-4076-9b8f-078d1070ccd7',
        'therapist',
        false,
        true,
        true,
        true,
        true,
        true,
        false,
        false,
        '2022-04-17 20:57:37.000000 +00:00',
        '2022-04-17 20:57:37.000000 +00:00'
    ),
    (
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'patient',
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        '2022-04-17 20:58:38.000000 +00:00',
        '2022-04-17 20:58:38.000000 +00:00'
    ),
    (
        '487db6c0-2836-4c28-8b1c-a760a1b65f23',
        'responsible',
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        '2022-04-17 20:59:11.000000 +00:00',
        '2022-04-17 20:59:11.000000 +00:00'
    );
insert into public.user_role (id, role_id, user_id)
values (
        '7088cf9d-249b-407c-93dc-92c54a1df60f',
        '0bfb1fa8-ac48-4c59-92dd-716219a60a8b',
        'f74e69e4-0c68-49cc-a49b-caf9339128e2'
    ),
    (
        '7ca17c61-9e2f-4f1a-8c9d-34d0b83aa972',
        'c3b4e826-403c-4076-9b8f-078d1070ccd7',
        '7fc38961-92b0-4bd5-bd56-d10a3ad78bec'
    ),
    (
        'b8e23b89-17e5-4dfa-852a-f4407c5b871d',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'cadfacf2-4927-4e95-8822-59199557228e'
    ),
    (
        'e5e70976-399a-46f7-be66-c6e6107559fe',
        'c3b4e826-403c-4076-9b8f-078d1070ccd7',
        '5c68ce06-f559-49c1-b0c6-610413813b7c'
    ),
    (
        'f49db259-4ea7-48b7-a157-c072f0cdf61a',
        'c3b4e826-403c-4076-9b8f-078d1070ccd7',
        '835c6bf6-30af-47d0-ac4f-83e02680f105'
    ),
    (
        'e53c2226-65f7-435e-9e37-b2135cfea52d',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'eea76d53-d673-470b-9558-c128a72f5d1c'
    ),
    (
        'd819d107-d656-4964-b04f-20ad007cd3e7',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'ecfac25d-3941-40b3-a949-ffefb019b52d'
    ),
    (
        '097f330b-ecc3-48d4-9033-904a84c1b204',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'bd6d430e-e067-4b87-9749-627f9cf17b7c'
    ),
    (
        'fe3f64a8-6634-4e87-9da4-7a6684bdbe90',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'f74e69e4-0c68-49cc-a49b-caf9339128e2'
    ),
    (
        'e8cca733-cfeb-46f4-9dde-702c9de59131',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'df006e3d-18c6-4a86-8aa6-6e79c35c8413'
    ),
    (
        '1165a214-c45e-4c5d-b808-f2679cd24b4d',
        'aeecee0d-5557-4292-9780-3b7a38cb8d98',
        'f6249935-f8e4-45c4-a0d3-d2bf346d64d2'
    ),
    (
        '13caa788-65f4-4e3f-9da4-3b9ed5bce084',
        'c3b4e826-403c-4076-9b8f-078d1070ccd7',
        '4359f7bc-62bb-4a36-87b3-f394a96aedbb'
    );
insert into public.appointment (
        id,
        therapist_patient_id,
        date,
        patient_report,
        responsible_report,
        status,
        created_at,
        updated_at,
        xp,
        therapist_report
    )
values (
        'bed4914d-9ff6-479d-b485-a1ebbca9f89f',
        'fc2e9a2a-3307-4fac-80d4-bfe2bd29bd35',
        '2022-06-10 17:00:00.000000 +00:00',
        '',
        '',
        'todo',
        '2022-05-29 23:40:53.000000 +00:00',
        '2022-05-29 23:40:53.000000 +00:00',
        5,
        ''
    );