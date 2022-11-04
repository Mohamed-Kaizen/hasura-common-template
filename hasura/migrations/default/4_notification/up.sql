CREATE TABLE "public"."notification" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
  "title" text NOT NULL, 
  "description" text NOT NULL, 
  "type" text NOT NULL, 
  "user_id" uuid NOT NULL, 
  "object_id" jsonb, 
  "extra_data" jsonb, 
  "unread" boolean NOT NULL DEFAULT true, 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  PRIMARY KEY ("id") , 
  FOREIGN KEY ("type") REFERENCES "public"."notification_type"("value") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict
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
CREATE TRIGGER "set_public_notification_updated_at"
BEFORE UPDATE ON "public"."notification"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_notification_updated_at" ON "public"."notification" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
