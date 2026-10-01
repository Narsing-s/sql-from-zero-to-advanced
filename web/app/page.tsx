"use client";

import {useMemo,useState} from "react";
import {BookOpen,Database,Mail,Search,ShieldCheck,Terminal,CheckCircle2,ArrowRight,ExternalLink,PlayCircle} from "lucide-react";

const lessons=[
 {id:"01",level:"Beginner",title:"Database foundations",desc:"Tables, rows, keys, schemas, NULL and relational thinking.",material:"01-beginner/01-database-basics.sql",theory:"COMPLETE-SQL-THEORY.md"},
 {id:"02",level:"Beginner",title:"SELECT mastery",desc:"Filtering, sorting, aliases, expressions and pagination.",material:"01-beginner/04-select.sql",theory:"COMPLETE-SQL-THEORY.md"},
 {id:"03",level:"Intermediate",title:"Joins & aggregation",desc:"INNER/LEFT joins, GROUP BY, HAVING and conditional aggregates.",material:"02-intermediate/01-joins.sql",theory:"COMPLETE-SQL-THEORY.md"},
 {id:"04",level:"Intermediate",title:"Subqueries & CASE",desc:"Correlated subqueries, EXISTS, CASE and business rules.",material:"02-intermediate/04-subqueries.sql",theory:"COMPLETE-SQL-THEORY.md"},
 {id:"05",level:"Advanced",title:"CTEs & windows",desc:"Readable pipelines, recursive CTEs and ranking analytics.",material:"03-advanced/01-cte.sql",theory:"COMPLETE-SQL-THEORY.md"},
 {id:"06",level:"Advanced",title:"Transactions",desc:"ACID, isolation, locks, rollback and concurrency.",material:"05-transactions/transactions.sql",theory:"05-transactions/acid.md"},
 {id:"07",level:"Expert",title:"JSONB & PostgreSQL",desc:"Semi-structured data, operators, indexing and query design.",material:"11-expert-sql/04-json-jsonb.sql",theory:"11-expert-sql/THEORY.md"},
 {id:"08",level:"Expert",title:"Partitioning & RLS",desc:"Large tables, pruning, row-level security and operational design.",material:"11-expert-sql/07-row-level-security.sql",theory:"COMPLETE-SQL-THEORY.md"},
 {id:"09",level:"Data Engineering",title:"Cohorts & incremental loads",desc:"Data quality, retention, watermarks and analytics.",material:"12-data-engineering/03-incremental-load.sql",theory:"12-data-engineering/README.md"},
 {id:"10",level:"Real World",title:"Banking project",desc:"Schema, seed data, transfers, reports, security and troubleshooting.",material:"08-banking-project/schema.sql",theory:"08-banking-project/README.md"}
];

const repoBase="https://github.com/Narsing-s/sql-from-zero-to-advanced/blob/main/";

export default function Home(){
 const [user,setUser]=useState<string|null>(typeof window!=="undefined"?localStorage.getItem("sql_user"):null);
 const [email,setEmail]=useState("");
 const [greeting,setGreeting]=useState("");
 const [search,setSearch]=useState("");
 const [selected,setSelected]=useState<string|null>(null);
 const [done,setDone]=useState<string[]>(typeof window!=="undefined"?JSON.parse(localStorage.getItem("sql_done")||"[]"):[]);
 const filtered=useMemo(()=>lessons.filter(x=>(x.title+" "+x.desc+" "+x.level).toLowerCase().includes(search.toLowerCase())),[search]);
 const login=async()=>{
   if(!email.includes("@"))return;
   localStorage.setItem("sql_user",email);setUser(email);
   try{
     const r=await fetch("/api/welcome-email",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({email,name:email.split("@")[0]})});
     const d=await r.json();
     setGreeting(d.message||"Thanks for choosing SQL From Zero to Advanced! Welcome to your SQL learning journey.");
   }catch{
     setGreeting("Thanks for choosing SQL From Zero to Advanced! Welcome to your SQL learning journey.");
   }
 };
 const toggle=(id:string)=>{
   const next=done.includes(id)?done.filter(x=>x!==id):[...done,id];
   setDone(next);localStorage.setItem("sql_done",JSON.stringify(next));
 };
 const openMaterial=(path:string)=>window.open(repoBase+path,"_blank","noopener,noreferrer");
 const openTheory=(path:string)=>window.open(repoBase+path,"_blank","noopener,noreferrer");

 if(!user)return <main className="shell"><div className="container"><nav className="nav"><div className="brand">SQL<span>Lab</span></div><div className="pill">Open source learning</div></nav><section className="hero"><div className="eyebrow">From zero → production</div><h1>Learn SQL by <span className="green">building</span>.</h1><p className="sub">A structured PostgreSQL journey with theory, runnable queries, practice challenges, real-world projects and production engineering.</p></section><div className="card login-card"><h2>Start your learning journey</h2><p className="muted">Local demo login. Your progress stays in this browser.</p><input className="input" placeholder="you@example.com" value={email} onChange={e=>setEmail(e.target.value)}/><button className="btn primary full" onClick={login}>Enter SQL Lab <ArrowRight size={16}/></button>{greeting&&<p className="green">{greeting}</p>}<p className="muted small">No password, API key, external email provider, or external authentication is required.</p></div></div></main>;

 return <main className="shell"><div className="container"><nav className="nav"><div className="brand">SQL<span>Lab</span></div><div className="row"><span className="pill">{user}</span><button className="btn" onClick={()=>{localStorage.removeItem("sql_user");setUser(null)}}>Sign out</button></div></nav>
 <section className="hero"><div className="eyebrow">Your SQL workspace</div><h1>Build database <span className="green">confidence</span>.</h1><p className="sub">Theory first. Material next. Practice until it becomes production skill.</p>
 <div className="grid two"><div className="card"><div className="between"><div><div className="muted">Progress</div><strong>{done.length} / {lessons.length} lessons</strong></div><Database className="green"/></div><div className="progress" style={{marginTop:14}}><i style={{width:(done.length/lessons.length*100)+"%"}}/></div></div>
 <div className="card"><div className="muted">Welcome</div><h3>You're in. 🎓</h3><p className="muted">Open any curriculum item to see its theory and SQL material on GitHub.</p><div className="row"><Mail size={16}/><span className="pill">local greeting</span></div></div></div></section>

 <section className="card"><div className="between"><div><h2>Curriculum</h2><p className="muted">Choose a lesson → read theory → open SQL → practice → mark complete.</p></div><div className="row"><Search size={17}/><input className="input search" placeholder="Search lessons" value={search} onChange={e=>setSearch(e.target.value)}/></div></div>
 {filtered.map(l=><div className="lesson" key={l.id}><div className="pill">{l.level}</div><div className="lesson-body"><div className="between"><div><strong>{l.title}</strong><div className="muted">{l.desc}</div></div><div className="row"><button className="btn" onClick={()=>setSelected(selected===l.id?null:l.id)}><BookOpen size={16}/> Open</button><button className="btn" onClick={()=>toggle(l.id)}>{done.includes(l.id)?<CheckCircle2 size={16}/>:<CheckCircle2 size={16}/>} {done.includes(l.id)?"Done":"Mark done"}</button></div></div>
 {selected===l.id&&<div className="material-panel"><h3>{l.title}</h3><p className="muted">Start with the explanation, then open the runnable repository material.</p><div className="row"><button className="btn primary" onClick={()=>openTheory(l.theory)}><BookOpen size={16}/> Read theory <ExternalLink size={14}/></button><button className="btn" onClick={()=>openMaterial(l.material)}><PlayCircle size={16}/> Open SQL material <ExternalLink size={14}/></button></div><p className="small muted">Material: <code>{l.material}</code></p></div>}</div></div>)}
 {filtered.length===0&&<div className="empty">No lessons match your search.</div>}</section>

 <section className="grid" style={{margin:"20px 0 60px"}}><div className="card"><Terminal className="green"/><h3>Runnable SQL</h3><p className="muted">Every lesson now has a direct path to repository material instead of a dead button.</p></div><div className="card"><ShieldCheck className="green"/><h3>Production thinking</h3><p className="muted">Indexes, locks, security, RCA and performance tuning are part of the learning path.</p></div><div className="card"><BookOpen className="green"/><h3>Theory first</h3><p className="muted">Definitions and mental models come before commands so beginners understand what they run.</p></div></section>
 </div></main>;
}
