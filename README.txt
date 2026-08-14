EXCEL MASTER — FINAL LIVE AGENT + OWNER BUILD

OWNER DASHBOARD
- admin.html is the secure Owner/Admin dashboard.
- Shows total agents, agents online now, pending/approved submissions, recent activity and agent directory.
- Shows each online agent's current formula/activity and last seen.
- Training submissions can be approved/rejected/viewed.
- Dashboard auto-refreshes every 15 seconds.

AGENT PORTAL
- index.html is the Agent Portal.
- Existing Supabase Auth agents can sign in.
- After sign-in, the agent appears live in Owner Dashboard.
- Presence heartbeat runs every 20 seconds.
- Formula opens, practice saves, login, search and category activity can appear in Admin.

SUPABASE FIX
- Run the complete supabase-schema.sql once in Supabase SQL Editor.
- It creates/repairs profiles, training_submissions permissions, agent_presence and activity_logs.
- It adds authenticated grants and RLS policies.
- It sets Owner UUID 7487289c-95a8-480d-af95-e2965774f1c4 to admin.

SECURITY
- Keep only the Publishable key in supabase-config.js.
- Never put service_role/Secret key or any password in GitHub.

DEPLOYMENT
- Upload/replace all root files.
- Deploy GitHub Pages.
- Hard refresh once.
