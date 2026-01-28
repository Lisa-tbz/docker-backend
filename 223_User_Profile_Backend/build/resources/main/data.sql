-- =====================================================
-- USERS
-- =====================================================

INSERT INTO users (id, email, first_name, last_name, password)
VALUES
    (
        'ba804cb9-fa14-42a5-afaf-be488742fc54',
        'admin@example.com',
        'James',
        'Bond',
        '$2a$10$TM3PAYG3b.H98cbRrHqWa.BM7YyCqV92e/kUTBfj85AjayxGZU7d6'
    )
ON CONFLICT DO NOTHING;

-- =====================================================
-- ROLES
-- =====================================================

INSERT INTO role (id, name)
VALUES
    ('d29e709c-0ff1-4f4c-a7ef-09f656c390f1', 'DEFAULT'),
    ('ab505c92-7280-49fd-a7de-258e618df074', 'ADMIN'),
    ('c6aee32d-8c35-4481-8b3e-a876a39b0c02', 'USER')
ON CONFLICT DO NOTHING;

-- =====================================================
-- AUTHORITIES
-- =====================================================

INSERT INTO authority (id, name)
VALUES
    ('2ebf301e-6c61-4076-98e3-2a38b31daf86', 'USER_CREATE'),
    ('76d2cbf6-5845-470e-ad5f-2edb9e09a868', 'USER_READ'),
    ('21c942db-a275-43f8-bdd6-d048c21bf5ab', 'USER_DEACTIVATE'),
    ('b964fc23-9fea-4ba2-9000-94fad5f0dbe0', 'USER_MODIFY'),
    ('6e12227a-f6bf-4529-86d1-df9b41fe28fb', 'USER_DELETE_OWN_PROFILE'),
    ('c1391159-1dac-4ab9-8f9d-dd24e36b232c', 'USER_READ_OWN_PROFILE')
ON CONFLICT DO NOTHING;

-- =====================================================
-- USER ↔ ROLE
-- =====================================================

INSERT INTO users_role (users_id, role_id)
VALUES
    ('ba804cb9-fa14-42a5-afaf-be488742fc54', 'd29e709c-0ff1-4f4c-a7ef-09f656c390f1'),
    ('ba804cb9-fa14-42a5-afaf-be488742fc54', 'ab505c92-7280-49fd-a7de-258e618df074'),
    ('ba804cb9-fa14-42a5-afaf-be488742fc54', 'c6aee32d-8c35-4481-8b3e-a876a39b0c02')
ON CONFLICT DO NOTHING;

-- =====================================================
-- ROLE ↔ AUTHORITY
-- =====================================================

-- DEFAULT
INSERT INTO role_authority (role_id, authority_id)
VALUES
    ('d29e709c-0ff1-4f4c-a7ef-09f656c390f1', '2ebf301e-6c61-4076-98e3-2a38b31daf86')
ON CONFLICT DO NOTHING;

-- USER
INSERT INTO role_authority (role_id, authority_id)
VALUES
    ('c6aee32d-8c35-4481-8b3e-a876a39b0c02', 'b964fc23-9fea-4ba2-9000-94fad5f0dbe0'),
    ('c6aee32d-8c35-4481-8b3e-a876a39b0c02', '6e12227a-f6bf-4529-86d1-df9b41fe28fb')
ON CONFLICT DO NOTHING;

-- USER_READ_OWN_PROFILE → USER
INSERT INTO role_authority (role_id, authority_id)
SELECT
    'c6aee32d-8c35-4481-8b3e-a876a39b0c02',
    a.id
FROM authority a
WHERE a.name = 'USER_READ_OWN_PROFILE'
ON CONFLICT DO NOTHING;

-- ADMIN
INSERT INTO role_authority (role_id, authority_id)
SELECT
    'ab505c92-7280-49fd-a7de-258e618df074',
    a.id
FROM authority a
ON CONFLICT DO NOTHING;

-- =====================================================
-- USER PROFILES
-- =====================================================

INSERT INTO user_profiles (id, user_id, address, birth_date, profile_image_url)
VALUES
    ('1631fc80-3489-4320-8f4d-9bdf3d926720', 'ba804cb9-fa14-42a5-afaf-be488742fc54', 'Secret Street 007', '1980-01-01', 'https://example.com/bond.png')
ON CONFLICT DO NOTHING;




-- =====================================================
-- RANDOM SINGLE USER
-- =====================================================

INSERT INTO users (id, email, first_name, last_name, password)
VALUES (
           '5248b9aa-e46c-4ce6-af8b-f3488c74c86d',
           'random.user42@example.com',
           'Random',
           'User42',
           '$2a$10$TM3PAYG3b.H98cbRrHqWa.BM7YyCqV92e/kUTBfj85AjayxGZU7d6' -- Password: 1234
       )
ON CONFLICT DO NOTHING;

INSERT INTO users_role (users_id, role_id)
VALUES (
           '5248b9aa-e46c-4ce6-af8b-f3488c74c86d',
           'c6aee32d-8c35-4481-8b3e-a876a39b0c02' -- USER
       )
ON CONFLICT DO NOTHING;

INSERT INTO user_profiles (id, user_id, address, birth_date, profile_image_url)
VALUES (
           '65908406-860f-44f7-aebe-83ad20e1a021',
           '5248b9aa-e46c-4ce6-af8b-f3488c74c86d',
           'Random Street 42',
           '2000-06-15',
           NULL
       )
ON CONFLICT DO NOTHING;

-- =====================================================
-- USER: example@example.com
-- Password: 1234
-- =====================================================

-- USER
INSERT INTO users (id, email, first_name, last_name, password)
VALUES (
           '8b7c2c5f-9a3e-4e6a-bc8a-1f0d9b8e7c11',
           'example@example.com',
           'Example',
           'User',
           '$2a$10$TM3PAYG3b.H98cbRrHqWa.BM7YyCqV92e/kUTBfj85AjayxGZU7d6'
       )
ON CONFLICT DO NOTHING;

-- ROLE: USER
INSERT INTO users_role (users_id, role_id)
VALUES (
           '8b7c2c5f-9a3e-4e6a-bc8a-1f0d9b8e7c11',
           'c6aee32d-8c35-4481-8b3e-a876a39b0c02' -- USER
       )
ON CONFLICT DO NOTHING;

-- PROFILE
INSERT INTO user_profiles (id, user_id, address, birth_date, profile_image_url)
VALUES (
           'efc5795a-609d-4c36-9626-1f01efe7b407',
           '8b7c2c5f-9a3e-4e6a-bc8a-1f0d9b8e7c11',
           'Example Street 1',
           '1995-01-01',
           NULL
       )
ON CONFLICT DO NOTHING;
