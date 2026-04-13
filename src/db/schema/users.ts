import {
  pgTable,
  varchar,
  boolean,
  pgEnum,
  uuid,
  timestamp,
  AnyPgColumn,
  index,
} from "drizzle-orm/pg-core";
import { gyms } from "./gyms.js";
import { memberships, subscription } from "./management.js";

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

export const userEnum = pgEnum("user_role", [
  "admin",
  "owner",
  "staff",
  "trainee",
]);

export const user = pgTable(
  "users",
  {
    id: uuid("id").primaryKey().defaultRandom(),
    username: varchar("username", { length: 255 }).notNull().unique(),
    firstName: varchar("first_name", { length: 255 }).notNull(),
    lastName: varchar("last_name", { length: 255 }).notNull(),
    email: varchar("email", { length: 255 }).notNull().unique(),
    phoneNumber: varchar("phone_number", { length: 255 }).notNull().unique(),
    hashedPassword: varchar("hashed_password", { length: 255 }).notNull(),
    isApproved: boolean("is_approved").notNull().default(false),
    approvedBy: uuid("approved_by").references((): AnyPgColumn => user.id, {
      onDelete: "set null",
    }),
    role: userEnum("role").notNull(),
    lastLogin: timestamp("last_login"),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
    deletedAt: timestamp("deleted_at", { withTimezone: true }),
  },
  (table) => ({
    emailIdx: index("email_idx").on(table.email),
  })
);

export const admins = pgTable("admins", {
  id: uuid("id").primaryKey().defaultRandom(),
  userId: uuid("user_id")
    .references(() => user.id)
    .notNull()
    .unique(),
  role: adminRoleEnum("role").notNull(),
});

export const owners = pgTable("owners", {
  id: uuid("id").primaryKey().defaultRandom(),
  userId: uuid("user_id")
    .references(() => user.id)
    .notNull()
    .unique(),
  subscriptionId: uuid("subscription_id").references(() => subscription.id),
});

export const staff = pgTable("staff", {
  id: uuid("id").primaryKey().defaultRandom(),
  userId: uuid("user_id")
    .references(() => user.id)
    .notNull()
    .unique(),
  gymId: uuid("gym_id")
    .references(() => gyms.id)
    .notNull(),
  role: staffRoleEnum("role").notNull(),
});

export const trainees = pgTable("trainees", {
  id: uuid("id").primaryKey().defaultRandom(),
  userId: uuid("user_id")
    .references(() => user.id)
    .notNull()
    .unique(),
  profilePicture: varchar("profile_picture", { length: 255 }),
  gymId: uuid("gym_id")
    .references(() => gyms.id)
    .notNull(),
  membershipId: uuid("membership_id").references(() => memberships.id),
  lastCheckIn: timestamp("last_check_in"),
});
