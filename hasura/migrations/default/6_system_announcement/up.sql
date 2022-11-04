-- System Announcement Table
CREATE TABLE "public"."system_announcement" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
  "title" text NOT NULL, 
  "content" text NOT NULL, 
  "schedule" timestamptz NOT NULL, 
  "type" text NOT NULL, 
  "topics" jsonb, 
  "recipients" jsonb, 
  "by_topic" boolean NOT NULL DEFAULT false, 
  "data" jsonb NOT NULL, 
  "created_by_id" uuid NOT NULL, 
  "state" text NOT NULL DEFAULT 'Pending', 
  "status" text NOT NULL DEFAULT 'Active', 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  PRIMARY KEY ("id") , 
  FOREIGN KEY ("type") REFERENCES "public"."system_announcement_type"("value") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("created_by_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("state") REFERENCES "public"."generic_state"("value") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("status") REFERENCES "public"."generic_status"("value") ON UPDATE restrict ON DELETE restrict
);

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
CREATE TRIGGER "set_public_system_announcement_updated_at"
BEFORE UPDATE ON "public"."system_announcement"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_system_announcement_updated_at" ON "public"."system_announcement" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;



-- Email Tamplate Table
CREATE TABLE "public"."email_template" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
  "name" text NOT NULL, 
  "description" text, 
  "content" text NOT NULL, 
  "created_by_id" uuid NOT NULL, 
  "status" text NOT NULL DEFAULT 'Active', 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  PRIMARY KEY ("id") , 
  FOREIGN KEY ("created_by_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("status") REFERENCES "public"."generic_status"("value") ON UPDATE restrict ON DELETE restrict
);

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
CREATE TRIGGER "set_public_email_template_updated_at"
BEFORE UPDATE ON "public"."email_template"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_email_template_updated_at" ON "public"."email_template" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
