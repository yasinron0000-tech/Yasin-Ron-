# Excel Master — Yasin Ron Professional Edition

## Agent Portal
- `index.html` opens directly with NO login.
- 300+ Excel formulas.
- Every formula includes: what it does, where it is used, when to use it, how to use it, sample data, expected result, common mistakes and hands-on practice.
- Practice is saved locally in the browser.
- Professional responsive UI with animations and hover effects.

## Owner Admin
- `admin.html` is the separate secure owner area.
- It uses Supabase Auth; the password is never stored in GitHub.
- Administrator UUID: `7487289c-95a8-480d-af95-e2965774f1c4`
- The Admin account's `public.profiles.role` must be `admin`.
- If login fails, use the exact email shown under Supabase > Authentication > Users or use the Reset password button.
- Never put a service_role/secret key in the public site.

## Deployment
Replace the repository root files with this build. Keep `supabase-config.js` with the Publishable key only. If an older cached version appears, clear site data or open the GitHub Pages URL in Incognito once.
