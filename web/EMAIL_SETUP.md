# Welcome Greeting

The learner UI uses a key-free local greeting flow.

## What happens
1. The browser stores the demo learner locally.
2. The UI calls /api/welcome-email.
3. The local route returns a greeting.
4. No external email provider is contacted.
5. No API key is required.

Example:

Thanks for choosing SQL From Zero to Advanced, Anita! Welcome to your SQL learning journey.

## Important
This is intentionally a learning/demo experience, not production authentication or real email delivery.

There are no email-provider credentials to configure.
