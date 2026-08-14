EXCEL MASTER — FINAL TRAINING VERSION

Every formula has Formula Training: what it does, how to use it, syntax, real-world use, common mistakes, practice, sample data, expected result and a quick quiz.

Upload index.html + manifest.json + service-worker.js + icon.svg to the repository root.
Replace the old index.html. Then open the GitHub Pages URL and refresh the page.


V6 AUTH FIX
- Replace the repository root files with this version.
- Run supabase-schema.sql once.
- For an existing user without a profile, run the OPTIONAL REPAIR block.
- Set only the administrator profile role to admin using its auth user UUID.
- Never put an administrator password in GitHub/JavaScript.
- If Login says Invalid email or password, use Forgot password or verify the Supabase Auth user's password/confirmation status.

V8 CLEAN LOGIN-FREE
- Login and Signup are removed from the Agent portal.
- No Supabase authentication is loaded by index.html.
- Agent portal opens directly.
- Practice submissions are saved locally in the browser.
- Admin credentials/passwords are NOT embedded in public GitHub code.
- Publish this version to GitHub Pages and hard-refresh/clear site data once after deployment.


V9: 302 formulas; direct Agent portal at index.html; separate Owner/Admin portal at admin.html; animations added.

FINAL BUILD
- Agent portal is index.html and has NO login/auth dependency.
- Owner portal is admin.html and is the ONLY page requiring Supabase authentication.
- Administrator UUID is fixed to 7487289c-95a8-480d-af95-e2965774f1c4 and profiles.role must be admin.
- Added visible motion/hover/fade animations.
- Formula count badge is calculated from the formula library.
