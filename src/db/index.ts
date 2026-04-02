import "dotenv/config";
import { drizzle } from "drizzle-orm/neon-http";
import { users as usersTable } from "./schema.js";

export const db = drizzle(process.env.DATABASE_URL!);

const addingUser = async () => {
  const user: typeof usersTable.$inferInsert = {
    name: "ahmed",
    age: 120,
    email: "hh@example.com",
  };

  try {
    const result = await db.insert(usersTable).values(user).returning();
    console.log("Inserted user:", result);
  } catch (error) {
    console.error("Error inserting user:", error);
  }
};

await addingUser();
