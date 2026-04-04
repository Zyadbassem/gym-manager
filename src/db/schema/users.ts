import {
  pgTable,
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
  username: varchar("username", { length: 255 }).notNull().unique(),
  firstName: varchar("first_name", { length: 255 }).notNull(),
  lastName: varchar("last_name", { length: 255 }).notNull(),
  email: varchar("email", { length: 255 }).notNull().unique(),
  phoneNumber: varchar("phone_number", { length: 255 }).notNull().unique(),
  hashedPassword: varchar("hashed_password", { length: 255 }).notNull(),
  isApproved: boolean("is_approved").notNull(),
  role: adminRoleEnum("role").notNull(),
  lastLogin: timestamp("last_login").notNull(),
  approvedBy: uuid("approved_by")
    .references((): AnyPgColumn => admins.id)
    .notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: bigint("updated_at", { mode: "number" }).notNull(),
});

export const owners = pgTable("owners", {
  id: uuid("id").primaryKey().defaultRandom(),
  username: varchar("username", { length: 255 }).notNull().unique(),
  firstName: varchar("first_name", { length: 255 }).notNull(),
  lastName: varchar("last_name", { length: 255 }).notNull(),
  email: varchar("email", { length: 255 }).notNull().unique(),
  phoneNumber: varchar("phone_number", { length: 255 }).notNull().unique(),
  hashedPassword: varchar("hashed_password", { length: 255 }).notNull(),
  isApproved: boolean("is_approved").notNull(),
  approvedBy: uuid("approved_by")
    .references(() => admins.id)
    .notNull(),
  subscriptionStatus: varchar("subscription_status", { length: 255 }).notNull(),
  trialEndsAt: timestamp("trial_ends_at").notNull(),
  lastLogin: timestamp("last_login").notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: bigint("updated_at", { mode: "number" }).notNull(),
});

export const staff = pgTable("staff", {
  id: bigint("id", { mode: "bigint" }).primaryKey().generatedAlwaysAsIdentity(),
  username: varchar("username", { length: 255 }).notNull(),
  firstName: varchar("first_name", { length: 255 }).notNull(),
  lastName: varchar("last_name", { length: 255 }).notNull(),
  email: varchar("email", { length: 255 }).notNull(),
  phoneNumber: varchar("phone_number", { length: 255 }).notNull(),
  gymId: uuid("gym_id")
    .references(() => gyms.id)
    .notNull(),
  hashedPassword: varchar("hashed_password", { length: 255 }).notNull(),
  isApproved: boolean("is_approved").notNull(),
  approvedBy: uuid("approved_by")
    .references(() => owners.id)
    .notNull(),
  role: staffRoleEnum("role").notNull(),
  lastLogin: timestamp("last_login").notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const trainees = pgTable("trainees", {
  id: bigint("id", { mode: "bigint" }).primaryKey().generatedAlwaysAsIdentity(),
  username: varchar("username", { length: 255 }).notNull(),
  firstName: varchar("first_name", { length: 255 }).notNull(),
  lastName: varchar("last_name", { length: 255 }).notNull(),
  phoneNumber: varchar("phone_number", { length: 255 }).notNull(),
  email: varchar("email", { length: 255 }).notNull(),
  profilePicture: varchar("profile_picture", { length: 255 }).notNull(),
  gymId: uuid("gym_id")
    .references(() => gyms.id)
    .notNull(),
  memebership: uuid("memebership").notNull(),
  lastCheckIn: timestamp("last_check_in").notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});
