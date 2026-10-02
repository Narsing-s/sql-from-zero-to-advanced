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
  {path:"10-interview-preparation/scenario-based.md",title:"Scenario-based questions",type:"Reference",desc:"Production troubleshooting and design scenarios."},
  {path:"10-interview-preparation/complete-theory-qa.md",title:"Complete theory Q&A",type:"Reference",desc:"85 interview-ready SQL and PostgreSQL theory questions with answers."},
  {path:"10-interview-preparation/production-scenarios-qa.md",title:"Production scenario Q&A",type:"Reference",desc:"60 production troubleshooting and design scenarios with model answers."}
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

  {path:"11-expert-sql/11-recursive-search-cycle.sql",title:"Recursive SEARCH & CYCLE",type:"SQL",desc:"Ordered recursive traversal and cycle detection."},
  {path:"11-expert-sql/12-index-maintenance-concurrently.sql",title:"Concurrent index maintenance",type:"SQL",desc:"Safe guidance for concurrent index creation and reindexing."},  {path:"11-expert-sql/10-advisory-locks.sql",title:"Advisory locks",type:"SQL",desc:"Application-coordinated concurrency control."}
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
  {id:"14",title:"Production Database Operations",desc:"Production operations, incidents, monitoring, capacity and RCA.",topics:[{path:"production-operations/README.md",title:"Production Database Operations guide",type:"Reference",desc:"Production operations, incidents, monitoring, capacity and RCA."}]},
 {id:"15",title:"PostgreSQL Internals",desc:"Catalogs, WAL, vacuum and planner statistics.",topics:[{path:"postgresql-internals/README.md",title:"PostgreSQL Internals guide",type:"Reference",desc:"Catalogs, WAL, vacuum and planner statistics."}]},
 {id:"16",title:"Replication, HA & Disaster Recovery",desc:"Replication, high availability and disaster recovery.",topics:[{path:"replication-and-ha/README.md",title:"Replication, HA & Disaster Recovery guide",type:"Reference",desc:"Replication, high availability and disaster recovery."}]},
 {id:"17",title:"Backup, Restore & PITR Labs",desc:"Backups, restore testing and point-in-time recovery.",topics:[{path:"backup-and-recovery-labs/README.md",title:"Backup, Restore & PITR Labs guide",type:"Reference",desc:"Backups, restore testing and point-in-time recovery."}]},
 {id:"18",title:"Schema Migrations",desc:"Safe schema changes and minimal-downtime migration patterns.",topics:[{path:"schema-migrations/README.md",title:"Schema Migrations guide",type:"Reference",desc:"Safe schema changes and minimal-downtime migration patterns."}]},
 {id:"19",title:"Advanced PostgreSQL Types",desc:"Arrays, ranges, multiranges, enums, domains and identity/sequences.",topics:[{path:"advanced-types/README.md",title:"Advanced PostgreSQL Types guide",type:"Reference",desc:"Arrays, ranges, multiranges, enums, domains and identity/sequences."}]},
 {id:"20",title:"SQL/JSON",desc:"JSON, JSON path and JSON_TABLE.",topics:[{path:"sql-json/README.md",title:"SQL/JSON guide",type:"Reference",desc:"JSON, JSON path and JSON_TABLE."}]},
 {id:"21",title:"PostgreSQL Administration",desc:"Roles, configuration and foreign data wrappers.",topics:[{path:"postgresql-administration/README.md",title:"PostgreSQL Administration guide",type:"Reference",desc:"Roles, configuration and foreign data wrappers."}]},
 {id:"22",title:"Observability",desc:"Locks, waits, query statistics and operational evidence.",topics:[{path:"observability/README.md",title:"Observability guide",type:"Reference",desc:"Locks, waits, query statistics and operational evidence."}]},
 {id:"23",title:"Testing & CI/CD",desc:"Database testing, regression and CI/CD workflows.",topics:[{path:"testing-and-cicd/README.md",title:"Testing & CI/CD guide",type:"Reference",desc:"Database testing, regression and CI/CD workflows."}]},
 {id:"24",title:"PostgreSQL 18",desc:"PostgreSQL 18 features, maintenance and upgrade readiness.",topics:[{path:"postgresql-18/README.md",title:"PostgreSQL 18 guide",type:"Reference",desc:"PostgreSQL 18 features, maintenance and upgrade readiness."}]},
 {id:"25",title:"Production Capstone Projects",desc:"End-to-end production-oriented PostgreSQL projects.",topics:[{path:"capstone-projects/README.md",title:"Production Capstone Projects guide",type:"Reference",desc:"End-to-end production-oriented PostgreSQL projects."}]},
 {id:"26",title:"Advanced PostgreSQL",desc:"Event triggers, logical decoding, advanced indexes and server programming.",topics:[{path:"advanced-postgresql/README.md",title:"Advanced PostgreSQL guide",type:"Reference",desc:"Event triggers, logical decoding, advanced indexes and server programming."}]},
 {id:"27",title:"Data Governance",desc:"PII, retention, auditability and data quality.",topics:[{path:"data-governance/README.md",title:"Data Governance guide",type:"Reference",desc:"PII, retention, auditability and data quality."}]},
 {id:"28",title:"Capacity & Cost Engineering",desc:"Capacity planning, scaling and cost engineering.",topics:[{path:"capacity-and-cost/README.md",title:"Capacity & Cost Engineering guide",type:"Reference",desc:"Capacity planning, scaling and cost engineering."}]},
 {id:"29",title:"Client Integration",desc:"Application/database integration patterns.",topics:[{path:"client-integration/README.md",title:"Client Integration guide",type:"Reference",desc:"Application/database integration patterns."}]},
 {id:"30",title:"Interview & Scenario Labs",desc:"Advanced interview and production scenario practice.",topics:[{path:"interview-and-scenario-labs/README.md",title:"Interview & Scenario Labs guide",type:"Reference",desc:"Advanced interview and production scenario practice."}]},
 {id:"31",title:"SQL Standard & Compatibility",desc:"Portable SQL and PostgreSQL/MySQL/SQL Server/Oracle differences.",topics:[
  {path:"31-sql-standard-and-compatibility/02-pivot-and-cross-dialect-patterns.md",title:"Pivot & cross-dialect patterns",type:"Reference",desc:"Portable pivoting, unpivoting concepts and dialect-transfer guidance."},{path:"sql-standard-and-compatibility/README.md",title:"SQL Standard & Compatibility guide",type:"Reference",desc:"Portable SQL and PostgreSQL/MySQL/SQL Server/Oracle differences."}]},
 {id:"32",title:"Security Hardening",desc:"Role security, TLS, secrets, auditing and injection defenses.",topics:[{path:"security-hardening/README.md",title:"Security Hardening guide",type:"Reference",desc:"Role security, TLS, secrets, auditing and injection defenses."}]},
 {id:"33",title:"Migration & Upgrade Labs",desc:"Major-version migration and upgrade rehearsals.",topics:[{path:"migration-and-upgrade-labs/README.md",title:"Migration & Upgrade Labs guide",type:"Reference",desc:"Major-version migration and upgrade rehearsals."}]},
 {id:"34",title:"Final Master Checklist",desc:"Final SQL/PostgreSQL mastery verification.",topics:[{path:"final-master-checklist/README.md",title:"Final Master Checklist guide",type:"Reference",desc:"Final SQL/PostgreSQL mastery verification."}]},
 {id:"35",title:"PostgreSQL Complete Reference",desc:"Information schema, JIT, parallelism, sampling, errors, limits and extensions.",topics:[{path:"postgresql-complete-reference/README.md",title:"PostgreSQL Complete Reference guide",type:"Reference",desc:"Information schema, JIT, parallelism, sampling, errors, limits and extensions."}]},
 {id:"36",title:"Reliability Engineering",desc:"SLOs, reliability practices and operational resilience.",topics:[{path:"reliability-engineering/README.md",title:"Reliability Engineering guide",type:"Reference",desc:"SLOs, reliability practices and operational resilience."}]},
 {id:"37",title:"Streaming & Event Data",desc:"Streaming, CDC and event-driven data patterns.",topics:[{path:"streaming-and-event-data/README.md",title:"Streaming & Event Data guide",type:"Reference",desc:"Streaming, CDC and event-driven data patterns."}]},
 {id:"38",title:"Search & Text",desc:"Search, text, fuzzy matching and multilingual considerations.",topics:[{path:"search-and-text/README.md",title:"Search & Text guide",type:"Reference",desc:"Search, text, fuzzy matching and multilingual considerations."}]},
 {id:"39",title:"Advanced Data Modeling",desc:"Temporal, hierarchical and multi-tenant data models.",topics:[{path:"advanced-data-modeling/README.md",title:"Advanced Data Modeling guide",type:"Reference",desc:"Temporal, hierarchical and multi-tenant data models."}]},
 {id:"40",title:"Final Production Lab",desc:"Production simulation, failure response and recovery exercise.",topics:[{path:"final-production-lab/README.md",title:"Final Production Lab guide",type:"Reference",desc:"Production simulation, failure response and recovery exercise."}]},
 {id:"41",title:"Runnable PostgreSQL Labs",desc:"Hands-on operational labs for real PostgreSQL behavior.",topics:[
  {path:"41-runnable-labs/README.md",title:"Runnable lab guide",type:"Practice",desc:"Run operational PostgreSQL labs safely."},
  {path:"41-runnable-labs/01-advisory-locks-and-job-queue.sql",title:"Advisory locks & job queue",type:"SQL",desc:"Coordinate workers with locks and SKIP LOCKED."},
  {path:"41-runnable-labs/02-listen-notify.sql",title:"LISTEN / NOTIFY",type:"SQL",desc:"Explore database notifications and trigger-driven events."},
  {path:"41-runnable-labs/03-materialized-view-refresh.sql",title:"Materialized view refresh",type:"SQL",desc:"Build and refresh a materialized view safely."},
  {path:"41-runnable-labs/04-copy-and-bulk-load.sql",title:"COPY & bulk load",type:"SQL",desc:"Load data efficiently with PostgreSQL COPY."},
  {path:"41-runnable-labs/05-timezone-and-collation.sql",title:"Timezone & collation",type:"SQL",desc:"Test temporal and text ordering semantics."},
  {path:"41-runnable-labs/06-partition-maintenance.sql",title:"Partition maintenance",type:"SQL",desc:"Create partitions and observe pruning."},
  {path:"41-runnable-labs/07-row-level-security.sql",title:"Row-level security",type:"SQL",desc:"Implement tenant-aware RLS policies."},
  {path:"41-runnable-labs/08-query-statistics.sql",title:"Query statistics",type:"SQL",desc:"Inspect pg_stat_statements and query metrics."}
 ]},
 {id:"42",title:"Production Patterns",desc:"Patterns for operating PostgreSQL reliably in production.",topics:[
  {path:"42-production-patterns/README.md",title:"Production patterns",type:"Theory",desc:"Pooling, schema drift, performance baselines and backup verification."},
  {path:"42-production-patterns/01-connection-pooling.md",title:"Connection pooling",type:"Theory",desc:"Connection budgets, pooling and PgBouncer concepts."},
  {path:"42-production-patterns/02-schema-drift-and-regression.md",title:"Schema drift",type:"Practice",desc:"Detect schema changes and regression risks."},
  {path:"42-production-patterns/03-backup-verification.md",title:"Backup verification",type:"Practice",desc:"Verify backups through restore drills."}
 ]},
 {id:"43",title:"Validation & Automation",desc:"Turn lessons into repeatable, testable engineering workflows.",topics:[
  {path:"43-validation-and-automation/README.md",title:"Validation guide",type:"Theory",desc:"Lab contracts, safety rules and version-aware execution."},
  {path:"43-validation-and-automation/01-test-runner.sql",title:"SQL test runner",type:"SQL",desc:"Inspect database and curriculum test objects."},
  {path:"43-validation-and-automation/02-sql-safety-checklist.md",title:"SQL safety checklist",type:"Reference",desc:"Review scripts before execution."},
  {path:"43-validation-and-automation/03-version-matrix.md",title:"Version matrix",type:"Reference",desc:"Track PostgreSQL-version-specific labs."},
  {path:"43-validation-and-automation/04-lab-manifest.md",title:"Lab manifest",type:"Reference",desc:"Classify automated and opt-in labs."}
 ]},
 {id:"44",title:"Advanced Production SQL",desc:"Advanced PostgreSQL query patterns used in production systems.",topics:[
  {path:"44-advanced-production-sql/README.md",title:"Production SQL patterns",type:"Theory",desc:"Advanced query and write patterns."},
  {path:"44-advanced-production-sql/01-production-query-patterns.sql",title:"Production query patterns",type:"SQL",desc:"MERGE, RETURNING, cursors, grouping, locking and sampling."}
 ]},
 {id:"45",title:"PostgreSQL CI",desc:"Run deterministic SQL tests against PostgreSQL 18.6.",topics:[
  {path:"45-ci-postgresql/README.md",title:"CI architecture",type:"Theory",desc:"Docker, fixtures, assertions and safe CI boundaries."},
  {path:"45-ci-postgresql/fixtures/001-base.sql",title:"CI fixtures",type:"SQL",desc:"Deterministic test database and sample data."},
  {path:"45-ci-postgresql/tests/001-core.sql",title:"Core assertions",type:"SQL",desc:"Automated fixture and query assertions."},
  {path:"45-ci-postgresql/tests/002-types-and-constraints.sql",title:"Constraint tests",type:"SQL",desc:"Verify primary, unique and check constraints."},
  {path:"45-ci-postgresql/tests/003-explain.sql",title:"EXPLAIN CI test",type:"SQL",desc:"Capture and inspect query plans."}
 ]},
 {id:"46",title:"Database Client Integration",desc:"Connect real applications safely to PostgreSQL.",topics:[
  {path:"46-database-client-integration/README.md",title:"Client integration",type:"Theory",desc:"JDBC, psycopg, node-postgres, pooling and retries."}
 ]},
 {id:"47",title:"Advanced Concurrency",desc:"Master MVCC, isolation, locks and retry semantics.",topics:[
  {path:"47-advanced-concurrency/README.md",title:"Concurrency guide",type:"Theory",desc:"Isolation levels, deadlocks, serialization and lock patterns."}
 ]},
 {id:"48",title:"Data Loading & Export",desc:"Build reliable high-volume data movement workflows.",topics:[
  {path:"48-data-loading-and-export/README.md",title:"Data loading guide",type:"Theory",desc:"COPY, staging, validation, batching and exports."}
 ]},
 {id:"49",title:"Recovery & Migration Drills",desc:"Practice backup, restore and safe schema evolution.",topics:[
  {path:"49-recovery-and-migration-drills/README.md",title:"Recovery & migration drills",type:"Practice",desc:"Backup, restore, PITR concepts and migration rehearsal."}
 ]},
 {id:"50",title:"Logical Replication",desc:"Build and operate publisher/subscriber PostgreSQL systems.",topics:[
  {path:"50-logical-replication-lab/README.md",title:"Logical replication lab",type:"Practice",desc:"Publication, subscription, slots, lag and conflicts."}
 ]},
 {id:"51",title:"SQL Quality & Linting",desc:"Create consistent, reviewable and safe SQL.",topics:[
  {path:"51-sql-quality-and-linting/README.md",title:"SQL quality gates",type:"Reference",desc:"Formatting, naming, safety, migration and query review."}
 ]},
 {id:"52",title:"Observability & Performance Lab",desc:"Measure PostgreSQL behavior with evidence.",topics:[
  {path:"52-observability-and-performance-lab/README.md",title:"Performance lab",type:"Practice",desc:"Plans, waits, statistics, WAL and reproducible benchmarks."}
 ]},
 {id:"61",title:"PostgreSQL Testing & Server Programming",desc:"Regression, isolation, recovery/replication testing and server-side programming.",topics:[
  {path:"61-postgresql-testing-and-server-programming/README.md",title:"Testing & server programming guide",type:"Reference",desc:"Advanced database testing and server-side extensibility roadmap."},
  {path:"61-postgresql-testing-and-server-programming/01-regression-and-isolation-testing.md",title:"Regression & isolation testing",type:"Reference",desc:"Deterministic regression, concurrency, recovery and replication test strategy."},
  {path:"61-postgresql-testing-and-server-programming/02-server-programming-theory.md",title:"Server programming theory",type:"Reference",desc:"PL/pgSQL, triggers, logical decoding, extensions, archive modules and OAuth validators."},
  {path:"61-postgresql-testing-and-server-programming/03-testing-and-server-programming-scenarios-qa.md",title:"Testing & server programming scenario Q&A",type:"Reference",desc:"50 production and interview scenarios with model answers."}
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

 if(!user)return <main className="shell"><div className="container"><nav className="nav"><div className="brand">SQL<span>Lab</span></div><div className="pill">Open source learning</div></nav><section className="hero"><div className="eyebrow">From zero → production</div><h1>Learn SQL by <span className="green">building</span>.</h1><p className="sub">Every stage, every topic, theory, SQL, exercises, projects and interview material in one visible learning workspace — now through Stage 58.</p></section><div className="card login-card"><h2>Start your learning journey</h2><p className="muted">Enter an email for a browser-local demo login. No API key is required.</p><input className="input" placeholder="you@example.com" value={email} onChange={e=>setEmail(e.target.value)} onKeyDown={e=>{if(e.key==="Enter")login()}}/><button className="btn primary full" onClick={login}>Enter SQL Lab <ChevronRight size={16}/></button>{greeting&&<p className="green">{greeting}</p>}<p className="muted small">Your progress stays in this browser. Real email delivery is optional.</p></div></div></main>;

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
 {selected&&<section className="card material-view"><div className="between"><div><div className="eyebrow">{selected.type}</div><h2>{selected.title}</h2><p className="muted">{selected.desc}</p></div><button className="btn" onClick={()=>setSelected(null)}>Close</button></div><div className="row material-toolbar"><button className="btn primary" onClick={()=>toggle(selected.path)}>{done.includes(selected.path)?"Completed ✓":"Mark completed"}</button><a className="btn" href={repoBase+selected.path} target="_blank" rel="noreferrer">Open on GitHub <ExternalLink size={14}/></a></div><div className="material-content">{loadingMaterial?<p className="muted">Loading real material…</p>:<pre>{material}</pre>}</div></section>}
 </div></main>;
}

 {id:"53",title:"Completeness Audit",desc:"Reproducibility, replication restrictions, version checks and acceptance criteria.",topics:[
  {path:"53-completeness-audit/README.md",title:"Completeness audit",type:"Reference",desc:"Final PostgreSQL engineering coverage and test classification."},
  {path:"53-completeness-audit/01-replication-restrictions.md",title:"Replication restrictions",type:"Reference",desc:"Schema, sequence, migration and monitoring considerations."},
  {path:"53-completeness-audit/02-deterministic-tests.sql",title:"Deterministic tests",type:"SQL",desc:"Stable timezone, ordering and fixture assertions."},
  {path:"53-completeness-audit/03-extension-and-version-check.sql",title:"Version and extension audit",type:"SQL",desc:"Inspect PostgreSQL version and installed extensions."},
  {path:"53-completeness-audit/04-acceptance-criteria.md",title:"Acceptance criteria",type:"Reference",desc:"Definition of done for the curriculum."}
 ]},
 {id:"54",title:"Multi-Session & Cluster Labs",desc:"Concurrency, logical replication and backup/restore harnesses.",topics:[
  {path:"54-multi-session-and-cluster-labs/README.md",title:"Lab architecture",type:"Reference",desc:"Environment and safety model."},
  {path:"54-multi-session-and-cluster-labs/01-concurrency.sql",title:"Concurrency harness",type:"SQL",desc:"Two-session locking and queue patterns."},
  {path:"54-multi-session-and-cluster-labs/02-logical-replication-checklist.md",title:"Logical replication harness",type:"Reference",desc:"Publisher/subscriber execution checklist."},
  {path:"54-multi-session-and-cluster-labs/03-backup-restore-checklist.md",title:"Backup/restore harness",type:"Reference",desc:"Disposable restore verification workflow."},
  {path:"54-multi-session-and-cluster-labs/docker-compose.yml",title:"PostgreSQL 18.6 lab container",type:"Config",desc:"Disposable PostgreSQL lab environment."}
 ]},
 {id:"55",title:"Production Failure & Chaos Labs",desc:"Safe, repeatable drills for connection, locking, WAL, replication, recovery and incident response.",topics:[
  {path:"55-production-failure-and-chaos-labs/README.md",title:"Failure & chaos lab guide",type:"Reference",desc:"Safe production-failure drills and evidence requirements."},
  {path:"55-production-failure-and-chaos-labs/01-failure-matrix.md",title:"Failure matrix",type:"Reference",desc:"Symptoms, evidence, safe mitigation and permanent improvements."},
  {path:"55-production-failure-and-chaos-labs/02-connection-and-transaction-failure.sql",title:"Connection & transaction evidence",type:"SQL",desc:"Inspect sessions, transaction age and connection pressure."},
  {path:"55-production-failure-and-chaos-labs/03-lock-and-deadlock-analysis.sql",title:"Lock & deadlock analysis",type:"SQL",desc:"Identify blockers and waiting sessions without terminating them."},
  {path:"55-production-failure-and-chaos-labs/04-replication-and-recovery-evidence.sql",title:"Replication & recovery evidence",type:"SQL",desc:"Inspect recovery role, WAL, replicas and replication slots."},
  {path:"55-production-failure-and-chaos-labs/05-incident-and-rca-template.md",title:"Incident & RCA template",type:"Reference",desc:"Capture timeline, root cause, recovery and prevention."}
 ]},
 {id:"56",title:"Physical Replication & Major Upgrade",desc:"Primary/standby, failover, lag and PostgreSQL major-upgrade rehearsal.",topics:[
  {path:"56-physical-replication-and-upgrade-lab/README.md",title:"Lab architecture",type:"Reference",desc:"Physical replication and upgrade lab."},
  {path:"56-physical-replication-and-upgrade-lab/01-primary-standby-checklist.md",title:"Primary/standby checklist",type:"Reference",desc:"Replication, replay, failover and RPO/RTO drill."},
  {path:"56-physical-replication-and-upgrade-lab/02-major-upgrade-checklist.md",title:"Major upgrade checklist",type:"Reference",desc:"pg_upgrade, dump/restore and logical replication migration rehearsal."},
  {path:"56-physical-replication-and-upgrade-lab/03-upgrade-evidence.sql",title:"Upgrade evidence",type:"SQL",desc:"Capture version, extensions and database-size evidence."}
 ]},
 {id:"57",title:"Runnable Client Integration Labs",desc:"Python, Java JDBC and Node.js PostgreSQL client examples with safe transaction patterns.",topics:[
  {path:"57-client-integration-runnable-labs/README.md",title:"Client lab",type:"Reference",desc:"Runnable client integration architecture."},
  {path:"57-client-integration-runnable-labs/python/client_example.py",title:"Python / psycopg",type:"Code",desc:"Parameterized queries and transaction handling."},
  {path:"57-client-integration-runnable-labs/java/ClientExample.java",title:"Java JDBC",type:"Code",desc:"Prepared statements and explicit commit."},
  {path:"57-client-integration-runnable-labs/node/client_example.mjs",title:"Node.js pg",type:"Code",desc:"Parameterized queries and rollback handling."},
  {path:"57-client-integration-runnable-labs/01-security-checklist.md",title:"Client security checklist",type:"Reference",desc:"Secrets, timeouts, retries and parameter binding."}
 ]},
 {id:"58",title:"PostgreSQL 18 Operational Tools",desc:"Backup verification, integrity checks, benchmarking, client tooling and logical-upgrade prerequisites.",topics:[
 {path:"58-postgresql-18-operational-tools/04-pg-stat-io-and-observability.sql",title:"pg_stat_io observability",type:"SQL",desc:"Inspect PostgreSQL I/O statistics and correlate them with performance evidence."},
  {path:"58-postgresql-18-operational-tools/README.md",title:"Operational tools",type:"Reference",desc:"PostgreSQL 18 tools and specialized operational coverage."},
  {path:"58-postgresql-18-operational-tools/01-client-and-tooling-checklist.md",title:"Client and tooling checklist",type:"Reference",desc:"pgbench, libpq pipeline, backup verification and integrity tooling."},
  {path:"58-postgresql-18-operational-tools/02-logical-upgrade-checklist.md",title:"Logical upgrade checklist",type:"Reference",desc:"Publisher/subscriber upgrade prerequisites."},
  {path:"58-postgresql-18-operational-tools/03-performance-evidence.sql",title:"Performance evidence",type:"SQL",desc:"Capture PostgreSQL settings and benchmark evidence metadata."}
 ]},
 {id:"59",title:"SQL Error Diagnostics",desc:"Structured SQLSTATE, PL/pgSQL exception diagnostics and safe retry classification.",topics:[
  {path:"59-sql-error-diagnostics/README.md",title:"Error diagnostics guide",type:"Reference",desc:"SQLSTATE, exception context and retryability."},
  {path:"59-sql-error-diagnostics/01-exception-diagnostics.sql",title:"GET STACKED DIAGNOSTICS",type:"SQL",desc:"Capture structured PL/pgSQL exception details."},
  {path:"59-sql-error-diagnostics/02-retryability-matrix.md",title:"Retryability matrix",type:"Reference",desc:"Distinguish transient and non-transient database failures."}
 ]},
 {id:"60",title:"PostGIS & Geospatial SQL",desc:"Optional spatial SQL track covering geometry, geography, SRIDs and spatial indexes.",topics:[
  {path:"60-postgis-geospatial/README.md",title:"PostGIS guide",type:"Reference",desc:"Spatial data concepts, SRIDs, distance and production concerns."},
  {path:"60-postgis-geospatial/01-spatial-basics.sql",title:"Spatial basics",type:"SQL",desc:"Create points and calculate geography distance."},
  {path:"60-postgis-geospatial/02-spatial-index-and-quality.md",title:"Spatial index & data quality",type:"Reference",desc:"GiST indexing, EXPLAIN and geometry validation."}
 ]},