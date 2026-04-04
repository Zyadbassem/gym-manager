import "dotenv/config";
import { drizzle } from "drizzle-orm/neon-http";
import { neon } from "@neondatabase/serverless";

import { gyms } from "./schema/gyms.js";
import { admins, owners, staff, trainees } from "./schema/users.js";
import { checkIns, memberships, subscription } from "./schema/management.js";

const sql = neon(process.env.DATABASE_URL!);
export const db = drizzle(sql);

export async function seed() {
  console.log("Seeding database...");

  try {
    // Clean up previous data
    console.log("Clearing existing data...");
    await db.delete(checkIns);
    await db.delete(trainees);
    await db.delete(staff);
    await db.delete(memberships);
    await db.delete(gyms);
    await db.delete(owners);
    await db.delete(subscription);
    await db.delete(admins);
    console.log("Cleared existing data.");

    // 1. Create a super_admin
    const [superAdmin] = await db
      .insert(admins)
      .values({
        username: "superadmin",
        firstName: "Super",
        lastName: "Admin",
        email: "super.admin@example.com",
        phoneNumber: "1234567890",
        hashedPassword: "hashed_password_super_admin", // Should be properly hashed in a real app
        isApproved: true,
        role: "super_admin",
      })
      .returning();
    console.log("Created super admin:", superAdmin.username);

    // 2. Create a subscription
    const [sub] = await db
      .insert(subscription)
      .values({
        expirationDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days from now
        paymentMethod: "credit_card",
      })
      .returning();
    console.log("Created subscription:", sub.id);

    // 3. Create an owner
    const [owner] = await db
      .insert(owners)
      .values({
        username: "gymowner",
        firstName: "Gym",
        lastName: "Owner",
        email: "gym.owner@example.com",
        phoneNumber: "0987654321",
        hashedPassword: "hashed_password_owner",
        isApproved: true,
        approvedBy: superAdmin.id,
        subscriptionId: sub.id,
      })
      .returning();
    console.log("Created owner:", owner.username);

    // 4. Create a gym
    const [gym] = await db
      .insert(gyms)
      .values({
        name: "DrizzleFit",
        description: "The best gym in town.",
        location: "123 Drizzle St",
        ownerId: owner.id,
      })
      .returning();
    console.log("Created gym:", gym.name);

    // 5. Create a staff member
    const [staffMember] = await db
      .insert(staff)
      .values({
        username: "gymtrainer",
        firstName: "Gym",
        lastName: "Trainer",
        email: "gym.trainer@example.com",
        phoneNumber: "1122334455",
        gymId: gym.id,
        hashedPassword: "hashed_password_staff",
        isApproved: true,
        approvedBy: owner.id,
        role: "trainer",
      })
      .returning();
    console.log("Created staff member:", staffMember.username);

    console.log("Seeding finished successfully!");
  } catch (error) {
    console.error("Error seeding database:", error);
    throw error; // re-throw error to be caught by caller
  }
}

seed();
