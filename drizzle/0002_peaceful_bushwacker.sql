CREATE TABLE "owners" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"last_name" varchar(50) NOT NULL,
	"email" varchar(255) NOT NULL,
	"phone_number" varchar(20),
	"hashed_password" text NOT NULL,
	"is_approved" boolean DEFAULT false NOT NULL,
	"last_login" timestamp,
	"subscription_status" varchar(20) DEFAULT 'trial' NOT NULL,
	"trial_ends_at" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "owners_username_unique" UNIQUE("username"),
	CONSTRAINT "owners_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "staff" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"last_name" varchar(50) NOT NULL,
	"email" varchar(255) NOT NULL,
	"phone_number" varchar(20),
	"gym_id" uuid NOT NULL,
	"hashed_password" text NOT NULL,
	"is_approved" boolean DEFAULT false NOT NULL,
	"last_login" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "staff_username_unique" UNIQUE("username"),
	CONSTRAINT "staff_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "trainees" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"last_name" varchar(50) NOT NULL,
	"phone_number" varchar(20),
	"email" varchar(255) NOT NULL,
	"profile_picture_url" text,
	"membership_valid_until" timestamp NOT NULL,
	"membership_valid" boolean DEFAULT false NOT NULL,
	"last_check_in" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "trainees_username_unique" UNIQUE("username"),
	CONSTRAINT "trainees_email_unique" UNIQUE("email")
);
