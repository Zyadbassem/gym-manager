import "dotenv/config";
import express, { Request, Response } from "express";
import postgres from "postgres";

const app = express();
const port = process.env.PORT || 3000;

const sql = postgres(process.env.DATABASE_URL!);

app.get("/", async (_: Request, res: Response) => {
  try {
    const [result] = await sql`SELECT version()`;
    const version = result?.version || "No version found";
    res.json({
      message: "Connection successful!",
      version: version,
    });
  } catch (error) {
    console.error("Database query failed:", error);
    res.status(500).json({ error: "Failed to connect to the database." });
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
