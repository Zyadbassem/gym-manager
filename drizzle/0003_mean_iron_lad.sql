CREATE TYPE "public"."staff_role" AS ENUM('trainer', 'receptionist', 'cleaning_staff');--> statement-breakpoint
CREATE TABLE "gyms" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" text,
	"location" varchar(255),
	"img" varchar(255),
	"owner_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "trainees" DROP CONSTRAINT "trainees_email_unique";--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "id" SET DATA TYPE bigint;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "id" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (sequence name "staff_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1);--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "id" SET DATA TYPE bigint;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "id" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (sequence name "trainees_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1);--> statement-breakpoint
ALTER TABLE "admins" ADD COLUMN "approved_by" uuid;--> statement-breakpoint
ALTER TABLE "owners" ADD COLUMN "approved_by" uuid;--> statement-breakpoint
ALTER TABLE "staff" ADD COLUMN "approved_by" uuid;--> statement-breakpoint
ALTER TABLE "staff" ADD COLUMN "role" "staff_role" DEFAULT 'trainer' NOT NULL;--> statement-breakpoint
ALTER TABLE "staff" ADD COLUMN "updated_at" timestamp DEFAULT now() NOT NULL;--> statement-breakpoint
ALTER TABLE "trainees" ADD COLUMN "gym_id" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "gyms" ADD CONSTRAINT "gyms_owner_id_owners_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."owners"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "admins" ADD CONSTRAINT "admins_approved_by_admins_id_fk" FOREIGN KEY ("approved_by") REFERENCES "public"."admins"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "owners" ADD CONSTRAINT "owners_approved_by_admins_id_fk" FOREIGN KEY ("approved_by") REFERENCES "public"."admins"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_gym_id_gyms_id_fk" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_approved_by_owners_id_fk" FOREIGN KEY ("approved_by") REFERENCES "public"."owners"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_gym_id_gyms_id_fk" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE no action ON UPDATE no action;