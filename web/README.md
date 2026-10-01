# SQL Learning Hub UI

A local-first learner portal for the SQL From Zero to Advanced repository.

## What works

- local demo login
- local welcome greeting
- optional real welcome email delivery through Resend
- curriculum search
- **Open** lesson controls
- direct **Read theory** links
- direct **Open SQL material** links
- progress tracking in browser localStorage
- responsive dark UI
- no API keys
- no paid services
- no external authentication
- no external email provider is required; real email is optional

## How lesson navigation works

```text
Choose lesson
   ↓
Open
   ↓
Read theory
   ↓
Open SQL material
   ↓
Run it in PostgreSQL
   ↓
Practice
   ↓
Mark done
```

The material buttons open the corresponding files in the GitHub repository, so learners can immediately see the actual theory or SQL instead of an empty screen.

## Run locally

Requirements:
- Node.js
- npm

```bash
cd web
npm install
npm run dev
```

Open:

```text
http://localhost:3000
```

## Important

The login is intentionally a browser-local learning/demo login. It is not production authentication.

Progress is stored only in the current browser using localStorage.

The welcome endpoint supports local greeting mode by default. To deliver a real email, configure `RESEND_API_KEY` and `WELCOME_EMAIL_FROM` as documented in `EMAIL_SETUP.md`.

## Email setup

See [`EMAIL_SETUP.md`](EMAIL_SETUP.md) for the optional real-email configuration. A real inbox delivery requires server-side email-provider credentials; the learning UI itself does not.

## Troubleshooting

If an old UI is still displayed after pulling the latest repository changes:

```bash
rm -rf .next
npm install
npm run dev
```

On Windows PowerShell, remove the build cache with:

```powershell
Remove-Item -Recurse -Force .next
npm install
npm run dev
```

Then refresh the browser.

## Repository

https://github.com/Narsing-s/sql-from-zero-to-advanced
