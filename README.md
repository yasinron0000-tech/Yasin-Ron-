# Excel Master — Yasin Ron Professional Edition

## What is fixed in this build

### Owner/Admin Dashboard
- Secure Supabase Owner login on `admin.html`.
- Live agent monitoring: online/offline status, last seen, current formula and current activity.
- Recent agent activity feed.
- Registered agent directory.
- Training submission dashboard with Pending / Approved / Rejected filters.
- Approve / Reject / View submission controls.
- Automatic dashboard refresh every 15 seconds.
- Fixed the `permission denied for table training_submissions` setup by adding the required authenticated grants and admin RLS policies in `supabase-schema.sql`.

### Agent Portal
- `index.html` remains the Agent Portal.
- Agents can sign in with their existing Supabase Auth account.
- Logged-in agents appear live in the Owner Dashboard.
- Presence heartbeat updates every 20 seconds.
- Admin can see formula opened, practice saved, login, search and category activity.
- Agent passwords are never stored in GitHub.
- Guest users can still view the formula library, but they are not identified as live agents until they sign in.

## Deployment

1. Replace the repository root files with this build.
2. Keep `supabase-config.js` containing only the Supabase Project URL and Publishable key.
3. In Supabase, open **SQL Editor** and run the complete `supabase-schema.sql` once.
4. Confirm the Owner UUID `7487289c-95a8-480d-af95-e2965774f1c4` has `role = 'admin'`.
5. Make sure each agent has a Supabase Authentication account and a corresponding `profiles` row.
6. Deploy the files to GitHub Pages.
7. Hard refresh the site once after deployment.

## Important

Do not put a Supabase `service_role` or Secret key in `supabase-config.js`.
The public Publishable key is the correct key for this browser app.

## URLs

- Agent Portal: `index.html`
- Owner Dashboard: `admin.html`

## Agent account access
- Agents create accounts with a Gmail address; no Employee/Agent ID is required.
- Agent signup collects full name, Gmail, password, and password confirmation.
- Email verification is supported when Supabase Email Confirmation is enabled.
- Agents can sign in with Gmail + password.
- Forgot Password sends a secure Supabase reset email.
- Password reset links return to the Agent Portal where the agent can set a new password.
- Admin accounts are blocked from the Agent Portal flow.


## 📱 Install Excel Master on Android
The Agent Portal is PWA-enabled. Publish the `web_source` files to GitHub Pages over HTTPS.
On Android Chrome, use the **📱 Install App** button when it appears, or Chrome → **⋮ → Install app / Add to Home screen**.
The installed app opens the same Agent Portal in standalone mode.
