import { pgTable, text, varchar, uuid, timestamp } from "drizzle-orm/pg-core";
import { owners } from "./users.js";

export const gyms = pgTable("gyms", {
  id: uuid("id").primaryKey().defaultRandom(),

  name: varchar("name", { length: 255 }).notNull(),
  description: text("description").notNull(),
  location: varchar("location", { length: 255 }).notNull(),
  img: varchar("img", { length: 255 }).notNull(),

  ownerId: uuid("owner_id")
    .references(() => owners.id)
    .notNull(),

  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});
