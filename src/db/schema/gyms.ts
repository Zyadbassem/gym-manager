import { pgTable, text, varchar, uuid, timestamp } from "drizzle-orm/pg-core";
import { owners } from "./users.js";

export const gyms = pgTable("gyms", {
  id: uuid("id").primaryKey().defaultRandom(),

  name: varchar("name", { length: 100 }).notNull(),
  description: text("description"),
  location: varchar("location", { length: 255 }),
  img: varchar("img", { length: 255 }),

  ownerId: uuid("owner_id")
    .references(() => owners.id)
    .notNull(),

  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at")
    .defaultNow()
    .notNull()
    .$onUpdate((): Date => new Date()),
});
