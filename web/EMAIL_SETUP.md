# Welcome Email Setup

The UI calls /api/welcome-email immediately after a learner logs in.

## Local mode
Without environment variables, the route returns a local-demo response and no email is sent.

## Real email
Configure these server-side environment variables:

RESEND_API_KEY=re_...
EMAIL_FROM=SQL Lab <hello@yourdomain.com>

Then run the web app. The API sends a simple welcome message after login.

### Production safety
- Keep the API key server-side.
- Verify the sending domain with your email provider.
- Add rate limiting before public production use.
- Add explicit marketing consent before sending newsletters or promotional email.
- Do not use the demo login as production authentication.
