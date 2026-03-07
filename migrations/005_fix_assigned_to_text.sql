-- ============================================================
-- Migration 005: Change assigned_to from UUID to TEXT
-- ============================================================
-- The frontend stores engineer names (e.g. "John Smith") in assigned_to,
-- but the schema defines it as UUID REFERENCES profiles(id).
-- This migration changes all assigned_to columns to TEXT so the app
-- can store names directly without UUID lookup.
--
-- Must drop RLS policies that reference assigned_to first, then recreate.
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- STEP 1: Drop RLS policies that reference assigned_to
-- ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Assigned or managers update work orders" ON public.work_orders;
DROP POLICY IF EXISTS "Assigned or managers update PM tasks" ON public.pm_tasks;

-- ────────────────────────────────────────────────────────────
-- STEP 2: Change work_orders columns from UUID to TEXT
-- ────────────────────────────────────────────────────────────
ALTER TABLE public.work_orders DROP CONSTRAINT IF EXISTS work_orders_assigned_to_fkey;
ALTER TABLE public.work_orders ALTER COLUMN assigned_to TYPE TEXT USING assigned_to::TEXT;

ALTER TABLE public.work_orders DROP CONSTRAINT IF EXISTS work_orders_requested_by_fkey;
ALTER TABLE public.work_orders ALTER COLUMN requested_by TYPE TEXT USING requested_by::TEXT;

-- Add columns the frontend uses but may be missing
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS created_by TEXT;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS equipment_name TEXT;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS wo_number TEXT;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS has_photos BOOLEAN DEFAULT false;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS comments JSONB DEFAULT '[]'::jsonb;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS start_time TEXT;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS finish_time TEXT;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS total_job_time TEXT;
ALTER TABLE public.work_orders ADD COLUMN IF NOT EXISTS machine_downtime TEXT;

-- ────────────────────────────────────────────────────────────
-- STEP 3: Change pm_tasks columns from UUID to TEXT
-- ────────────────────────────────────────────────────────────
ALTER TABLE public.pm_tasks DROP CONSTRAINT IF EXISTS pm_tasks_assigned_to_fkey;
ALTER TABLE public.pm_tasks ALTER COLUMN assigned_to TYPE TEXT USING assigned_to::TEXT;

-- Add columns the frontend uses but may be missing
ALTER TABLE public.pm_tasks ADD COLUMN IF NOT EXISTS created_by TEXT;
ALTER TABLE public.pm_tasks ADD COLUMN IF NOT EXISTS duration TEXT;
ALTER TABLE public.pm_tasks ADD COLUMN IF NOT EXISTS due_status TEXT DEFAULT 'upcoming';
ALTER TABLE public.pm_tasks ADD COLUMN IF NOT EXISTS checklist JSONB DEFAULT '[]'::jsonb;

-- ────────────────────────────────────────────────────────────
-- STEP 4: Change calendar_events columns from UUID to TEXT
-- ────────────────────────────────────────────────────────────
ALTER TABLE public.calendar_events DROP CONSTRAINT IF EXISTS calendar_events_assigned_to_fkey;
ALTER TABLE public.calendar_events ALTER COLUMN assigned_to TYPE TEXT USING assigned_to::TEXT;

-- Add columns the frontend uses but may be missing
ALTER TABLE public.calendar_events ADD COLUMN IF NOT EXISTS created_by TEXT;

-- ────────────────────────────────────────────────────────────
-- STEP 5: Recreate the dropped policies (now without UUID comparison)
-- ────────────────────────────────────────────────────────────

-- Managers and admins can update any work order; engineers can update their own
DROP POLICY IF EXISTS "Managers or assigned update work orders" ON public.work_orders;
CREATE POLICY "Managers or assigned update work orders"
  ON public.work_orders FOR UPDATE
  TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin', 'engineer')
  )
  WITH CHECK (
    public.get_my_role() IN ('manager', 'admin', 'engineer')
  );

-- Managers and admins can update any PM task; engineers can update their own
DROP POLICY IF EXISTS "Managers or assigned update PM tasks" ON public.pm_tasks;
CREATE POLICY "Managers or assigned update PM tasks"
  ON public.pm_tasks FOR UPDATE
  TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin', 'engineer')
  )
  WITH CHECK (
    public.get_my_role() IN ('manager', 'admin', 'engineer')
  );

-- ────────────────────────────────────────────────────────────
-- STEP 6: Recreate index for TEXT column
-- ────────────────────────────────────────────────────────────
DROP INDEX IF EXISTS idx_work_orders_assigned;
CREATE INDEX idx_work_orders_assigned ON public.work_orders(assigned_to);
