import { migrate } from "drizzle-orm/neon-http/migrator";
import { db } from "./index.js";

const runMigrations = async () => {
  try {
    console.log("⏳ Running migrations...");
    await migrate(db, { migrationsFolder: "drizzle" });
    console.log("✅ Migrations completed!");
  } catch (error) {
    console.error("❌ Migration failed:", error);
    process.exit(1);
  }
};

runMigrations();
