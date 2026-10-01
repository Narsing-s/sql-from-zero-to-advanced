# Welcome Email Setup

The learner UI supports **two modes**.

## Mode 1 — Local greeting (no key)

If `RESEND_API_KEY` is not configured:

1. Learner enters an email.
2. The browser calls `/api/welcome-email`.
3. The application displays the welcome greeting.
4. No external email is sent.

This keeps the project usable without paid services or credentials.

## Mode 2 — Real email

If you want the greeting delivered to the learner's inbox, configure a server-side **Resend API key**.

### 1. Create a Resend account

Official documentation:

https://resend.com/docs

### 2. Create an API key

Create a Resend API key and keep it secret.

**Never put the key in client-side code or commit it to GitHub.**

### 3. Configure the deployment

Add these server-side environment variables:

```text
RESEND_API_KEY=re_...
WELCOME_EMAIL_FROM=SQL Lab <onboarding@resend.dev>
```

For production, verify your own sending domain in Resend and change `WELCOME_EMAIL_FROM` to that verified address.

### 4. Local development

Create `web/.env.local`:

```text
RESEND_API_KEY=re_...
WELCOME_EMAIL_FROM=SQL Lab <onboarding@resend.dev>
```

Then restart:

```bash
npm run dev
```

### 5. Deployment

For Vercel, add the variables in the project's environment settings, then redeploy.

For another hosting platform, add the same variables through that platform's server-side environment-variable settings.

### 6. Test

Enter a real email address in SQL Lab and click **Enter SQL Lab**.

You should see:

```text
Welcome email sent successfully to your@email.com.
```

If delivery fails, the UI now reports the provider error instead of silently showing a local greeting.

## Important

A real email cannot be delivered by a browser-only app with **zero credentials**. An email provider needs authenticated server-side access to prevent abuse.

The SQL learning application itself does not require an email key. The key is only needed for the optional real-email feature.

## Security checklist

- [ ] Keep `RESEND_API_KEY` server-side.
- [ ] Do not use `NEXT_PUBLIC_RESEND_API_KEY`.
- [ ] Do not commit `.env.local`.
- [ ] Use a verified sender/domain for production.
- [ ] Rate-limit public signup/email endpoints before production.
- [ ] Do not send passwords or sensitive information in welcome emails.
