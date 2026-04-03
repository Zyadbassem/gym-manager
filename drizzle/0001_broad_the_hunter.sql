CREATE TYPE "public"."admin_role" AS ENUM('super_admin', 'support_admin', 'moderator');--> statement-breakpoint
CREATE TABLE "admins" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"last_name" varchar(50) NOT NULL,
	"email" varchar(255) NOT NULL,
	"phone_number" varchar(20),
	"hashed_password" text NOT NULL,
	"is_approved" boolean DEFAULT false NOT NULL,
	"role" "admin_role" DEFAULT 'support_admin' NOT NULL,
	"last_login" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "admins_username_unique" UNIQUE("username"),
	CONSTRAINT "admins_email_unique" UNIQUE("email")
);
--> statement-breakpoint
DROP TABLE "playing_with_neon" CASCADE;--> statement-breakpoint
DROP TABLE "users" CASCADE;