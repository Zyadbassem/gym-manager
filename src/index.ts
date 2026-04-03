import "dotenv/config";
import express, { Request, Response } from "express";

const app = express();
const port = process.env.PORT || 3000;

app.get("/", async (_: Request, res: Response) => {
  try {
    res.json({ message: "Connected to the database successfully!" });
  } catch (error) {
    console.error("Database query failed:", error);
    res.status(500).json({ error: "Failed to connect to the database." });
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
