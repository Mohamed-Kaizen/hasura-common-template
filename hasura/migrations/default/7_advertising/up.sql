CREATE TABLE "public"."advertising" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
  "title" text NOT NULL, 
  "description" text NOT NULL, 
  "file_url" text, 
  "price" numeric NOT NULL, 
  "index" integer NOT NULL DEFAULT 0, 
  "reference" jsonb, 
  "media_type" text, 
  "status" text NOT NULL DEFAULT 'Active', 
  "start_at" timestamptz NOT NULL, 
  "end_at" timestamptz, 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  PRIMARY KEY ("id") , 
  FOREIGN KEY ("media_type") REFERENCES "public"."media_type"("value") ON UPDATE restrict ON DELETE restrict, 
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
CREATE TRIGGER "set_public_advertising_updated_at"
BEFORE UPDATE ON "public"."advertising"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_advertising_updated_at" ON "public"."advertising" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
