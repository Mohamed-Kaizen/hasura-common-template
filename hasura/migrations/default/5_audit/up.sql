-- Audit Table
CREATE TABLE "public"."audit" (
    "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
    "table_name" text NOT NULL, 
    "description" text, 
    "record_id" jsonb NOT NULL, 
    "action" text NOT NULL, 
    "date" timestamptz NOT NULL, 
    "user_id" uuid NOT NULL, 
    PRIMARY KEY ("id") , 
    FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON UPDATE restrict ON DELETE restrict
);
CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- Audit Values Table
CREATE TABLE "public"."audit_value" (
    "id" uuid NOT NULL DEFAULT gen_random_uuid(), 
    "field_name" text NOT NULL, 
    "old" jsonb NOT NULL, 
    "new" jsonb NOT NULL, 
    "audit_id" uuid NOT NULL, 
    PRIMARY KEY ("id") , 
    FOREIGN KEY ("audit_id") REFERENCES "public"."audit"("id") ON UPDATE restrict ON DELETE restrict
);
CREATE EXTENSION IF NOT EXISTS pgcrypto;
