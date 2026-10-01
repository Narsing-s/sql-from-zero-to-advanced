import { NextResponse } from "next/server";

export async function POST(req: Request) {
  try {
    const { email, name = "SQL Learner" } = await req.json();

    if (!email || !email.includes("@")) {
      return NextResponse.json({ error: "Valid email required" }, { status: 400 });
    }

    const message = "Thanks for choosing SQL From Zero to Advanced, " + name + "! Welcome to your SQL learning journey.";
    const apiKey = process.env.RESEND_API_KEY;
    const from = process.env.WELCOME_EMAIL_FROM || "SQL Lab <onboarding@resend.dev>";

    // Real email delivery is optional. Without a server-side Resend key,
    // the app remains fully usable and returns the greeting locally.
    if (!apiKey) {
      return NextResponse.json({
        sent: false,
        mode: "local-greeting",
        message,
        email
      });
    }

    const response = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${apiKey}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        from,
        to: [email],
        subject: "Welcome to SQL From Zero to Advanced",
        html: `
          <div style="font-family:Arial,sans-serif;max-width:600px;margin:auto;padding:32px">
            <h1>Welcome to SQL From Zero to Advanced, ${name}!</h1>
            <p>${message}</p>
            <p>Start with the theory, run the examples, complete the exercises, and build real-world SQL skills.</p>
            <p>Happy learning!<br/>SQL Lab</p>
          </div>
        `
      })
    });

    const data = await response.json();

    if (!response.ok) {
      return NextResponse.json({
        sent: false,
        mode: "email-error",
        message,
        error: data?.message || "Email provider rejected the request."
      }, { status: 502 });
    }

    return NextResponse.json({
      sent: true,
      mode: "resend",
      message,
      email,
      id: data?.id
    });
  } catch {
    return NextResponse.json({ error: "Unable to process welcome email request." }, { status: 500 });
  }
}
