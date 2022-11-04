-- User Table
CREATE TABLE "public"."user" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "username" text, "email" text, 
  "full_name" text, 
  "phone_number" text, 
  "image_url" text, 
  "email_verified" boolean NOT NULL DEFAULT false, 
  "is_verified" boolean NOT NULL DEFAULT false, 
  "phone_verified" boolean NOT NULL DEFAULT false, 
  "auth_provider" text NOT NULL, 
  "auth_provider_id" text, 
  "status" text NOT NULL DEFAULT 'Active', 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  "deleted_at" timestamptz, PRIMARY KEY ("id") , 
  FOREIGN KEY ("auth_provider") REFERENCES "public"."user_auth_provider"("value") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("status") REFERENCES "public"."generic_status"("value") ON UPDATE restrict ON DELETE restrict, 
  UNIQUE ("username"), 
  UNIQUE ("email"), 
  UNIQUE ("phone_number")
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
CREATE TRIGGER "set_public_user_updated_at"
BEFORE UPDATE ON "public"."user"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_user_updated_at" ON "public"."user" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- User Address Table
CREATE TABLE "public"."user_address" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
  "name" text NOT NULL, 
  "location" point, 
  "country" text, 
  "city" text, 
  "sub_city" text, 
  "user_id" uuid NOT NULL, 
  "status" text NOT NULL DEFAULT 'Active', 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  "deleted_at" timestamptz, PRIMARY KEY ("id") , 
  FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict,
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
CREATE TRIGGER "set_public_user_address_updated_at"
BEFORE UPDATE ON "public"."user_address"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_user_address_updated_at" ON "public"."user_address" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- User Device Table
CREATE TABLE "public"."user_device" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
  "name" text, 
  "device_id" text, 
  "type" text NOT NULL, 
  "token" jsonb NOT NULL, 
  "user_id" uuid NOT NULL, 
  "status" text NOT NULL DEFAULT 'Active', 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  "deleted_at" timestamptz, PRIMARY KEY ("id") , 
  FOREIGN KEY ("type") REFERENCES "public"."user_device_type"("value") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict, 
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
CREATE TRIGGER "set_public_user_device_updated_at"
BEFORE UPDATE ON "public"."user_device"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_user_device_updated_at" ON "public"."user_device" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- User Role Table
CREATE TABLE "public"."user_role" (
  "user_id" uuid NOT NULL, 
  "role" text NOT NULL, 
  "status" text NOT NULL DEFAULT 'Active', 
  PRIMARY KEY ("user_id","role") , 
  FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("role") REFERENCES "public"."role"("value") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("status") REFERENCES "public"."generic_status"("value") ON UPDATE restrict ON DELETE restrict
);


-- User Settings Table
CREATE TABLE "public"."user_settings" (
  "user_id" uuid NOT NULL, 
  "notification" boolean NOT NULL DEFAULT true, 
  "push_notification" boolean NOT NULL DEFAULT false, 
  "email_notification" boolean NOT NULL DEFAULT false, 
  "sms_notification" boolean NOT NULL DEFAULT false, 
  PRIMARY KEY ("user_id") , 
  FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict
);

-- User Topic Table
CREATE TABLE "public"."user_topic" (
  "user_id" uuid NOT NULL, 
  "topic" text NOT NULL, 
  "status" text NOT NULL DEFAULT 'Active', 
  "created_at" timestamptz NOT NULL DEFAULT now(), 
  "updated_at" timestamptz NOT NULL DEFAULT now(), 
  PRIMARY KEY ("user_id","topic") , 
  FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict, 
  FOREIGN KEY ("topic") REFERENCES "public"."notification_topic"("value") ON UPDATE restrict ON DELETE restrict,
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
CREATE TRIGGER "set_public_user_topic_updated_at"
BEFORE UPDATE ON "public"."user_topic"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_user_topic_updated_at" ON "public"."user_topic" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';


