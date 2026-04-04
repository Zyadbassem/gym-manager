CREATE TABLE "checks_in" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"trainee_id" bigint NOT NULL,
	"staff_approved" bigint NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "memeberships" (
	"id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "memeberships_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1),
	"memebership_price" varchar(255) NOT NULL,
	"expiration_date" timestamp NOT NULL,
	"is_valid" boolean NOT NULL,
	"trainee_id" bigint NOT NULL,
	"gym_id" uuid NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "subscription" (
	"id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "subscription_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1),
	"owner_id" uuid NOT NULL,
	"expiration_date" bigint NOT NULL,
	"payment_method" bigint NOT NULL,
	"is_trial" bigint NOT NULL,
	"is_valid" bigint NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "trainees" RENAME COLUMN "profile_picture_url" TO "profile_picture";--> statement-breakpoint
ALTER TABLE "staff" DROP CONSTRAINT "staff_username_unique";--> statement-breakpoint
ALTER TABLE "staff" DROP CONSTRAINT "staff_email_unique";--> statement-breakpoint
ALTER TABLE "trainees" DROP CONSTRAINT "trainees_username_unique";--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "description" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "location" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "img" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "created_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "updated_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "username" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "first_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "last_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "phone_number" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "phone_number" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "hashed_password" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "is_approved" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "role" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "last_login" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "approved_by" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "created_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "updated_at" SET DATA TYPE bigint;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "updated_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "username" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "first_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "last_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "phone_number" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "phone_number" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "hashed_password" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "is_approved" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "approved_by" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "last_login" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "subscription_status" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "subscription_status" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "created_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "updated_at" SET DATA TYPE bigint;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "updated_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "username" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "first_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "last_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "phone_number" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "phone_number" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "hashed_password" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "is_approved" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "approved_by" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "role" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "last_login" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "created_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "updated_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "username" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "first_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "last_name" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "phone_number" SET DATA TYPE varchar(255);--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "phone_number" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "last_check_in" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "created_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "trainees" ADD COLUMN "memebership" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "trainees" ADD COLUMN "updated_at" timestamp NOT NULL;--> statement-breakpoint
ALTER TABLE "checks_in" ADD CONSTRAINT "checks_in_trainee_id_trainees_id_fk" FOREIGN KEY ("trainee_id") REFERENCES "public"."trainees"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "checks_in" ADD CONSTRAINT "checks_in_staff_approved_staff_id_fk" FOREIGN KEY ("staff_approved") REFERENCES "public"."staff"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "memeberships" ADD CONSTRAINT "memeberships_trainee_id_trainees_id_fk" FOREIGN KEY ("trainee_id") REFERENCES "public"."trainees"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "memeberships" ADD CONSTRAINT "memeberships_gym_id_gyms_id_fk" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscription" ADD CONSTRAINT "subscription_owner_id_owners_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."owners"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "membership_valid_until";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "membership_valid";--> statement-breakpoint
ALTER TABLE "admins" ADD CONSTRAINT "admins_phone_number_unique" UNIQUE("phone_number");--> statement-breakpoint
ALTER TABLE "owners" ADD CONSTRAINT "owners_phone_number_unique" UNIQUE("phone_number");