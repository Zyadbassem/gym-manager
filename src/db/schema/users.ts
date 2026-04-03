import {
  pgTable,
  text,
  varchar,
  boolean,
  pgEnum,
  uuid,
  timestamp,
  AnyPgColumn,
  bigint,
} from "drizzle-orm/pg-core";
import { gyms } from "./gyms.js";

export const adminRoleEnum = pgEnum("admin_role", [
  "super_admin",
  "support_admin",
  "moderator",
]);

export const staffRoleEnum = pgEnum("staff_role", [
  "trainer",
  "receptionist",
  "cleaning_staff",
]);

export const admins = pgTable("admins", {
  id: uuid("id").primaryKey().defaultRandom(),

  username: varchar("username", { length: 50 }).notNull().unique(),
  firstName: varchar("first_name", { length: 50 }).notNull(),
  lastName: varchar("last_name", { length: 50 }).notNull(),

  email: varchar("email", { length: 255 }).notNull().unique(),
  phoneNumber: varchar("phone_number", { length: 20 }),

  hashedPassword: text("hashed_password").notNull(),

  isApproved: boolean("is_approved").default(false).notNull(),
  role: adminRoleEnum("role").default("support_admin").notNull(),

  lastLogin: timestamp("last_login"),
  approved_by: uuid("approved_by").references((): AnyPgColumn => admins.id),

  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at")
    .defaultNow()
    .notNull()
    .$onUpdate(() => new Date()),
});

export const owners = pgTable("owners", {
  id: uuid("id").primaryKey().defaultRandom(),

  username: varchar("username", { length: 50 }).notNull().unique(),
  firstName: varchar("first_name", { length: 50 }).notNull(),
  lastName: varchar("last_name", { length: 50 }).notNull(),

  email: varchar("email", { length: 255 }).notNull().unique(),
  phoneNumber: varchar("phone_number", { length: 20 }),

  hashedPassword: text("hashed_password").notNull(),
  isApproved: boolean("is_approved").default(false).notNull(),

  approvedBy: uuid("approved_by").references(() => admins.id),

  lastLogin: timestamp("last_login"),

  subscriptionStatus: varchar("subscription_status", { length: 20 })
    .default("trial")
    .notNull(),
  trialEndsAt: timestamp("trial_ends_at").notNull(),

  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at")
    .defaultNow()
    .notNull()
    .$onUpdate(() => new Date()),
});

export const staff = pgTable("staff", {
  id: bigint("id", { mode: "bigint" }).primaryKey().generatedAlwaysAsIdentity(),

  username: varchar("username", { length: 50 }).notNull().unique(),
  firstName: varchar("first_name", { length: 50 }).notNull(),
  lastName: varchar("last_name", { length: 50 }).notNull(),

  email: varchar("email", { length: 255 }).notNull().unique(),
  phoneNumber: varchar("phone_number", { length: 20 }),
  gymId: uuid("gym_id")
    .references(() => gyms.id)
    .notNull(),

  hashedPassword: text("hashed_password").notNull(),
  isApproved: boolean("is_approved").default(false).notNull(),
  approvedBy: uuid("approved_by").references(() => owners.id),
  role: staffRoleEnum("role").default("trainer").notNull(),

  lastLogin: timestamp("last_login"),

  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at")
    .defaultNow()
    .notNull()
    .$onUpdate(() => new Date()),
});

export const trainees = pgTable("trainees", {
  id: bigint("id", { mode: "bigint" }).primaryKey().generatedAlwaysAsIdentity(),

  username: varchar("username", { length: 50 }).notNull().unique(),
  firstName: varchar("first_name", { length: 50 }).notNull(),
  lastName: varchar("last_name", { length: 50 }).notNull(),

  phoneNumber: varchar("phone_number", { length: 20 }),
  email: varchar("email", { length: 255 }).notNull(),
  profilePictureUrl: text("profile_picture_url"),
  gymId: uuid("gym_id")
    .references(() => gyms.id)
    .notNull(),

  membershipValidUntil: timestamp("membership_valid_until").notNull(),
  membershipValid: boolean("membership_valid").default(false).notNull(),
  lastCheckIn: timestamp("last_check_in"),

  createdAt: timestamp("created_at").defaultNow().notNull(),
});
