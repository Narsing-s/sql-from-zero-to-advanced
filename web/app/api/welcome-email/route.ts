import {NextResponse} from "next/server";

export async function POST(req:Request){
  const {email,name="SQL Learner"}=await req.json();
  if(!email || !email.includes("@")) return NextResponse.json({error:"Valid email required"},{status:400});
  if(!process.env.RESEND_API_KEY || !process.env.EMAIL_FROM){
    return NextResponse.json({sent:false,mode:"local-demo",message:"Email provider is not configured. Login was recorded locally."});
  }
  const r=await fetch("https://api.resend.com/emails",{method:"POST",headers:{"Authorization":`Bearer ${process.env.RESEND_API_KEY}`,"Content-Type":"application/json"},body:JSON.stringify({from:process.env.EMAIL_FROM,to:[email],subject:"Welcome to SQL From Zero to Advanced",html:`<h1>Welcome, ${name}!</h1><p>Your SQL learning journey starts now.</p><p>Explore theory, runnable examples, challenges and real-world projects.</p>`})});
  if(!r.ok)return NextResponse.json({sent:false,error:"Email provider rejected the request"},{status:502});
  return NextResponse.json({sent:true});
}
