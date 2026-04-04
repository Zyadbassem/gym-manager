CREATE TYPE "public"."payment_method" AS ENUM('trial', 'credit_card', 'instapay', 'cash');--> statement-breakpoint
CREATE TABLE "check_ins" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"trainee_id" uuid NOT NULL,
	"staff_approved_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "memberships" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"membership_price" integer NOT NULL,
	"expiration_date" timestamp NOT NULL,
	"is_valid" boolean DEFAULT true NOT NULL,
	"gym_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "checks_in" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "memeberships" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
DROP TABLE "checks_in" CASCADE;--> statement-breakpoint
DROP TABLE "memeberships" CASCADE;--> statement-breakpoint
ALTER TABLE "subscription" DROP CONSTRAINT "subscription_owner_id_owners_id_fk";
--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "img" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "created_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "gyms" ALTER COLUMN "updated_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "id" SET DEFAULT gen_random_uuid();--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "id" DROP IDENTITY;--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "expiration_date" SET DATA TYPE timestamp;--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "payment_method" SET DATA TYPE "public"."payment_method" USING "payment_method"::"public"."payment_method";--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "is_trial" SET DATA TYPE boolean;--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "is_valid" SET DATA TYPE boolean;--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "is_valid" SET DEFAULT true;--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "created_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "subscription" ALTER COLUMN "updated_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "is_approved" SET DEFAULT false;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "last_login" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "approved_by" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "created_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "admins" ALTER COLUMN "updated_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "is_approved" SET DEFAULT false;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "approved_by" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "last_login" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "created_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "owners" ALTER COLUMN "updated_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "id" SET DEFAULT gen_random_uuid();--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "id" DROP IDENTITY;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "is_approved" SET DEFAULT false;--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "created_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "staff" ALTER COLUMN "updated_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "id" SET DEFAULT gen_random_uuid();--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "id" DROP IDENTITY;--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "created_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "trainees" ALTER COLUMN "updated_at" SET DEFAULT now();--> statement-breakpoint
ALTER TABLE "owners" ADD COLUMN "had_trial" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ADD COLUMN "subscription_id" uuid;--> statement-breakpoint
ALTER TABLE "trainees" ADD COLUMN "membership_id" uuid;--> statement-breakpoint
ALTER TABLE "check_ins" ADD CONSTRAINT "check_ins_trainee_id_trainees_id_fk" FOREIGN KEY ("trainee_id") REFERENCES "public"."trainees"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "check_ins" ADD CONSTRAINT "check_ins_staff_approved_id_staff_id_fk" FOREIGN KEY ("staff_approved_id") REFERENCES "public"."staff"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "memberships" ADD CONSTRAINT "memberships_gym_id_gyms_id_fk" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "owners" ADD CONSTRAINT "owners_subscription_id_subscription_id_fk" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscription"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_membership_id_memberships_id_fk" FOREIGN KEY ("membership_id") REFERENCES "public"."memberships"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscription" DROP COLUMN "owner_id";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "subscription_status";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "trial_ends_at";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "memebership";--> statement-breakpoint
ALTER TABLE "gyms" ADD CONSTRAINT "gyms_name_unique" UNIQUE("name");--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_username_unique" UNIQUE("username");--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_email_unique" UNIQUE("email");--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_phone_number_unique" UNIQUE("phone_number");--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_username_unique" UNIQUE("username");--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_phone_number_unique" UNIQUE("phone_number");--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_email_unique" UNIQUE("email");