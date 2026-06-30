-- Seed admin user via Supabase Auth + profiles
DO $$
DECLARE
    admin_id UUID;
    user1_id UUID;
    user2_id UUID;
BEGIN
    admin_id := gen_random_uuid();
    user1_id := gen_random_uuid();
    user2_id := gen_random_uuid();

    -- Insert directly into auth.users for local development
    INSERT INTO auth.users (
        instance_id, id, aud, role, email, encrypted_password,
        email_confirmed_at, created_at, updated_at, raw_app_meta_data,
        raw_user_meta_data, confirmation_token, recovery_token, email_change_token_new,
        email_change, is_sso_user
    ) VALUES
    (
        '00000000-0000-0000-0000-000000000000', admin_id, 'authenticated', 'authenticated',
        'admin@progrese.dev', crypt('Admin123!', gen_salt('bf')),
        now(), now(), now(),
        '{"provider":"email","providers":["email"]}',
        '{"display_name":"Administrador"}',
        '', '', '', '', false
    ),
    (
        '00000000-0000-0000-0000-000000000000', user1_id, 'authenticated', 'authenticated',
        'usuario1@progrese.dev', crypt('User1234!', gen_salt('bf')),
        now(), now(), now(),
        '{"provider":"email","providers":["email"]}',
        '{"display_name":"Usuario Uno"}',
        '', '', '', '', false
    ),
    (
        '00000000-0000-0000-0000-000000000000', user2_id, 'authenticated', 'authenticated',
        'usuario2@progrese.dev', crypt('User1234!', gen_salt('bf')),
        now(), now(), now(),
        '{"provider":"email","providers":["email"]}',
        '{"display_name":"Usuario Dos"}',
        '', '', '', '', false
    );

    -- Update admin profile role
    UPDATE public.user_profiles SET role = 'admin' WHERE id = admin_id;

    -- Insert profile for admin (trigger would have done this, but just in case)
    INSERT INTO public.user_profiles (id, display_name, role, is_active)
    VALUES (admin_id, 'Administrador', 'admin', true)
    ON CONFLICT (id) DO NOTHING;

    -- Ensure user1 and user2 profiles exist
    INSERT INTO public.user_profiles (id, display_name, role, is_active)
    VALUES (user1_id, 'Usuario Uno', 'user', true)
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.user_profiles (id, display_name, role, is_active)
    VALUES (user2_id, 'Usuario Dos', 'user', true)
    ON CONFLICT (id) DO NOTHING;
END;
$$;
