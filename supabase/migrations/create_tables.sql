create table achievement
(
    id         varchar(36)              default uuid_generate_v4() not null
        constraint achievement_pk
            primary key,
    name       varchar(100)                                        not null,
    image      text                                                not null,
    created_at timestamp with time zone default now()              not null,
    updated_at timestamp with time zone default now()              not null
);

alter table achievement
    owner to supabase_admin;

grant delete, insert, references, select, trigger, truncate, update on achievement to postgres;

grant delete, insert, references, select, trigger, truncate, update on achievement to anon;

grant delete, insert, references, select, trigger, truncate, update on achievement to authenticated;

grant delete, insert, references, select, trigger, truncate, update on achievement to service_role;

create table role
(
    id                                         varchar(36)              default uuid_generate_v4() not null
        constraint role_pk
            primary key,
    name                                       varchar(100)                                        not null,
    can_manage_therapists                      boolean                  default false              not null,
    can_manage_patients                        boolean                  default false              not null,
    can_manage_responsibles                    boolean                  default false              not null,
    can_manage_patient_therapist_relationships boolean                  default false              not null,
    can_manage_appointments                    boolean                  default false              not null,
    can_manage_tasks                           boolean                  default false              not null,
    can_manage_achivements                     boolean                  default false              not null,
    can_manage_rewards                         boolean                  default false              not null,
    created_at                                 timestamp with time zone default now()              not null,
    updated_at                                 timestamp with time zone default now()              not null
);

alter table role
    owner to supabase_admin;

grant delete, insert, references, select, trigger, truncate, update on role to postgres;

grant delete, insert, references, select, trigger, truncate, update on role to anon;

grant delete, insert, references, select, trigger, truncate, update on role to authenticated;

grant delete, insert, references, select, trigger, truncate, update on role to service_role;

create table "user"
(
    id         varchar(36)              default uuid_generate_v4() not null
        constraint user_pk
            primary key,
    full_name  varchar(255)                                        not null,
    email      varchar(255)                                        not null,
    cpf        varchar(11)                                         not null,
    cellphone  varchar(25)                                         not null,
    created_at timestamp with time zone default now()              not null,
    updated_at timestamp with time zone default now()              not null,
    image_url  text
);

alter table "user"
    owner to supabase_admin;

create table achivement_user
(
    id              varchar(36) default uuid_generate_v4() not null
        constraint achivement_user_pk
            primary key,
    achievement_id  varchar(36)                            not null
        constraint achivement_patient_achievement
            references achievement,
    patient_user_id varchar(36)                            not null
        constraint achivement_patient_user
            references "user"
);

alter table achivement_user
    owner to supabase_admin;

create unique index achivement_user_ak_1
    on achivement_user (achievement_id, patient_user_id);

grant delete, insert, references, select, trigger, truncate, update on achivement_user to postgres;

grant delete, insert, references, select, trigger, truncate, update on achivement_user to anon;

grant delete, insert, references, select, trigger, truncate, update on achivement_user to authenticated;

grant delete, insert, references, select, trigger, truncate, update on achivement_user to service_role;

create table address
(
    id         varchar(36)              default uuid_generate_v4() not null
        constraint address_pk
            primary key,
    user_id    varchar(36)                                         not null
        constraint address_user
            references "user",
    street     varchar(200)                                        not null,
    number     varchar(20)                                         not null,
    zip_code   varchar(20)                                         not null,
    city       varchar(100)                                        not null,
    state      varchar(2)                                          not null,
    country    varchar(30)                                         not null,
    district   varchar(100)                                        not null,
    created_at timestamp with time zone default now()              not null,
    updated_at timestamp with time zone default now()              not null,
    complement varchar(100)
);

alter table address
    owner to supabase_admin;

create unique index address_ak_1
    on address (user_id);

grant delete, insert, references, select, trigger, truncate, update on address to postgres;

grant delete, insert, references, select, trigger, truncate, update on address to anon;

grant delete, insert, references, select, trigger, truncate, update on address to authenticated;

grant delete, insert, references, select, trigger, truncate, update on address to service_role;

create table reward
(
    id                varchar(36)              default uuid_generate_v4() not null
        constraint reward_pk
            primary key,
    needed_xp         integer                                             not null,
    name              integer                                             not null,
    created_at        timestamp with time zone default now()              not null,
    updated_at        timestamp with time zone default now()              not null,
    therapist_user_id varchar(36)                                         not null
        constraint reward_user
            references "user",
    active            boolean                  default false              not null,
    image_url         text
);

alter table reward
    owner to supabase_admin;

grant delete, insert, references, select, trigger, truncate, update on reward to postgres;

grant delete, insert, references, select, trigger, truncate, update on reward to anon;

grant delete, insert, references, select, trigger, truncate, update on reward to authenticated;

grant delete, insert, references, select, trigger, truncate, update on reward to service_role;

create table reward_user
(
    id              varchar(36)              default uuid_generate_v4() not null
        constraint reward_user_pk
            primary key,
    reward_id       varchar(36)                                         not null
        constraint reward_patient_reward
            references reward,
    patient_user_id varchar(36)                                         not null
        constraint reward_patient_user
            references "user",
    created_at      timestamp with time zone default now()              not null
);

alter table reward_user
    owner to supabase_admin;

grant delete, insert, references, select, trigger, truncate, update on reward_user to postgres;

grant delete, insert, references, select, trigger, truncate, update on reward_user to anon;

grant delete, insert, references, select, trigger, truncate, update on reward_user to authenticated;

grant delete, insert, references, select, trigger, truncate, update on reward_user to service_role;

create table therapist_patient
(
    id                varchar(36)              default uuid_generate_v4() not null
        constraint therapist_patient_pk
            primary key,
    active            boolean                  default true               not null,
    created_at        timestamp with time zone default now()              not null,
    updated_at        timestamp with time zone default now()              not null,
    patient_user_id   varchar(36)                                         not null
        constraint patient_user_id
            references "user",
    therapist_user_id varchar(36)                                         not null
        constraint therapist_user_id
            references "user",
    xp                integer                  default 0
);

alter table therapist_patient
    owner to supabase_admin;

create table appointment
(
    id                   varchar(36)              default uuid_generate_v4()        not null
        constraint appointment_pk
            primary key,
    therapist_patient_id varchar(36)                                                not null
        constraint appointment_therapist_patient
            references therapist_patient,
    date                 timestamp with time zone                                   not null,
    patient_report       text                     default ''::text                  not null,
    responsible_report   text                     default ''::text                  not null,
    status               varchar(20)              default 'todo'::character varying not null,
    created_at           timestamp with time zone default now()                     not null,
    updated_at           timestamp with time zone default now()                     not null,
    xp                   integer                  default 5,
    therapist_report     text                     default ''::text                  not null
);

alter table appointment
    owner to supabase_admin;

create index appointment_therapist_patient
    on appointment (therapist_patient_id);

grant delete, insert, references, select, trigger, truncate, update on appointment to postgres;

grant delete, insert, references, select, trigger, truncate, update on appointment to anon;

grant delete, insert, references, select, trigger, truncate, update on appointment to authenticated;

grant delete, insert, references, select, trigger, truncate, update on appointment to service_role;

create table task
(
    id                   varchar(36)              default uuid_generate_v4() not null
        constraint task_pk
            primary key,
    therapist_patient_id varchar(36)                                         not null
        constraint task_therapist_patient
            references therapist_patient,
    status               varchar(20)                                         not null,
    task                 varchar(255)                                        not null,
    xp                   integer                  default 3                  not null,
    created_at           timestamp with time zone default now()              not null,
    updated_at           timestamp with time zone default now()              not null
);

alter table task
    owner to supabase_admin;

create index task_therapist_patient
    on task (therapist_patient_id);

grant delete, insert, references, select, trigger, truncate, update on task to postgres;

grant delete, insert, references, select, trigger, truncate, update on task to anon;

grant delete, insert, references, select, trigger, truncate, update on task to authenticated;

grant delete, insert, references, select, trigger, truncate, update on task to service_role;

create unique index therapist_patient_index
    on therapist_patient (therapist_user_id, patient_user_id);

grant delete, insert, references, select, trigger, truncate, update on therapist_patient to postgres;

grant delete, insert, references, select, trigger, truncate, update on therapist_patient to anon;

grant delete, insert, references, select, trigger, truncate, update on therapist_patient to authenticated;

grant delete, insert, references, select, trigger, truncate, update on therapist_patient to service_role;

create table therapist_patient_user
(
    id                   varchar(36) default uuid_generate_v4() not null
        constraint therapist_patient_user_pk
            primary key,
    therapist_patient_id varchar(36)                            not null
        constraint therapist_patient_responsible_relation
            references therapist_patient,
    responsible_user_id  varchar(36)                            not null
        constraint therapist_patient_patient_user
            references "user"
);

alter table therapist_patient_user
    owner to supabase_admin;

create unique index therapist_patient_user_ak_1
    on therapist_patient_user (therapist_patient_id, responsible_user_id);

grant delete, insert, references, select, trigger, truncate, update on therapist_patient_user to postgres;

grant delete, insert, references, select, trigger, truncate, update on therapist_patient_user to anon;

grant delete, insert, references, select, trigger, truncate, update on therapist_patient_user to authenticated;

grant delete, insert, references, select, trigger, truncate, update on therapist_patient_user to service_role;

create unique index user_ak_1
    on "user" (email);

create unique index user_ak_2
    on "user" (cpf);

grant delete, insert, references, select, trigger, truncate, update on "user" to postgres;

grant delete, insert, references, select, trigger, truncate, update on "user" to anon;

grant delete, insert, references, select, trigger, truncate, update on "user" to authenticated;

grant delete, insert, references, select, trigger, truncate, update on "user" to service_role;

create table user_role
(
    id      varchar(36) default uuid_generate_v4() not null
        constraint user_role_pk
            primary key,
    role_id varchar(36)                            not null
        constraint user_role_role
            references role,
    user_id varchar(36)                            not null
        constraint user_role_user
            references "user"
);

alter table user_role
    owner to supabase_admin;

create unique index user_role_ak_1
    on user_role (role_id, user_id);

grant delete, insert, references, select, trigger, truncate, update on user_role to postgres;

grant delete, insert, references, select, trigger, truncate, update on user_role to anon;

grant delete, insert, references, select, trigger, truncate, update on user_role to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_role to service_role;

