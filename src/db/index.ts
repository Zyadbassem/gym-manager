import "dotenv/config";
import { drizzle } from "drizzle-orm/neon-http";
import { neon } from "@neondatabase/serverless";
import { admins as adminTable } from "./schema/users.js";

const sql = neon(process.env.DATABASE_URL!);
export const db = drizzle({ client: sql });

function testConnection() {
  db.select()
    .from(adminTable)
    .then((result) => {
      console.log("Database connection successful:", result);
    })
    .catch((error) => {
      console.error("Database connection failed:", error);
    });
}

testConnection();
