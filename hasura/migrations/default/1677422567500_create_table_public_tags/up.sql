CREATE TABLE "public"."tags" ("id" text NOT NULL, "comment" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("id"));COMMENT ON TABLE "public"."tags" IS E'material provider tags';
