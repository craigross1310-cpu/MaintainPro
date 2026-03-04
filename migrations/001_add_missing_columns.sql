-- =============================================================================
-- Cradero Migration 001: Add missing columns to match frontend data model
-- =============================================================================
-- Run this in Supabase SQL Editor before deploying the updated frontend.
-- All new columns have defaults so existing rows are unaffected.
-- =============================================================================

-- ─────────────────────────────────────────────────────────────────────────────
-- WORK ORDERS
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS wo_number text;
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS equipment_name text DEFAULT '';
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS created_by text DEFAULT '';
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS start_time timestamptz;
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS finish_time timestamptz;
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS total_job_time text DEFAULT '';
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS machine_downtime text DEFAULT '';
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS has_photos boolean DEFAULT false;
ALTER TABLE work_orders ADD COLUMN IF NOT EXISTS comments jsonb DEFAULT '[]'::jsonb;

-- Auto-generate wo_number for new rows
CREATE OR REPLACE FUNCTION generate_wo_number()
RETURNS trigger AS $$
BEGIN
    IF NEW.wo_number IS NULL THEN
        NEW.wo_number := 'WO-' || to_char(now(), 'YYYY') || '-' || lpad(NEW.id::text, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_wo_number ON work_orders;
CREATE TRIGGER set_wo_number
    BEFORE INSERT ON work_orders
    FOR EACH ROW EXECUTE FUNCTION generate_wo_number();

-- ─────────────────────────────────────────────────────────────────────────────
-- EQUIPMENT
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE equipment ADD COLUMN IF NOT EXISTS equipment_code text DEFAULT '';
ALTER TABLE equipment ADD COLUMN IF NOT EXISTS criticality text DEFAULT 'B';
ALTER TABLE equipment ADD COLUMN IF NOT EXISTS warranty_expiry date;
ALTER TABLE equipment ADD COLUMN IF NOT EXISTS warranty_provider text DEFAULT '';
ALTER TABLE equipment ADD COLUMN IF NOT EXISTS warranty_notes text DEFAULT '';

-- ─────────────────────────────────────────────────────────────────────────────
-- PARTS INVENTORY
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE parts_inventory ADD COLUMN IF NOT EXISTS shelf text DEFAULT '';
ALTER TABLE parts_inventory ADD COLUMN IF NOT EXISTS bin text DEFAULT '';
ALTER TABLE parts_inventory ADD COLUMN IF NOT EXISTS monthly_usage integer DEFAULT 0;
ALTER TABLE parts_inventory ADD COLUMN IF NOT EXISTS compatible_equipment jsonb DEFAULT '[]'::jsonb;
ALTER TABLE parts_inventory ADD COLUMN IF NOT EXISTS suppliers jsonb DEFAULT '[]'::jsonb;

-- ─────────────────────────────────────────────────────────────────────────────
-- PURCHASE ORDERS
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE purchase_orders ADD COLUMN IF NOT EXISTS title text DEFAULT '';
ALTER TABLE purchase_orders ADD COLUMN IF NOT EXISTS priority text DEFAULT 'medium';
ALTER TABLE purchase_orders ADD COLUMN IF NOT EXISTS tracking_number text;
ALTER TABLE purchase_orders ADD COLUMN IF NOT EXISTS budget_code text DEFAULT '';

-- ─────────────────────────────────────────────────────────────────────────────
-- PERMITS
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE permits ADD COLUMN IF NOT EXISTS engineer text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS fire_watch text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS start_time_of_day text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS end_time_of_day text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS workers integer DEFAULT 0;
ALTER TABLE permits ADD COLUMN IF NOT EXISTS phone text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS insurance text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS closed_date timestamptz;
ALTER TABLE permits ADD COLUMN IF NOT EXISTS closed_by text DEFAULT '';
ALTER TABLE permits ADD COLUMN IF NOT EXISTS scope text DEFAULT '';

-- ─────────────────────────────────────────────────────────────────────────────
-- PM TASKS — add missing columns
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE pm_tasks ADD COLUMN IF NOT EXISTS duration text DEFAULT '';
ALTER TABLE pm_tasks ADD COLUMN IF NOT EXISTS due_status text DEFAULT 'upcoming';

-- ─────────────────────────────────────────────────────────────────────────────
-- BREAKDOWNS — add missing columns
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE breakdowns ADD COLUMN IF NOT EXISTS equipment_name text DEFAULT '';

-- ─────────────────────────────────────────────────────────────────────────────
-- WORK REQUESTS (new table — does not exist yet)
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS work_requests (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    equipment text NOT NULL DEFAULT '',
    description text NOT NULL DEFAULT '',
    urgency text NOT NULL DEFAULT 'medium',
    submitter text NOT NULL DEFAULT '',
    status text NOT NULL DEFAULT 'pending',
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

-- Enable RLS on work_requests
ALTER TABLE work_requests ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read/write work requests
CREATE POLICY "Authenticated users can read work_requests"
    ON work_requests FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Authenticated users can insert work_requests"
    ON work_requests FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Authenticated users can update work_requests"
    ON work_requests FOR UPDATE
    TO authenticated
    USING (true);

-- Add updated_at trigger
CREATE TRIGGER set_updated_at
    BEFORE UPDATE ON work_requests
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ─────────────────────────────────────────────────────────────────────────────
-- AUDIT LOG (for Phase 5, Step 14 — create now so it's ready)
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS audit_log (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id uuid REFERENCES auth.users(id),
    action text NOT NULL,
    entity_type text NOT NULL,
    entity_id text NOT NULL,
    details jsonb DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE audit_log ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can insert audit_log"
    ON audit_log FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Admins can read audit_log"
    ON audit_log FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );
