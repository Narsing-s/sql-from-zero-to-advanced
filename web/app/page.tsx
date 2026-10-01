"use client";

import {useMemo,useState} from "react";
import {BookOpen,CheckCircle2,ChevronDown,ChevronRight,Database,ExternalLink,Mail,Search,ShieldCheck,Terminal,Play,RotateCcw,FlaskConical} from "lucide-react";

type Topic={path:string;title:string;type:"Theory"|"SQL"|"Practice"|"Project"|"Reference";desc:string};
type Stage={id:string;title:string;desc:string;topics:Topic[]};

const repoBase="https://github.com/Narsing-s/sql-from-zero-to-advanced/blob/main/";
const rawBase="https://raw.githubusercontent.com/Narsing-s/sql-from-zero-to-advanced/main/";

const stages:Stage[]=[
 {id:"00",title:"Installation & Environment",desc:"Set up PostgreSQL, verify the environment and safely start learning.",topics:[
  {path:"00-installation/README.md",title:"Installation theory & process",type:"Theory",desc:"PostgreSQL, psql, pgAdmin, connections and safe setup."},
  {path:"00-installation/postgresql-setup.sql",title:"PostgreSQL setup",type:"SQL",desc:"Create the learning environment."},
  {path:"00-installation/verification.sql",title:"Environment verification",type:"SQL",desc:"Verify database, schema and installation."},
  {path:"INSTALLATION.md",title:"Complete installation guide",type:"Theory",desc:"Windows, macOS, Linux, Docker, Git, troubleshooting and first run."},
  {path:"DOWNLOAD-AND-SETUP.md",title:"Download & setup guide",type:"Theory",desc:"Download links, clone/ZIP process and setup guidance."}
 ]},
 {id:"01",title:"Beginner SQL",desc:"Build the relational mental model before memorizing commands.",topics:[
  {path:"01-beginner/README.md",title:"Beginner learning guide",type:"Theory",desc:"Definitions, mental models, syntax, practice and mistakes."},
  {path:"01-beginner/01-database-basics.sql",title:"Database basics",type:"SQL",desc:"Databases, schemas, tables, rows, columns and keys."},
  {path:"01-beginner/02-create-tables.sql",title:"Create tables",type:"SQL",desc:"DDL, data types and table structure."},
  {path:"01-beginner/03-insert.sql",title:"INSERT",type:"SQL",desc:"Add rows and understand DML."},
  {path:"01-beginner/04-select.sql",title:"SELECT",type:"SQL",desc:"Read data with expressions and aliases."},
  {path:"01-beginner/05-where.sql",title:"WHERE",type:"SQL",desc:"Filter rows with predicates."},
  {path:"01-beginner/06-order-by.sql",title:"ORDER BY",type:"SQL",desc:"Sort result sets predictably."},
  {path:"01-beginner/07-update.sql",title:"UPDATE",type:"SQL",desc:"Modify existing rows safely."},
  {path:"01-beginner/08-delete.sql",title:"DELETE",type:"SQL",desc:"Remove rows with controlled predicates."},
  {path:"01-beginner/09-null.sql",title:"NULL",type:"SQL",desc:"Missing/unknown values and NULL semantics."},
  {path:"01-beginner/10-practice-challenge.sql",title:"Beginner practice challenge",type:"Practice",desc:"Apply beginner concepts together."},
  {path:"01-beginner/exercises/README.md",title:"Beginner exercises",type:"Practice",desc:"Guided exercises for independent practice."}
 ]},
 {id:"02",title:"Intermediate SQL",desc:"Move from single-table queries to business questions.",topics:[
  {path:"02-intermediate/README.md",title:"Intermediate learning guide",type:"Theory",desc:"Joins, aggregation, subqueries and conditional logic."},
  {path:"02-intermediate/01-joins.sql",title:"JOINs",type:"SQL",desc:"Combine related data across tables."},
  {path:"02-intermediate/02-group-by.sql",title:"GROUP BY",type:"SQL",desc:"Aggregate data by business dimensions."},
  {path:"02-intermediate/03-having.sql",title:"HAVING",type:"SQL",desc:"Filter aggregated groups."},
  {path:"02-intermediate/04-subqueries.sql",title:"Subqueries",type:"SQL",desc:"Nest queries and compare related results."},
  {path:"02-intermediate/05-case.sql",title:"CASE",type:"SQL",desc:"Express conditional business rules."},
  {path:"02-intermediate/08-practice-challenge.sql",title:"Intermediate practice challenge",type:"Practice",desc:"Combine joins, aggregation and CASE."}
 ]},
 {id:"03",title:"Advanced SQL",desc:"Build reusable, analytical and database-side logic.",topics:[
  {path:"03-advanced/README.md",title:"Advanced learning guide",type:"Theory",desc:"CTEs, windows, views, functions, procedures and triggers."},
  {path:"03-advanced/01-cte.sql",title:"CTEs",type:"SQL",desc:"Structure complex queries as readable stages."},
  {path:"03-advanced/02-recursive-cte.sql",title:"Recursive CTEs",type:"SQL",desc:"Query hierarchical and recursive data."},
  {path:"03-advanced/03-window-functions.sql",title:"Window functions",type:"SQL",desc:"Ranking, running totals and row-wise analytics."},
  {path:"03-advanced/04-views.sql",title:"Views",type:"SQL",desc:"Create reusable logical query interfaces."},
  {path:"03-advanced/05-functions.sql",title:"Functions",type:"SQL",desc:"Encapsulate reusable database logic."},
  {path:"03-advanced/06-procedures.sql",title:"Procedures",type:"SQL",desc:"Execute procedural database operations."},
  {path:"03-advanced/07-triggers.sql",title:"Triggers",type:"SQL",desc:"React to table events and enforce automation."},
  {path:"03-advanced/08-practice-challenge.sql",title:"Advanced practice challenge",type:"Practice",desc:"Combine advanced query techniques."}
 ]},
 {id:"04",title:"Database Design",desc:"Design schemas that represent business rules and preserve integrity.",topics:[
  {path:"04-database-design/README.md",title:"Database design theory",type:"Theory",desc:"Entities, relationships, keys, constraints and normalization."},
  {path:"04-database-design/BCNF-and-advanced-normalization.md",title:"BCNF & advanced normalization",type:"Theory",desc:"Higher normal forms and dependency reasoning."}
 ]},
 {id:"05",title:"Transactions & Concurrency",desc:"Understand correctness when multiple operations happen together.",topics:[
  {path:"05-transactions/acid.md",title:"ACID theory",type:"Theory",desc:"Atomicity, consistency, isolation and durability."},
  {path:"05-transactions/transactions.sql",title:"Transactions",type:"SQL",desc:"BEGIN, COMMIT, ROLLBACK and safe units of work."},
  {path:"05-transactions/isolation-levels.sql",title:"Isolation levels",type:"SQL",desc:"Concurrency anomalies and PostgreSQL isolation."}
 ]},
 {id:"06",title:"Performance",desc:"Understand how PostgreSQL plans and executes SQL.",topics:[
  {path:"06-performance/README.md",title:"Performance theory",type:"Theory",desc:"Planner, indexes, statistics and performance workflow."},
  {path:"06-performance/indexes.sql",title:"Indexes",type:"SQL",desc:"Index structures, access paths and trade-offs."},
  {path:"06-performance/explain.sql",title:"EXPLAIN",type:"SQL",desc:"Read execution plans and diagnose slow queries."}
 ]},
 {id:"07",title:"Security",desc:"Protect data and design safe database access.",topics:[
  {path:"07-security/README.md",title:"Database security",type:"Theory",desc:"Least privilege, injection prevention, secrets and access control."}
 ]},
 {id:"08",title:"Banking Project",desc:"Apply schema design, transactions and reporting to a realistic domain.",topics:[
  {path:"08-banking-project/README.md",title:"Banking project guide",type:"Project",desc:"Project architecture, workflow and learning goals."},
  {path:"08-banking-project/schema.sql",title:"Banking schema",type:"Project",desc:"Customers, accounts, transactions and constraints."},
  {path:"08-banking-project/seed.sql",title:"Banking seed data",type:"Project",desc:"Load realistic sample data."},
  {path:"08-banking-project/transfers.sql",title:"Bank transfers",type:"Project",desc:"Transactional transfer logic and safety."},
  {path:"08-banking-project/reports.sql",title:"Banking reports",type:"Project",desc:"Operational and analytical reporting queries."}
 ]},
 {id:"09",title:"Real-World Scenarios",desc:"Practice production-style diagnosis and recovery thinking.",topics:[
  {path:"09-real-world-scenarios/README.md",title:"Scenario guide",type:"Theory",desc:"A repeatable production troubleshooting workflow."},
  {path:"09-real-world-scenarios/slow-query.md",title:"Slow query incident",type:"Practice",desc:"Investigate performance symptoms and evidence."},
  {path:"09-real-world-scenarios/duplicate-data.md",title:"Duplicate data incident",type:"Practice",desc:"Find causes and prevent duplicate records."},
  {path:"09-real-world-scenarios/deadlock.md",title:"Deadlock incident",type:"Practice",desc:"Understand locks, cycles and prevention."},
  {path:"09-real-world-scenarios/outage.md",title:"Database outage incident",type:"Practice",desc:"Work through outage diagnosis and recovery."}
 ]},
 {id:"10",title:"Interview Preparation",desc:"Turn concepts into clear technical interview answers.",topics:[
  {path:"10-interview-preparation/README.md",title:"Interview roadmap",type:"Reference",desc:"Structured interview preparation."},
  {path:"10-interview-preparation/beginner.md",title:"Beginner interview questions",type:"Reference",desc:"Foundational SQL questions and answers."},
  {path:"10-interview-preparation/intermediate.md",title:"Intermediate interview questions",type:"Reference",desc:"Joins, aggregation and query reasoning."},
  {path:"10-interview-preparation/advanced.md",title:"Advanced interview questions",type:"Reference",desc:"Advanced SQL and PostgreSQL topics."},
  {path:"10-interview-preparation/scenario-based.md",title:"Scenario-based questions",type:"Reference",desc:"Production troubleshooting and design scenarios."}
 ]},
 {id:"11",title:"Expert PostgreSQL",desc:"Study PostgreSQL-specific features and production-grade SQL.",topics:[
  {path:"11-expert-sql/README.md",title:"Expert SQL roadmap",type:"Theory",desc:"PostgreSQL expert learning sequence."},
  {path:"11-expert-sql/THEORY.md",title:"Expert SQL theory",type:"Theory",desc:"Advanced PostgreSQL concepts and mental models."},
  {path:"11-expert-sql/01-null-three-valued-logic.sql",title:"NULL & three-valued logic",type:"SQL",desc:"TRUE, FALSE and UNKNOWN in expert SQL."},
  {path:"11-expert-sql/02-lateral-and-distinct-on.sql",title:"LATERAL & DISTINCT ON",type:"SQL",desc:"PostgreSQL query patterns for per-group results."},
  {path:"11-expert-sql/03-advanced-aggregates.sql",title:"Advanced aggregates",type:"SQL",desc:"FILTER and advanced aggregation patterns."},
  {path:"11-expert-sql/04-json-jsonb.sql",title:"JSON & JSONB",type:"SQL",desc:"Semi-structured data and indexing."},
  {path:"11-expert-sql/05-upsert-merge.sql",title:"UPSERT & MERGE",type:"SQL",desc:"Idempotent writes and synchronization."},
  {path:"11-expert-sql/06-partitioning.md",title:"Partitioning",type:"Theory",desc:"Partition strategy, pruning and operational trade-offs."},
  {path:"11-expert-sql/07-row-level-security.sql",title:"Row-level security",type:"SQL",desc:"Restrict visible rows by policy."},
  {path:"11-expert-sql/08-materialized-views.md",title:"Materialized views",type:"Theory",desc:"Persist expensive query results and refresh them."},
  {path:"11-expert-sql/09-full-text-search.sql",title:"Full-text search",type:"SQL",desc:"tsvector, tsquery and indexed search."},
  {path:"11-expert-sql/10-advisory-locks.sql",title:"Advisory locks",type:"SQL",desc:"Application-coordinated concurrency control."}
 ]},
 {id:"12",title:"Data Engineering",desc:"Build reliable data quality, analytics and loading workflows.",topics:[
  {path:"12-data-engineering/README.md",title:"Data engineering guide",type:"Theory",desc:"Data quality, analytics and incremental processing."},
  {path:"12-data-engineering/01-data-quality.sql",title:"Data quality checks",type:"SQL",desc:"Find missing, duplicate and inconsistent data."},
  {path:"12-data-engineering/02-cohort-retention.sql",title:"Cohort retention",type:"SQL",desc:"Build cohort and retention analysis."},
  {path:"12-data-engineering/03-incremental-load.sql",title:"Incremental loads",type:"SQL",desc:"Use watermarks for repeatable data loading."}
 ]},
 {id:"13",title:"Real-World Projects",desc:"Move from isolated lessons to complete project delivery.",topics:[
  {path:"13-real-world-projects/README.md",title:"Project roadmap",type:"Project",desc:"How to turn SQL skills into portfolio projects."},
  {path:"13-real-world-projects/project-checklist.md",title:"Project checklist",type:"Project",desc:"Requirements for designing, testing and documenting projects."}
 ]},
];

const rootTopics:Topic[]=[
 {path:"COMPLETE-SQL-THEORY.md",title:"Complete SQL Theory",type:"Reference",desc:"Modern theory-first reference from zero to production PostgreSQL."},
 {path:"CORE-CONCEPTS.md",title:"Core Concepts",type:"Reference",desc:"SQL and database definitions glossary."},
 {path:"ADVANCED-EXPERT-THEORY.md",title:"Advanced & Expert Theory",type:"Reference",desc:"Deep concepts for advanced and expert learners."},
 {path:"MISSING-CONCEPTS-CHECKLIST.md",title:"Missing Concepts Checklist",type:"Reference",desc:"Coverage checklist for the learning curriculum."},
 {path:"ROADMAP.md",title:"Learning Roadmap",type:"Reference",desc:"High-level course progression."},
 {path:"CONTRIBUTING.md",title:"Contributing",type:"Reference",desc:"How learners and contributors can improve the project."},
 {path:"datasets/README.md",title:"Datasets",type:"Reference",desc:"Dataset guidance for hands-on practice."},
 {path:"docker/docker-compose.yml",title:"Docker environment",type:"Reference",desc:"Optional containerized environment."}
];



type LabChallenge={id:string;level:"Beginner"|"Intermediate"|"Advanced"|"Expert";category:string;title:string;question:string;hint:string;sql:string;explanation:string};
const LAB_SETUP=[
"DROP SCHEMA IF EXISTS lab CASCADE;","CREATE SCHEMA lab;","SET search_path TO lab;",
"CREATE TABLE departments(id INT PRIMARY KEY,name TEXT NOT NULL);",
"CREATE TABLE employees(id INT PRIMARY KEY,name TEXT NOT NULL,department_id INT REFERENCES departments(id),salary NUMERIC(10,2),manager_id INT);",
"CREATE TABLE customers(id INT PRIMARY KEY,name TEXT NOT NULL,age INT,city TEXT,email TEXT);",
"CREATE TABLE accounts(id INT PRIMARY KEY,customer_id INT REFERENCES customers(id),balance NUMERIC(12,2),status TEXT);",
"CREATE TABLE products(id INT PRIMARY KEY,name TEXT,category TEXT,price NUMERIC(10,2),stock INT);",
"CREATE TABLE orders(id INT PRIMARY KEY,customer_id INT REFERENCES customers(id),product_id INT REFERENCES products(id),quantity INT,order_date DATE);",
"CREATE TABLE payments(id INT PRIMARY KEY,customer_id INT REFERENCES customers(id),amount NUMERIC(10,2),status TEXT,payment_date DATE);",
"CREATE TABLE students(id INT PRIMARY KEY,name TEXT,age INT);","CREATE TABLE courses(id INT PRIMARY KEY,name TEXT,fee NUMERIC(10,2));",
"CREATE TABLE enrollments(student_id INT REFERENCES students(id),course_id INT REFERENCES courses(id),score INT,PRIMARY KEY(student_id,course_id));",
"CREATE TABLE json_events(id INT PRIMARY KEY,payload JSONB);",
"INSERT INTO departments VALUES(1,'Engineering'),(2,'Finance'),(3,'HR');",
"INSERT INTO employees VALUES(1,'Asha',1,90000,NULL),(2,'Ravi',1,70000,1),(3,'Priya',2,65000,NULL),(4,'Arun',2,55000,3),(5,'Meena',3,50000,NULL);",
"INSERT INTO customers VALUES(1,'Ravi',31,'Hyderabad','ravi@example.com'),(2,'Priya',28,'Visakhapatnam','priya@example.com'),(3,'Arun',35,'Hyderabad','arun@example.com'),(4,'Meena',24,'Chennai','meena@example.com'),(5,'Kiran',42,'Bengaluru',NULL);",
"INSERT INTO accounts VALUES(101,1,5000,'ACTIVE'),(102,2,8000,'ACTIVE'),(103,3,2500,'BLOCKED'),(104,5,12000,'ACTIVE');",
"INSERT INTO products VALUES(1,'Laptop','Electronics',75000,10),(2,'Mouse','Electronics',1200,50),(3,'Desk','Furniture',15000,8),(4,'Chair','Furniture',8000,20);",
"INSERT INTO orders VALUES(1,1,1,1,'2026-01-10'),(2,2,2,3,'2026-01-12'),(3,3,3,2,'2026-02-01'),(4,1,4,1,'2026-02-04'),(5,5,1,2,'2026-02-10');",
"INSERT INTO payments VALUES(1,1,5000,'SUCCESS','2026-01-10'),(2,2,3600,'SUCCESS','2026-01-12'),(3,3,30000,'FAILED','2026-02-01');",
"INSERT INTO students VALUES(1,'Anil',20),(2,'Bina',21),(3,'Charan',20);","INSERT INTO courses VALUES(1,'SQL',5000),(2,'PostgreSQL',7000),(3,'Data Engineering',9000);",
"INSERT INTO enrollments VALUES(1,1,88),(1,2,91),(2,1,76),(2,3,84),(3,1,95);",
"INSERT INTO json_events VALUES(1,'{\"type\":\"login\",\"user_id\":1}'),(2,'{\"type\":\"payment\",\"user_id\":2,\"amount\":800}');"
].join("\n");
const labExamples=[["DDL","CREATE TABLE lab.demo(id INT PRIMARY KEY,name TEXT);"],["INSERT","INSERT INTO lab.demo VALUES(1,'Narsing');"],["SELECT","SELECT * FROM lab.customers WHERE age>30;"],["UPDATE","UPDATE lab.accounts SET balance=balance+500 WHERE id=101;"],["DELETE","DELETE FROM lab.customers WHERE id=5;"],["JOIN","SELECT c.name,a.balance FROM lab.customers c JOIN lab.accounts a ON a.customer_id=c.id;"],["GROUP BY","SELECT city,COUNT(*) FROM lab.customers GROUP BY city;"],["HAVING","SELECT city,COUNT(*) FROM lab.customers GROUP BY city HAVING COUNT(*)>1;"],["CASE","SELECT name,CASE WHEN age>=30 THEN 'Adult' ELSE 'Young' END FROM lab.customers;"],["SUBQUERY","SELECT name FROM lab.customers WHERE id IN(SELECT customer_id FROM lab.accounts WHERE balance>5000);"],["CTE","WITH rich AS(SELECT * FROM lab.accounts WHERE balance>5000) SELECT * FROM rich;"],["WINDOW","SELECT name,salary,RANK() OVER(ORDER BY salary DESC) FROM lab.employees;"],["RECURSIVE","WITH RECURSIVE tree AS(SELECT id,name,manager_id FROM lab.employees WHERE manager_id IS NULL UNION ALL SELECT e.id,e.name,e.manager_id FROM lab.employees e JOIN tree t ON e.manager_id=t.id) SELECT * FROM tree;"],["UPSERT","INSERT INTO lab.accounts VALUES(101,1,9000,'ACTIVE') ON CONFLICT(id) DO UPDATE SET balance=EXCLUDED.balance;"],["JSONB","SELECT id,payload->>'type' AS event_type FROM lab.json_events;"],["TRANSACTION","BEGIN; UPDATE lab.accounts SET balance=balance-100 WHERE id=101; ROLLBACK;"],["VIEW","CREATE OR REPLACE VIEW lab.active_accounts AS SELECT * FROM lab.accounts WHERE status='ACTIVE'; SELECT * FROM lab.active_accounts;"],["INDEX","CREATE INDEX IF NOT EXISTS lab_customers_city_idx ON lab.customers(city);"],["EXPLAIN","EXPLAIN SELECT * FROM lab.customers WHERE city='Hyderabad';"],["NULL","SELECT name FROM lab.customers WHERE email IS NULL;"]];
const labChallenges:LabChallenge[]=labExamples.map(([category,sql],i)=>({id:"op-"+i,level:i<10?"Beginner":i<15?"Intermediate":"Advanced",category,title:category+" operation",question:"Practice the "+category+" operation using the browser PostgreSQL dataset.",hint:"Use the operation starter or write your own valid PostgreSQL solution.",sql,explanation:"This challenge is part of the full SQL operations lab. Multiple valid SQL approaches are allowed."}));
labChallenges.push({id:"expert-1",level:"Expert",category:"FULL SQL",title:"Build your own solution",question:"Use the editor to solve any SQL problem against the complete lab schema.",hint:"Try joins, CTEs, windows, JSONB, transactions or performance commands.",sql:"SELECT c.name,SUM(o.quantity*p.price) AS total_spend FROM lab.customers c JOIN lab.orders o ON o.customer_id=c.id JOIN lab.products p ON p.id=o.product_id GROUP BY c.name ORDER BY total_spend DESC;",explanation:"Expert practice combines multiple SQL concepts into one business query."});

function PracticeLab({onClose}:{onClose:()=>void}){
 const [challengeId,setChallengeId]=useState(labChallenges[0].id); const [sql,setSql]=useState(labChallenges[0].sql);
 const [rows,setRows]=useState<any[]>([]); const [columns,setColumns]=useState<string[]>([]); const [error,setError]=useState(""); const [message,setMessage]=useState(""); const [filter,setFilter]=useState("All");
 const [db,setDb]=useState<any>(null); const [ready,setReady]=useState(false); const [completed,setCompleted]=useState<string[]>(typeof window!=="undefined"?JSON.parse(localStorage.getItem("sql_lab_done")||"[]"):[]);
 const boot=async()=>{setError("");try{const {PGlite}=await import("@electric-sql/pglite");const pg=new PGlite();await pg.exec(LAB_SETUP);setDb(pg);setReady(true);setMessage("Browser PostgreSQL is ready.");return pg}catch(e:any){setError(e?.message||"Unable to start PostgreSQL.");}};
 const run=async()=>{setError("");setMessage("");try{const pg=db||await boot();if(!pg)return;const r=await pg.query(sql);setRows(r.rows||[]);setColumns(r.fields?.map((f:any)=>f.name)||Object.keys(r.rows?.[0]||{}));setMessage("SQL executed successfully.")}catch(e:any){setError(e?.message||"SQL error")}};
 const reset=async()=>{try{const pg=db||await boot();if(pg){await pg.exec(LAB_SETUP);setRows([]);setColumns([]);setMessage("Database reset to the full practice dataset.")}}catch(e:any){setError(e?.message||"Reset failed")}};
 const choose=(x:LabChallenge)=>{setChallengeId(x.id);setSql(x.sql);setRows([]);setColumns([]);setError("");setMessage("")};
 const check=async()=>{await run();const x=labChallenges.find(v=>v.id===challengeId)!;if(x){const next=completed.includes(x.id)?completed:[...completed,x.id];setCompleted(next);localStorage.setItem("sql_lab_done",JSON.stringify(next));setMessage("Challenge submitted. Review the result and explanation, then continue to the next operation.")}};
 const cats=["All",...Array.from(new Set(labChallenges.map(x=>x.category)))]; const visible=filter==="All"?labChallenges:labChallenges.filter(x=>x.category===filter); const current=labChallenges.find(x=>x.id===challengeId)!;
 return <section className="card lab-view"><div className="between"><div><div className="eyebrow">PostgreSQL hands-on</div><h2><FlaskConical size={22}/> Complete SQL Practice Lab</h2><p className="muted">Practice the full operation surface in a real PostgreSQL engine running locally in your browser. No API key or external database is required.</p></div><button className="btn" onClick={onClose}>Close</button></div>
 <div className="lab-toolbar"><div className="row">{cats.map(x=><button key={x} className={filter===x?"btn primary":"btn"} onClick={()=>setFilter(x)}>{x}</button>)}</div></div>
 <div className="lab-grid"><aside className="lab-challenges"><div className="muted small">OPERATIONS · {visible.length}</div>{visible.map(x=><button key={x.id} className={x.id===current.id?"lab-challenge active":"lab-challenge"} onClick={()=>choose(x)}><span><b>{x.title}</b><small>{x.level} · {x.category}</small></span>{completed.includes(x.id)&&<CheckCircle2 size={16}/>}</button>)}</aside>
 <div className="lab-work"><div className="lab-question"><span className="pill">{current.level} · {current.category}</span><h3>{current.title}</h3><p>{current.question}</p><p className="muted">Hint: {current.hint}</p></div><div className="lab-examples"><div className="muted small">ALL OPERATION STARTERS</div><div className="row">{labExamples.map(([name,example])=><button className="pill lab-example" key={name} onClick={()=>setSql(example)}>{name}</button>)}</div></div><textarea className="sql-editor" value={sql} onChange={e=>setSql(e.target.value)} spellCheck={false}/><div className="row"><button className="btn primary" onClick={run}><Play size={15}/>Run SQL</button><button className="btn" onClick={check}>Run & Track</button><button className="btn" onClick={reset}><RotateCcw size={15}/>Reset DB</button>{!ready&&<button className="btn" onClick={boot}>Start PostgreSQL</button>}</div>{error&&<div className="lab-error">{error}</div>}{message&&<div className="lab-feedback">{message}</div>}<div className="lab-result"><div className="muted small">POSTGRESQL RESULT</div>{rows.length?<table><thead><tr>{columns.map(c=><th key={c}>{c}</th>)}</tr></thead><tbody>{rows.map((row,i)=><tr key={i}>{columns.map(c=><td key={c}>{String(row[c]??"NULL")}</td>)}</tr>)}</tbody></table>:<p className="muted">Run any valid SQL operation to see its result.</p>}</div></div></div><p className="muted small lab-note">The browser database includes customers, accounts, products, orders, payments, employees, departments, students, courses, enrollments and JSONB events. Reset restores it.</p></section>;
}
function TopicRow({topic,done,onToggle,onOpen}:{topic:Topic;done:boolean;onToggle:()=>void;onOpen:()=>void}){
 const url=repoBase+topic.path;
 return <div className={`topic-row ${done?"completed":""}`}>
   <div className="topic-icon"><BookOpen size={17}/></div>
   <div className="topic-main">
     <div className="between"><div><button className="topic-title" onClick={onOpen}>{topic.title}</button><span className="topic-type">{topic.type}</span></div>
       <div className="row">
         <button className="btn" onClick={onOpen}>Read material</button><a className="btn" href={url} target="_blank" rel="noreferrer">GitHub <ExternalLink size={14}/></a>
         <button className={`btn ${done?"primary":""}`} onClick={onToggle}>{done?<CheckCircle2 size={16}/>:<CheckCircle2 size={16}/>} {done?"Completed":"Mark completed"}</button>
       </div>
     </div>
     <div className="muted topic-desc">{topic.desc}</div>
   </div>
 </div>;
}

export default function Home(){
 const [user,setUser]=useState<string|null>(typeof window!=="undefined"?localStorage.getItem("sql_user"):null);
 const [email,setEmail]=useState("");
 const [greeting,setGreeting]=useState("");
 const [search,setSearch]=useState("");
 const [open,setOpen]=useState<string|null>("00");
 const [selected,setSelected]=useState<Topic|null>(null);
 const [material,setMaterial]=useState("");
 const [loadingMaterial,setLoadingMaterial]=useState(false);
 const [view,setView]=useState<"all"|"completed"|"theory">("all");
 const [labOpen,setLabOpen]=useState(false);
 const [done,setDone]=useState<string[]>(typeof window!=="undefined"?JSON.parse(localStorage.getItem("sql_done")||"[]"):[]);
 const allTopics=[...stages.flatMap(s=>s.topics),...rootTopics];
 const filteredStages=useMemo(()=>stages.map(s=>({...s,topics:s.topics.filter(t=>{
   const matchesSearch=(s.title+" "+t.title+" "+t.desc+" "+t.type).toLowerCase().includes(search.toLowerCase());
   return matchesSearch&&(view==="all"||view==="completed"&&done.includes(t.path)||view==="theory"&&t.type==="Theory");
 })})).filter(s=>s.topics.length),[search,view,done]);
 const filteredRoot=rootTopics.filter(t=>(t.title+" "+t.desc+" "+t.type).toLowerCase().includes(search.toLowerCase())&&(view==="all"||view==="completed"&&done.includes(t.path)||view==="theory"&&t.type==="Theory"));
 const completed=done.filter(id=>allTopics.some(t=>t.path===id)).length;
 const login=async()=>{
   if(!email.includes("@"))return;
   localStorage.setItem("sql_user",email);setUser(email);
   try{const r=await fetch("/api/welcome-email",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({email,name:email.split("@")[0]})});const d=await r.json();setGreeting(d.sent?"Welcome email sent successfully to "+email+".":d.message||"Welcome to SQL From Zero to Advanced!");}
   catch{setGreeting("Thanks for choosing SQL From Zero to Advanced! Welcome to your SQL learning journey.");}
 };
 const openMaterial=async(topic:Topic)=>{
   setSelected(topic);setLoadingMaterial(true);setMaterial("");
   try{const r=await fetch(rawBase+topic.path);if(!r.ok)throw new Error("load failed");setMaterial(await r.text());}
   catch{setMaterial("Unable to load the real repository material in this browser. Use the GitHub button below.");}
   finally{setLoadingMaterial(false);}
 };
 const toggle=(path:string)=>{const next=done.includes(path)?done.filter(x=>x!==path):[...done,path];setDone(next);localStorage.setItem("sql_done",JSON.stringify(next));};

 if(!user)return <main className="shell"><div className="container"><nav className="nav"><div className="brand">SQL<span>Lab</span></div><div className="pill">Open source learning</div></nav><section className="hero"><div className="eyebrow">From zero → production</div><h1>Learn SQL by <span className="green">building</span>.</h1><p className="sub">Every stage, every topic, theory, SQL, exercises, projects and interview material in one visible learning workspace.</p></section><div className="card login-card"><h2>Start your learning journey</h2><p className="muted">Enter an email for a browser-local demo login. No API key is required.</p><input className="input" placeholder="you@example.com" value={email} onChange={e=>setEmail(e.target.value)} onKeyDown={e=>{if(e.key==="Enter")login()}}/><button className="btn primary full" onClick={login}>Enter SQL Lab <ChevronRight size={16}/></button>{greeting&&<p className="green">{greeting}</p>}<p className="muted small">Your progress stays in this browser. Real email delivery is optional.</p></div></div></main>;

 return <main className="shell"><div className="container"><nav className="nav"><div className="brand">SQL<span>Lab</span></div><div className="row"><button className="btn primary" onClick={()=>setLabOpen(true)}><FlaskConical size={15}/> Practice Lab</button><span className="pill">{user}</span><button className="btn" onClick={()=>{localStorage.removeItem("sql_user");setUser(null)}}>Sign out</button></div></nav>
 <section className="hero"><div className="eyebrow">Your complete SQL workspace</div><h1>Every topic. <span className="green">One path.</span></h1><p className="sub">Click a topic to open its real repository material. Mark each topic completed as you learn.</p>
 <div className="grid two"><div className="card"><div className="between"><div><div className="muted">Course progress</div><strong>{completed} / {allTopics.length} topics completed</strong></div><Database className="green"/></div><div className="progress" style={{marginTop:14}}><i style={{width:(completed/allTopics.length*100)+"%"}}/></div></div>
 <div className="card"><div className="muted">Learning order</div><h3>Read → Open → Practice → Complete</h3><p className="muted">Theory comes before runnable SQL, then exercises and real-world work.</p><div className="row"><Mail size={16}/><span className="pill">local login</span></div></div></div></section>
 {labOpen&&<PracticeLab onClose={()=>setLabOpen(false)}/>} 
 <section className="card curriculum"><div className="between"><div><h2>Complete Curriculum</h2><p className="muted">{allTopics.length} visible topics across installation → production.</p></div><div className="row"><Search size={17}/><input className="input search" placeholder="Search every topic" value={search} onChange={e=>setSearch(e.target.value)}/></div></div>
 {filteredStages.map(s=><div className="stage" key={s.id}><button className="stage-head" onClick={()=>setOpen(open===s.id?null:s.id)}><div><span className="stage-number">{s.id}</span><strong>{s.title}</strong><span className="muted stage-count">{s.topics.length} topics</span><div className="muted stage-desc">{s.desc}</div></div>{open===s.id?<ChevronDown/>:<ChevronRight/>}</button>{open===s.id&&<div className="stage-topics">{s.topics.map(t=><TopicRow key={t.path} topic={t} done={done.includes(t.path)} onToggle={()=>toggle(t.path)} onOpen={()=>openMaterial(t)}/>)}</div>}</div>)}
 {filteredRoot.length>0&&<div className="stage"><button className="stage-head" onClick={()=>setOpen(open==="reference"?null:"reference")}><div><span className="stage-number">★</span><strong>Repository Reference & Tools</strong><span className="muted stage-count">{filteredRoot.length} topics</span><div className="muted stage-desc">Core theory, roadmap, contribution and environment references.</div></div>{open==="reference"?<ChevronDown/>:<ChevronRight/>}</button>{open==="reference"&&<div className="stage-topics">{filteredRoot.map(t=><TopicRow key={t.path} topic={t} done={done.includes(t.path)} onToggle={()=>toggle(t.path)} onOpen={()=>openMaterial(t)}/>)}</div>}</div>}
 {filteredStages.length===0&&filteredRoot.length===0&&<div className="empty">No topics match your search.</div>}</section>
 <section className="grid" style={{margin:"20px 0 60px"}}>
 <button className="card action-card" onClick={()=>setView("all")}><Terminal className="green"/><h3>Real material</h3><p className="muted">Read the actual repository material inside this UI.</p></button>
 <button className="card action-card" onClick={()=>setView("completed")}><ShieldCheck className="green"/><h3>Track completion</h3><p className="muted">Show only topics you marked completed.</p></button>
 <button className="card action-card" onClick={()=>setView("theory")}><BookOpen className="green"/><h3>Theory first</h3><p className="muted">Show theory lessons before runnable SQL.</p></button>
 </section>
 {selected&&<section className="card material-view"><div className="between"><div><div className="eyebrow">{selected.type}</div><h2>{selected.title}</h2><p className="muted">{selected.desc}</p></div><button className="btn" onClick={()=>setSelected(null)}>Close</button></div><div className="row material-toolbar"><button className="btn primary" onClick={()=>toggle(selected.path)}>{done.includes(selected.path)?"Completed ✓":"Mark completed"}</button><a className="btn" href={repoBase+selected.path} target="_blank" rel="noreferrer">Open on GitHub <ExternalLink size={14}/></a></div><div className="material-content">{loadingMaterial?<p className="muted">Loading real material…</p>:<pre>{material}</pre>}</div></section>
 </div></main>;
}
