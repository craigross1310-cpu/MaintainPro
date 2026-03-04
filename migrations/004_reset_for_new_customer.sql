-- ============================================================================
-- Cradero — Reset Database for New Customer
-- Run this in Supabase Dashboard > SQL Editor when onboarding a new customer.
-- WARNING: This deletes ALL data. Only run on a fresh customer project.
-- ============================================================================

-- Delete in order to respect foreign key constraints
DELETE FROM audit_log;
DELETE FROM pm_completions;
DELETE FROM pm_tasks;
DELETE FROM po_line_items;
DELETE FROM purchase_orders;
DELETE FROM permits;
DELETE FROM breakdowns;
DELETE FROM calendar_events;
DELETE FROM work_requests;
DELETE FROM work_orders;
DELETE FROM parts_inventory;
DELETE FROM equipment;
-- Profiles are kept — the customer's admin account stays intact

-- Reset identity sequences so IDs start fresh
ALTER TABLE work_requests ALTER COLUMN id RESTART;
ALTER TABLE audit_log ALTER COLUMN id RESTART;

-- ============================================================================
-- DONE — The database is now a blank canvas.
-- The customer can log in and start adding their own equipment, work orders, etc.
-- ============================================================================
