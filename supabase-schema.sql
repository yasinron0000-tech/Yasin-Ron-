-- Excel Master: Agent Training database
-- Run this in Supabase SQL Editor.

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
  created_at timestamptz not null default now(),
  reviewed_by uuid references auth.users(id),
  reviewed_at timestamptz
);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles(id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', new.email));
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

alter table public.profiles enable row level security;
alter table public.training_submissions enable row level security;

drop policy if exists "profiles_self_or_admin" on public.profiles;
create policy "profiles_self_or_admin" on public.profiles
for select to authenticated
using (id = auth.uid() or public.is_admin());

drop policy if exists "training_read_approved_or_own" on public.training_submissions;
create policy "training_read_approved_or_own" on public.training_submissions
for select to authenticated
using (status = 'approved' or author_id = auth.uid() or public.is_admin());

drop policy if exists "training_insert_pending" on public.training_submissions;
create policy "training_insert_pending" on public.training_submissions
for insert to authenticated
with check (author_id = auth.uid() and status = 'pending');

drop policy if exists "training_admin_update" on public.training_submissions;
create policy "training_admin_update" on public.training_submissions
for update to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "training_admin_delete" on public.training_submissions;
create policy "training_admin_delete" on public.training_submissions
for delete to authenticated
using (public.is_admin());

-- After creating your own account, promote it to admin by running:
-- update public.profiles set role = 'admin' where id = 'YOUR_USER_UUID';
