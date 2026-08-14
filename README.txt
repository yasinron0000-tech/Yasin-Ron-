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
