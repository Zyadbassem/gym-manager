import "dotenv/config";
import express from "express";

export const app = express();

app.get("/", (_, res) => {
  res.send("Welcome to the Gym Management System API!");
});
