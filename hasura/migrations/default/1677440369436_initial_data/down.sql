-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- INSERT INTO public.provider (id, created_at, updated_at, name, address, email, phone_number) VALUES (1, '2023-02-26 17:49:33.956992+00', '2023-02-26 19:13:29.947241+00', 'Kmetijstvo in več', 'Ložnica pri Žalcu 45, 3310 Žalec, Slovenija', 'kmetijstvo@invec.si', NULL);
-- INSERT INTO public.enquirer (id, created_at, updated_at, name, last_name, email, phone_number) VALUES (1, '2023-02-26 19:17:19.95915+00', '2023-02-26 19:17:19.95915+00', 'Janez', 'Novak', 'janez@novak.test', NULL);
-- INSERT INTO public.provider_tags (tag, provider_id) VALUES ('PREHRANA_ZIVALI', 1);
-- INSERT INTO public.provider_tags (tag, provider_id) VALUES ('SEMENSKI_MATERIAL', 1);
-- INSERT INTO public.provider_tags (tag, provider_id) VALUES ('GNOJILA_SUBSTRATI', 1);
-- INSERT INTO public.quote (enquirer_id, provider_id, id, description, created_at, updated_at) VALUES (1, 1, 1, 'Potrebujem hrano za krave', '2023-02-26 19:17:51.259124+00', '2023-02-26 19:17:51.259124+00');
-- INSERT INTO public.quote_tag (quote_id, tag) VALUES (1, 'PREHRANA_ZIVALI');
