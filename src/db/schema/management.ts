import {
  pgTable,
  uuid,
  timestamp,
  boolean,
  pgEnum,
  integer,
} from "drizzle-orm/pg-core";
import { trainees, staff } from "./users.js";
import { gyms } from "./gyms.js";

export const paymentMethodEnum = pgEnum("payment_method", [
  "trial",
  "credit_card",
  "instapay",
  "cash",
]);

export const checkIns = pgTable("check_ins", {
  id: uuid("id").primaryKey().defaultRandom(),
  traineeId: uuid("trainee_id")
    .notNull()
    .references(() => trainees.id),
  staffApprovedId: uuid("staff_approved_id")
    .notNull()
    .references(() => staff.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const memberships = pgTable("memberships", {
  id: uuid("id").primaryKey().defaultRandom(),
  membershipPrice: integer("membership_price").notNull(),
  expirationDate: timestamp("expiration_date").notNull(),
  isValid: boolean("is_valid").notNull().default(true),
  gymId: uuid("gym_id")
    .notNull()
    .references(() => gyms.id),

  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const subscription = pgTable("subscription", {
  id: uuid("id").primaryKey().defaultRandom(),
  expirationDate: timestamp("expiration_date").notNull(),
  paymentMethod: paymentMethodEnum("payment_method").notNull(),
  isTrial: boolean("is_trial").notNull().default(false),
  isValid: boolean("is_valid").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
