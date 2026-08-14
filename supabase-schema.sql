-- EXCEL MASTER — SECURE SUPABASE SETUP
-- Run this entire script once in Supabase > SQL Editor.
-- IMPORTANT: after you create YOUR account, run the final ADMIN command with your own UUID.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'agent' check (role in ('agent','admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.training_submissions (
  id uuid primary key default gen_random_uuid(),
  formula_name text not null,
  title text not null,
  explanation text not null,
  sample_data text,
  formula_example text not null,
  expected_result text,
  common_mistakes text,
  practice_question text,
  practice_answer text,
  author_id uuid not null references auth.users(id) on delete cascade,
  author_name text,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  review_note text,
  created_at timestamptz not null default now(),
  reviewed_by uuid references auth.users(id),
  reviewed_at timestamptz
);

create or replace function public.handle_new_user()
returns trigger
language plpgsql security definer set search_path = public
as $$
begin
  insert into public.profiles(id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', split_part(coalesce(new.email,''),'@',1)));
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute procedure public.handle_new_user();

create or replace function public.is_admin()
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists(select 1 from public.profiles where id=auth.uid() and role='admin');
$$;

alter table public.profiles enable row level security;
alter table public.training_submissions enable row level security;

drop policy if exists "profile self read" on public.profiles;
drop policy if exists "profiles_self_or_admin" on public.profiles;
create policy "profile self read" on public.profiles
for select to authenticated using (id=auth.uid() or public.is_admin());

-- No INSERT/UPDATE/DELETE policy for agents on profiles: they cannot change roles.
drop policy if exists "training read approved own admin" on public.training_submissions;
create policy "training read approved own admin" on public.training_submissions
for select to authenticated
using (status='approved' or author_id=auth.uid() or public.is_admin());

drop policy if exists "training insert own pending" on public.training_submissions;
create policy "training insert own pending" on public.training_submissions
for insert to authenticated
with check (author_id=auth.uid() and status='pending');

drop policy if exists "training admin update" on public.training_submissions;
create policy "training admin update" on public.training_submissions
for update to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "training admin delete" on public.training_submissions;
create policy "training admin delete" on public.training_submissions
for delete to authenticated using (public.is_admin());

-- OWNER SETUP:
-- 1) Create your own account in the app.
-- 2) In Supabase: Authentication > Users > copy YOUR user's UUID.
-- 3) Run ONLY this command, replacing the UUID:
-- update public.profiles set role='admin' where id='YOUR-USER-UUID';
--
-- Agents remain 'agent' and cannot promote themselves because profiles has no
-- agent INSERT/UPDATE policy. Only the database owner/Supabase SQL editor can
-- change a role to admin.


-- OPTIONAL REPAIR FOR EXISTING ACCOUNTS:
-- Run this once if an existing Auth user has no profile row.
insert into public.profiles (id, full_name, role)
select
  u.id,
  coalesce(u.raw_user_meta_data->>'full_name', split_part(coalesce(u.email,''),'@',1)),
  'agent'
from auth.users u
where not exists (select 1 from public.profiles p where p.id=u.id)
on conflict (id) do nothing;

-- OWNER/ADMIN:
-- Replace the UUID below with YOUR administrator account's auth.users.id.
-- Do not put a password in SQL or JavaScript.
-- update public.profiles set role='admin' where id='YOUR-ADMIN-UUID';
