SET check_function_bodies = false;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.enquirer (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    phone_number text
);
CREATE SEQUENCE public.enquirer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.enquirer_id_seq OWNED BY public.enquirer.id;
CREATE TABLE public.provider (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    email text NOT NULL,
    phone_number text
);
CREATE SEQUENCE public.provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.provider_id_seq OWNED BY public.provider.id;
CREATE TABLE public.provider_tags (
    tag text NOT NULL,
    provider_id integer NOT NULL
);
COMMENT ON TABLE public.provider_tags IS 'Indicate what field provider working in';
CREATE TABLE public.quote (
    enquirer_id integer NOT NULL,
    provider_id integer NOT NULL,
    id integer NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.quote IS 'Quotes sent to the providers';
CREATE SEQUENCE public.quote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.quote_id_seq OWNED BY public.quote.id;
CREATE TABLE public.quote_tag (
    quote_id integer NOT NULL,
    tag text NOT NULL
);
CREATE TABLE public.tags (
    id text NOT NULL,
    comment text NOT NULL
);
COMMENT ON TABLE public.tags IS 'material provider tags';
ALTER TABLE ONLY public.enquirer ALTER COLUMN id SET DEFAULT nextval('public.enquirer_id_seq'::regclass);
ALTER TABLE ONLY public.provider ALTER COLUMN id SET DEFAULT nextval('public.provider_id_seq'::regclass);
ALTER TABLE ONLY public.quote ALTER COLUMN id SET DEFAULT nextval('public.quote_id_seq'::regclass);
ALTER TABLE ONLY public.enquirer
    ADD CONSTRAINT enquirer_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.provider_tags
    ADD CONSTRAINT provider_tags_pkey PRIMARY KEY (tag, provider_id);
ALTER TABLE ONLY public.quote
    ADD CONSTRAINT quote_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.quote_tag
    ADD CONSTRAINT quote_tag_pkey PRIMARY KEY (tag, quote_id);
ALTER TABLE ONLY public.quote_tag
    ADD CONSTRAINT quote_tag_quote_id_tag_key UNIQUE (quote_id, tag);
ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_enquirer_updated_at BEFORE UPDATE ON public.enquirer FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_enquirer_updated_at ON public.enquirer IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_provider_updated_at BEFORE UPDATE ON public.provider FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_provider_updated_at ON public.provider IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_quote_updated_at BEFORE UPDATE ON public.quote FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_quote_updated_at ON public.quote IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.provider_tags
    ADD CONSTRAINT provider_tags_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.provider(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.provider_tags
    ADD CONSTRAINT provider_tags_tag_fkey FOREIGN KEY (tag) REFERENCES public.tags(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.quote
    ADD CONSTRAINT quote_enquirer_id_fkey FOREIGN KEY (enquirer_id) REFERENCES public.enquirer(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.quote
    ADD CONSTRAINT quote_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.provider(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.quote_tag
    ADD CONSTRAINT quote_tag_quote_id_fkey FOREIGN KEY (quote_id) REFERENCES public.quote(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.quote_tag
    ADD CONSTRAINT quote_tag_tag_fkey FOREIGN KEY (tag) REFERENCES public.tags(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
