CREATE TABLE "public"."enquierer" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "last_name" text NOT NULL, "email" text NOT NULL, "phone_number" text, PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_enquierer_updated_at"
BEFORE UPDATE ON "public"."enquierer"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_enquierer_updated_at" ON "public"."enquierer" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
