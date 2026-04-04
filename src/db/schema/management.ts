import {
  pgTable,
  uuid,
  bigint,
  timestamp,
  varchar,
  boolean,
} from "drizzle-orm/pg-core";
import { trainees, staff, owners } from "./users.js";
import { gyms } from "./gyms.js";

export const checks_in = pgTable("checks_in", {
  id: uuid("id").primaryKey().defaultRandom(),
  traineeId: bigint("trainee_id", { mode: "bigint" })
    .notNull()
    .references(() => trainees.id),
  staffApproved: bigint("staff_approved", { mode: "bigint" })
    .notNull()
    .references(() => staff.id),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const memberships = pgTable("memeberships", {
  id: bigint("id", { mode: "bigint" }).primaryKey().generatedAlwaysAsIdentity(),
  membershipPrice: varchar("memebership_price", { length: 255 }).notNull(),
  expirationDate: timestamp("expiration_date").notNull(),
  isValid: boolean("is_valid").notNull(),
  traineeId: bigint("trainee_id", { mode: "bigint" })
    .notNull()
    .references(() => trainees.id),
  gymId: uuid("gym_id")
    .notNull()
    .references(() => gyms.id),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const subscription = pgTable("subscription", {
  id: bigint("id", { mode: "bigint" }).primaryKey().generatedAlwaysAsIdentity(),
  ownerId: uuid("owner_id")
    .notNull()
    .references(() => owners.id),
  expirationDate: bigint("expiration_date", { mode: "number" }).notNull(),
  paymentMethod: bigint("payment_method", { mode: "number" }).notNull(),
  isTrial: bigint("is_trial", { mode: "number" }).notNull(),
  isValid: bigint("is_valid", { mode: "number" }).notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});
