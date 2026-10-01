import { NextResponse } from "next/server";

export async function POST(req: Request) {
  const { email, name = "SQL Learner" } = await req.json();
  if (!email || !email.includes("@")) {
    return NextResponse.json({ error: "Valid email required" }, { status: 400 });
  }

  // Key-free learning/demo mode. No external provider is called.
  return NextResponse.json({
    sent: false,
    mode: "local-greeting",
    message: "Thanks for choosing SQL From Zero to Advanced, " + name + "! Welcome to your SQL learning journey.",
    email
  });
}
