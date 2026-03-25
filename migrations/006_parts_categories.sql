-- =============================================================================
-- Cradero Migration 006: Dynamic Parts Categories
-- =============================================================================
-- Run this in Supabase SQL Editor.
-- Creates a parts_categories table and adds a category column to parts_inventory.
-- =============================================================================

-- Create parts_categories table
CREATE TABLE IF NOT EXISTS parts_categories (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name text NOT NULL UNIQUE,
    created_at timestamptz DEFAULT now(),
    created_by text DEFAULT ''
);

-- Seed with default categories
INSERT INTO parts_categories (name) VALUES
    ('Bearings'),
    ('Belts & Chains'),
    ('Sensors'),
    ('Electrical Components'),
    ('Hydraulic Parts'),
    ('Consumables')
ON CONFLICT (name) DO NOTHING;

-- Add category column to parts_inventory
ALTER TABLE parts_inventory ADD COLUMN IF NOT EXISTS category text DEFAULT '';

-- Enable RLS on parts_categories
ALTER TABLE parts_categories ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated users to read categories
CREATE POLICY "Authenticated users can read parts_categories"
    ON parts_categories FOR SELECT
    TO authenticated
    USING (true);

-- Allow all authenticated users to insert/update/delete categories
-- (app-level role check enforces manager+ access)
CREATE POLICY "Authenticated users can manage parts_categories"
    ON parts_categories FOR ALL
    TO authenticated
    USING (true)
    WITH CHECK (true);
