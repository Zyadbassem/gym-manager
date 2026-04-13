CREATE TYPE "public"."user_role" AS ENUM('admin', 'owner', 'staff', 'trainee');--> statement-breakpoint
CREATE TABLE "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" varchar(255) NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"phone_number" varchar(255) NOT NULL,
	"hashed_password" varchar(255) NOT NULL,
	"is_approved" boolean DEFAULT false NOT NULL,
	"approved_by" uuid,
	"role" "user_role" NOT NULL,
	"last_login" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp with time zone,
	CONSTRAINT "users_username_unique" UNIQUE("username"),
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_phone_number_unique" UNIQUE("phone_number")
);
--> statement-breakpoint
ALTER TABLE "admins" DROP CONSTRAINT "admins_username_unique";--> statement-breakpoint
ALTER TABLE "admins" DROP CONSTRAINT "admins_email_unique";--> statement-breakpoint
ALTER TABLE "admins" DROP CONSTRAINT "admins_phone_number_unique";--> statement-breakpoint
ALTER TABLE "owners" DROP CONSTRAINT "owners_username_unique";--> statement-breakpoint
ALTER TABLE "owners" DROP CONSTRAINT "owners_email_unique";--> statement-breakpoint
ALTER TABLE "owners" DROP CONSTRAINT "owners_phone_number_unique";--> statement-breakpoint
ALTER TABLE "staff" DROP CONSTRAINT "staff_username_unique";--> statement-breakpoint
ALTER TABLE "staff" DROP CONSTRAINT "staff_email_unique";--> statement-breakpoint
ALTER TABLE "staff" DROP CONSTRAINT "staff_phone_number_unique";--> statement-breakpoint
ALTER TABLE "trainees" DROP CONSTRAINT "trainees_username_unique";--> statement-breakpoint
ALTER TABLE "trainees" DROP CONSTRAINT "trainees_phone_number_unique";--> statement-breakpoint
ALTER TABLE "trainees" DROP CONSTRAINT "trainees_email_unique";--> statement-breakpoint
ALTER TABLE "admins" DROP CONSTRAINT "admins_approved_by_admins_id_fk";
--> statement-breakpoint
ALTER TABLE "owners" DROP CONSTRAINT "owners_approved_by_admins_id_fk";
--> statement-breakpoint
ALTER TABLE "staff" DROP CONSTRAINT "staff_approved_by_owners_id_fk";
--> statement-breakpoint
ALTER TABLE "admins" ADD COLUMN "user_id" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "owners" ADD COLUMN "user_id" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "staff" ADD COLUMN "user_id" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "trainees" ADD COLUMN "user_id" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_approved_by_users_id_fk" FOREIGN KEY ("approved_by") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "email_idx" ON "users" USING btree ("email");--> statement-breakpoint
ALTER TABLE "admins" ADD CONSTRAINT "admins_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "owners" ADD CONSTRAINT "owners_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "username";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "first_name";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "last_name";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "email";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "phone_number";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "hashed_password";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "is_approved";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "last_login";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "approved_by";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "created_at";--> statement-breakpoint
ALTER TABLE "admins" DROP COLUMN "updated_at";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "username";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "first_name";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "last_name";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "email";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "phone_number";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "had_trial";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "hashed_password";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "is_approved";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "approved_by";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "last_login";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "created_at";--> statement-breakpoint
ALTER TABLE "owners" DROP COLUMN "updated_at";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "username";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "first_name";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "last_name";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "email";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "phone_number";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "hashed_password";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "is_approved";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "approved_by";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "last_login";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "created_at";--> statement-breakpoint
ALTER TABLE "staff" DROP COLUMN "updated_at";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "username";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "first_name";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "last_name";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "phone_number";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "email";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "created_at";--> statement-breakpoint
ALTER TABLE "trainees" DROP COLUMN "updated_at";--> statement-breakpoint
ALTER TABLE "admins" ADD CONSTRAINT "admins_user_id_unique" UNIQUE("user_id");--> statement-breakpoint
ALTER TABLE "owners" ADD CONSTRAINT "owners_user_id_unique" UNIQUE("user_id");--> statement-breakpoint
ALTER TABLE "staff" ADD CONSTRAINT "staff_user_id_unique" UNIQUE("user_id");--> statement-breakpoint
ALTER TABLE "trainees" ADD CONSTRAINT "trainees_user_id_unique" UNIQUE("user_id");