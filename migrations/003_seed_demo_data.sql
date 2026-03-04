-- ============================================================================
-- Cradero — Demo Seed Data
-- Run this in Supabase Dashboard > SQL Editor
-- ============================================================================

-- Get the first admin user's ID for assigning work
DO $$
DECLARE
  admin_id uuid;
  eq1 uuid; eq2 uuid; eq3 uuid; eq4 uuid; eq5 uuid;
  eq6 uuid; eq7 uuid; eq8 uuid; eq9 uuid; eq10 uuid;
  wo1 uuid; wo2 uuid; wo3 uuid; wo4 uuid; wo5 uuid;
  wo6 uuid; wo7 uuid; wo8 uuid;
  p1 uuid; p2 uuid; p3 uuid; p4 uuid; p5 uuid;
  pm1 uuid; pm2 uuid; pm3 uuid; pm4 uuid; pm5 uuid; pm6 uuid; pm7 uuid; pm8 uuid;
  po1 uuid; po2 uuid; po3 uuid; po4 uuid;
BEGIN
  -- Get admin user
  SELECT id INTO admin_id FROM profiles WHERE role = 'admin' LIMIT 1;
  IF admin_id IS NULL THEN
    RAISE EXCEPTION 'No admin user found. Set your profile role to admin first.';
  END IF;

  -- ========================================================================
  -- EQUIPMENT (10 items)
  -- ========================================================================
  INSERT INTO equipment (id, name, equipment_code, equipment_type, location, serial_number, manufacturer, model, install_date, status, criticality, notes, created_by)
  VALUES
    (gen_random_uuid(), 'Boiler #1 — Main Steam', 'BLR-001', 'Boiler', 'Boiler House', 'BLR-2019-4421', 'Cleaver-Brooks', 'CBLE-700', '2019-03-15', 'operational', 'A', 'Main steam boiler — 700 HP, natural gas fired. Annual inspection due March.', admin_id),
    (gen_random_uuid(), 'Boiler #2 — Backup', 'BLR-002', 'Boiler', 'Boiler House', 'BLR-2019-4422', 'Cleaver-Brooks', 'CBLE-500', '2019-03-15', 'operational', 'B', 'Backup boiler — 500 HP. Used during peak demand or BLR-001 downtime.', admin_id),
    (gen_random_uuid(), 'Chiller — Primary', 'CHL-001', 'HVAC', 'Mechanical Room 1', 'YK-2021-88190', 'York', 'YK-450T', '2021-06-01', 'operational', 'A', 'Primary chiller for building cooling. 450-ton capacity.', admin_id),
    (gen_random_uuid(), 'AHU-1 — Main Office', 'AHU-001', 'HVAC', 'Rooftop', 'TR-2020-55612', 'Trane', 'IntelliPak', '2020-01-10', 'operational', 'B', 'Serves main office area, floors 1–3. Belt-driven supply fan.', admin_id),
    (gen_random_uuid(), 'AHU-2 — Production Floor', 'AHU-002', 'HVAC', 'Rooftop', 'TR-2020-55613', 'Trane', 'IntelliPak', '2020-01-10', 'maintenance', 'A', 'Serves production floor. VFD on supply fan. Currently undergoing filter replacement.', admin_id),
    (gen_random_uuid(), 'Cooling Tower #1', 'CT-001', 'HVAC', 'Rooftop', 'BAC-2021-33100', 'BAC', 'Series 3000', '2021-06-01', 'operational', 'A', 'Paired with primary chiller. Chemical treatment by Nalco.', admin_id),
    (gen_random_uuid(), 'Emergency Generator', 'GEN-001', 'Electrical', 'Generator Yard', 'CAT-2018-76200', 'Caterpillar', 'C15 — 500kW', '2018-09-20', 'operational', 'A', 'Diesel backup generator. Weekly test runs every Monday 07:00.', admin_id),
    (gen_random_uuid(), 'Fire Pump — Electric', 'FP-001', 'Fire Protection', 'Pump Room B2', 'AC-2019-11050', 'AC Fire Pump', 'A-10-8-13F', '2019-05-01', 'operational', 'A', 'Electric fire pump, 1000 GPM. Annual flow test due May.', admin_id),
    (gen_random_uuid(), 'Passenger Elevator #1', 'ELV-001', 'Vertical Transport', 'Lobby', 'OTIS-2017-90443', 'Otis', 'Gen2 MRL', '2017-11-15', 'operational', 'B', 'Main lobby elevator, floors B1 to 5. Under Otis service contract.', admin_id),
    (gen_random_uuid(), 'Compressor — Plant Air', 'CMP-001', 'Compressed Air', 'Mechanical Room 2', 'AS-2020-22780', 'Atlas Copco', 'GA37 VSD', '2020-04-01', 'operational', 'B', 'Variable speed 50 HP rotary screw compressor. Serves production floor air tools.', admin_id)
  RETURNING id INTO eq1;

  -- Re-fetch equipment IDs for referencing
  SELECT id INTO eq1 FROM equipment WHERE equipment_code = 'BLR-001';
  SELECT id INTO eq2 FROM equipment WHERE equipment_code = 'BLR-002';
  SELECT id INTO eq3 FROM equipment WHERE equipment_code = 'CHL-001';
  SELECT id INTO eq4 FROM equipment WHERE equipment_code = 'AHU-001';
  SELECT id INTO eq5 FROM equipment WHERE equipment_code = 'AHU-002';
  SELECT id INTO eq6 FROM equipment WHERE equipment_code = 'CT-001';
  SELECT id INTO eq7 FROM equipment WHERE equipment_code = 'GEN-001';
  SELECT id INTO eq8 FROM equipment WHERE equipment_code = 'FP-001';
  SELECT id INTO eq9 FROM equipment WHERE equipment_code = 'ELV-001';
  SELECT id INTO eq10 FROM equipment WHERE equipment_code = 'CMP-001';

  -- ========================================================================
  -- WORK ORDERS (8 items)
  -- ========================================================================
  INSERT INTO work_orders (id, title, description, equipment_id, equipment_name, priority, status, assigned_to, created_by, due_date, estimated_hours, wo_number, comments)
  VALUES
    (gen_random_uuid(), 'AHU-2 Filter Replacement', 'Replace all supply and return air filters on AHU-2. Production floor reporting poor air quality and increased dust.', eq5, 'AHU-2 — Production Floor', 'high', 'in_progress', admin_id, 'Craig Ross', CURRENT_DATE + interval '2 days', 4.0, 'WO-2026-001', '[]'::jsonb),
    (gen_random_uuid(), 'Boiler #1 Annual Inspection Prep', 'Prepare boiler for annual insurance inspection. Drain, clean fireside, inspect tubes, test safety valves.', eq1, 'Boiler #1 — Main Steam', 'critical', 'open', admin_id, 'Craig Ross', CURRENT_DATE + interval '14 days', 16.0, 'WO-2026-002', '[]'::jsonb),
    (gen_random_uuid(), 'Generator Weekly Test — Failed Start', 'Weekly test run failed to start on first attempt. Investigate fuel system and battery condition.', eq7, 'Emergency Generator', 'high', 'open', admin_id, 'Craig Ross', CURRENT_DATE + interval '1 day', 3.0, 'WO-2026-003', '[]'::jsonb),
    (gen_random_uuid(), 'Chiller Condenser Tube Cleaning', 'Annual condenser tube cleaning. Water treatment report shows increased fouling factor.', eq3, 'Chiller — Primary', 'medium', 'open', admin_id, 'Craig Ross', CURRENT_DATE + interval '21 days', 8.0, 'WO-2026-004', '[]'::jsonb),
    (gen_random_uuid(), 'Cooling Tower Basin Cleaning', 'Drain and clean cooling tower basin. Remove sediment and inspect fill media for damage.', eq6, 'Cooling Tower #1', 'medium', 'open', admin_id, 'Craig Ross', CURRENT_DATE + interval '28 days', 6.0, 'WO-2026-005', '[]'::jsonb),
    (gen_random_uuid(), 'Compressor Oil Change', 'Scheduled oil change on plant air compressor. Replace oil filter and separator element.', eq10, 'Compressor — Plant Air', 'low', 'completed', admin_id, 'Craig Ross', CURRENT_DATE - interval '3 days', 2.0, 'WO-2026-006', '[]'::jsonb),
    (gen_random_uuid(), 'Elevator Annual Safety Test', 'Coordinate with Otis for annual safety test and certificate renewal. Required by insurance.', eq9, 'Passenger Elevator #1', 'medium', 'open', admin_id, 'Craig Ross', CURRENT_DATE + interval '30 days', 4.0, 'WO-2026-007', '[]'::jsonb),
    (gen_random_uuid(), 'Fire Pump Flow Test', 'Annual fire pump flow test per NFPA 25. Coordinate with fire protection contractor.', eq8, 'Fire Pump — Electric', 'high', 'open', admin_id, 'Craig Ross', CURRENT_DATE + interval '60 days', 4.0, 'WO-2026-008', '[]'::jsonb);

  -- ========================================================================
  -- PARTS INVENTORY (15 items)
  -- ========================================================================
  INSERT INTO parts_inventory (part_name, part_number, description, quantity_in_stock, minimum_stock, unit_cost, location, shelf, bin, monthly_usage, compatible_equipment, suppliers)
  VALUES
    ('AHU Filter 20x20x2 MERV-13', 'FLT-20202-M13', 'Pleated air filter, 20x20x2 inch, MERV-13 rating', 48, 24, 12.50, 'Storeroom A', 'S1', 'B3', 24, '["AHU-001", "AHU-002"]'::jsonb, '[{"name": "Grainger", "partNo": "2DFH7"}]'::jsonb),
    ('AHU Filter 24x24x2 MERV-13', 'FLT-24242-M13', 'Pleated air filter, 24x24x2 inch, MERV-13 rating', 36, 12, 14.75, 'Storeroom A', 'S1', 'B4', 12, '["AHU-001", "AHU-002"]'::jsonb, '[{"name": "Grainger", "partNo": "2DFH9"}]'::jsonb),
    ('V-Belt B68', 'BLT-B68', 'V-belt, B section, 68 inch. AHU supply fan drive belt.', 6, 4, 18.90, 'Storeroom A', 'S2', 'B1', 2, '["AHU-001", "AHU-002"]'::jsonb, '[{"name": "Motion Industries", "partNo": "B68"}]'::jsonb),
    ('Bearing 6205-2RS', 'BRG-6205-2RS', 'Deep groove ball bearing, 25mm bore, sealed both sides', 8, 4, 9.50, 'Storeroom A', 'S3', 'B2', 1, '["AHU-001", "AHU-002", "CMP-001"]'::jsonb, '[{"name": "Applied Industrial", "partNo": "6205-2RS"}]'::jsonb),
    ('Compressor Oil — Roto-Xtend', 'OIL-RX-5L', 'Atlas Copco Roto-Xtend Duty Fluid, 5 liter', 3, 2, 89.00, 'Storeroom B', 'S1', 'B1', 1, '["CMP-001"]'::jsonb, '[{"name": "Atlas Copco Direct", "partNo": "2901170100"}]'::jsonb),
    ('Oil Separator Element', 'SEP-GA37', 'Oil separator element for GA37 compressor', 2, 1, 245.00, 'Storeroom B', 'S1', 'B2', 0, '["CMP-001"]'::jsonb, '[{"name": "Atlas Copco Direct", "partNo": "1613984000"}]'::jsonb),
    ('Boiler Gauge Glass', 'GG-BLR-12', 'Sight glass for boiler water level, 12 inch', 4, 2, 35.00, 'Storeroom B', 'S2', 'B1', 0, '["BLR-001", "BLR-002"]'::jsonb, '[{"name": "W.W. Grainger", "partNo": "5RZ23"}]'::jsonb),
    ('Safety Relief Valve 150PSI', 'SRV-150', 'ASME safety relief valve, 150 PSI set pressure, 1 inch', 2, 1, 185.00, 'Storeroom B', 'S2', 'B2', 0, '["BLR-001", "BLR-002"]'::jsonb, '[{"name": "Kunkle Valve", "partNo": "6010JHM01"}]'::jsonb),
    ('Cooling Tower Fill Media', 'CT-FILL-24', 'Cross-flow fill media sheet, 24x24 inch', 10, 5, 42.00, 'Warehouse', 'R1', 'A1', 0, '["CT-001"]'::jsonb, '[{"name": "Brentwood Industries", "partNo": "CF-1900"}]'::jsonb),
    ('Chemical Treatment — Nalco 3D TRASAR', 'CHEM-3DT-25', 'Cooling water treatment chemical, 25 gallon drum', 2, 1, 320.00, 'Chemical Store', 'C1', 'A1', 1, '["CT-001"]'::jsonb, '[{"name": "Nalco Water", "partNo": "3DT-4420"}]'::jsonb),
    ('Generator Fuel Filter', 'FF-CAT-C15', 'Primary fuel filter for CAT C15 diesel generator', 4, 2, 28.50, 'Storeroom B', 'S3', 'B1', 0, '["GEN-001"]'::jsonb, '[{"name": "Caterpillar", "partNo": "1R-0751"}]'::jsonb),
    ('Generator Battery 12V', 'BAT-8D-12V', 'Heavy duty 8D battery, 12V, 1400 CCA', 2, 1, 275.00, 'Storeroom B', 'S3', 'B3', 0, '["GEN-001"]'::jsonb, '[{"name": "Interstate Batteries", "partNo": "M8D-XHD"}]'::jsonb),
    ('Refrigerant R-134a (30 lb)', 'REF-134A-30', 'R-134a refrigerant, 30 lb cylinder', 3, 2, 165.00, 'Chemical Store', 'C2', 'A1', 0, '["CHL-001"]'::jsonb, '[{"name": "Chemours", "partNo": "?"}, {"name": "Johnstone Supply", "partNo": "R134A-30"}]'::jsonb),
    ('Contactor 3-Pole 40A', 'CTR-3P-40A', 'Definite purpose contactor, 3-pole, 40 amp, 24V coil', 3, 2, 32.00, 'Storeroom A', 'S4', 'B1', 0, '["AHU-001", "AHU-002", "CHL-001"]'::jsonb, '[{"name": "Grainger", "partNo": "6GNR8"}]'::jsonb),
    ('Pressure Gauge 0-300 PSI', 'PG-300-4', '4 inch dial pressure gauge, 0–300 PSI, 1/4 NPT bottom mount', 5, 3, 22.00, 'Storeroom A', 'S4', 'B3', 1, '["BLR-001", "BLR-002", "FP-001"]'::jsonb, '[{"name": "Ashcroft", "partNo": "25-1009-AW-02L"}]'::jsonb);

  -- ========================================================================
  -- PM TASKS (8 items)
  -- ========================================================================
  INSERT INTO pm_tasks (id, title, description, equipment_id, frequency, assigned_to, next_due_date, estimated_hours, is_active, created_by, duration, due_status)
  VALUES
    (gen_random_uuid(), 'AHU-1 & AHU-2 Filter Change', 'Replace all supply and return filters. Check belt tension. Inspect coils for fouling.', eq4, 'monthly', admin_id, CURRENT_DATE + interval '12 days', 3.0, true, admin_id, '3 hours', 'upcoming'),
    (gen_random_uuid(), 'Boiler #1 Blowdown & Water Test', 'Perform bottom blowdown. Test boiler water chemistry (pH, TDS, hardness). Log results.', eq1, 'weekly', admin_id, CURRENT_DATE + interval '3 days', 1.0, true, admin_id, '1 hour', 'upcoming'),
    (gen_random_uuid(), 'Generator Weekly Test Run', 'Start generator under no-load. Run for 30 minutes. Check oil pressure, coolant temp, battery voltage. Log hours.', eq7, 'weekly', admin_id, CURRENT_DATE + interval '4 days', 1.0, true, admin_id, '1 hour', 'upcoming'),
    (gen_random_uuid(), 'Chiller Log Review', 'Review chiller operating logs. Check suction/discharge pressures, oil level, approach temps. Flag anomalies.', eq3, 'weekly', admin_id, CURRENT_DATE + interval '5 days', 0.5, true, admin_id, '30 min', 'upcoming'),
    (gen_random_uuid(), 'Cooling Tower Chemical Treatment Check', 'Check Nalco 3D TRASAR readings. Verify chemical feed rates. Inspect basin for algae. Bleed conductivity.', eq6, 'weekly', admin_id, CURRENT_DATE + interval '5 days', 1.0, true, admin_id, '1 hour', 'upcoming'),
    (gen_random_uuid(), 'Fire Pump Churn Test', 'Run fire pump for 10 minutes under churn (no-flow) conditions. Record suction/discharge pressure and RPM.', eq8, 'weekly', admin_id, CURRENT_DATE + interval '6 days', 0.5, true, admin_id, '30 min', 'upcoming'),
    (gen_random_uuid(), 'Compressor Air Dryer Check', 'Check desiccant dryer operation. Verify dewpoint readings. Drain auto-drain traps. Check pressure drop across filters.', eq10, 'monthly', admin_id, CURRENT_DATE + interval '18 days', 1.0, true, admin_id, '1 hour', 'upcoming'),
    (gen_random_uuid(), 'Emergency Lighting & Exit Sign Test', 'Monthly 30-second test of all emergency lights and exit signs. Log any failures for repair.', NULL, 'monthly', admin_id, CURRENT_DATE + interval '20 days', 2.0, true, admin_id, '2 hours', 'upcoming');

  -- ========================================================================
  -- PURCHASE ORDERS (4 items)
  -- ========================================================================
  INSERT INTO purchase_orders (id, po_number, supplier, status, requested_by, total_cost, title, priority, notes, order_date, expected_delivery, budget_code)
  VALUES
    (gen_random_uuid(), 'PO-2026-001', 'Grainger', 'ordered', admin_id, 594.00, 'AHU Filters — Q2 Stock', 'high', 'Quarterly filter order for AHU-1 and AHU-2.', CURRENT_DATE - interval '5 days', CURRENT_DATE + interval '5 days', 'MNT-HVAC'),
    (gen_random_uuid(), 'PO-2026-002', 'Atlas Copco Direct', 'approved', admin_id, 579.00, 'Compressor Maintenance Kit', 'medium', 'Annual service kit: oil, separator, air filter.', CURRENT_DATE - interval '2 days', CURRENT_DATE + interval '14 days', 'MNT-MECH'),
    (gen_random_uuid(), 'PO-2026-003', 'Caterpillar', 'draft', admin_id, 607.00, 'Generator Service Parts', 'medium', 'Fuel filters, oil filters, coolant test strips for annual service.', NULL, NULL, 'MNT-ELEC'),
    (gen_random_uuid(), 'PO-2026-004', 'Nalco Water', 'received', admin_id, 640.00, 'Cooling Water Treatment Chemicals', 'low', 'Monthly chemical delivery for cooling tower treatment.', CURRENT_DATE - interval '15 days', CURRENT_DATE - interval '5 days', 'MNT-HVAC');

  -- ========================================================================
  -- PERMITS (4 items)
  -- ========================================================================
  INSERT INTO permits (permit_type, title, description, status, requested_by, contractor_name, contractor_company, work_location, equipment_id, valid_from, valid_until, fire_watch_required, engineer, fire_watch, start_time_of_day, end_time_of_day, workers, phone, insurance, scope)
  VALUES
    ('hot_work', 'Boiler Tube Welding', 'Welding repair on boiler #1 economizer tubes. Hot work permit required per facility policy.', 'active', admin_id, NULL, NULL, 'Boiler House', eq1, CURRENT_DATE, CURRENT_DATE + interval '3 days', true, 'Craig Ross', 'Mike Torres', '08:00', '16:00', 2, '', '', 'Weld repair on 3 leaking economizer tubes'),
    ('contractor', 'Otis Elevator Annual Inspection', 'Annual safety inspection and certificate renewal for passenger elevator #1.', 'approved', admin_id, 'James Wright', 'Otis Elevator Co.', 'Lobby — Elevator #1', eq9, CURRENT_DATE + interval '7 days', CURRENT_DATE + interval '8 days', false, 'Craig Ross', '', '09:00', '17:00', 2, '555-0142', 'Policy #ELV-2026-889', 'Full safety inspection per ASME A17.1'),
    ('hot_work', 'Cooling Tower Pipe Repair', 'Brazing repair on condenser water piping near cooling tower. Open flame work above grade.', 'active', admin_id, NULL, NULL, 'Rooftop — Near CT-001', eq6, CURRENT_DATE - interval '1 day', CURRENT_DATE + interval '1 day', true, 'Craig Ross', 'Sarah Kim', '07:00', '15:00', 1, '', '', 'Braze repair on 2-inch condenser water line'),
    ('contractor', 'Fire Pump Test — Annual Flow', 'Annual flow test of electric fire pump per NFPA 25 by certified contractor.', 'pending_approval', admin_id, 'Tom Bradley', 'Allied Fire Protection', 'Pump Room B2', eq8, CURRENT_DATE + interval '30 days', CURRENT_DATE + interval '30 days', false, 'Craig Ross', '', '08:00', '12:00', 3, '555-0198', 'Policy #AFP-2026-112', 'Full flow test, record pressures at rated flow');

  -- ========================================================================
  -- BREAKDOWNS (4 items)
  -- ========================================================================
  INSERT INTO breakdowns (equipment_id, equipment_name, reported_by, title, description, severity, status, downtime_started, downtime_ended, root_cause, resolution)
  VALUES
    (eq5, 'AHU-2 — Production Floor', admin_id, 'AHU-2 Supply Fan Tripped on Overload', 'Supply fan motor tripped on thermal overload. Production floor lost cooling.', 'high', 'resolved', CURRENT_DATE - interval '10 days', CURRENT_DATE - interval '10 days' + interval '4 hours', 'Dirty filters caused excessive static pressure, overloading the motor.', 'Replaced all filters. Reset thermal overload. Motor tested OK — no damage.'),
    (eq7, 'Emergency Generator', admin_id, 'Generator Failed to Start — Weekly Test', 'Generator cranked but did not fire during weekly test run.', 'critical', 'investigating', CURRENT_DATE - interval '1 day', NULL, NULL, NULL),
    (eq10, 'Compressor — Plant Air', admin_id, 'Low Air Pressure Alarm', 'Plant air pressure dropped below 90 PSI. Production air tools losing power.', 'medium', 'resolved', CURRENT_DATE - interval '21 days', CURRENT_DATE - interval '21 days' + interval '2 hours', 'Inlet filter clogged with dust from nearby construction.', 'Replaced inlet filter. Pressure returned to 110 PSI operating setpoint.'),
    (eq3, 'Chiller — Primary', admin_id, 'Chiller High Head Pressure Alarm', 'Chiller tripped on high head pressure during afternoon peak load.', 'high', 'resolved', CURRENT_DATE - interval '45 days', CURRENT_DATE - interval '45 days' + interval '6 hours', 'Condenser tubes fouled — approach temp was 12°F (spec: 5°F).', 'Emergency condenser tube cleaning performed. Approach temp returned to 4.5°F.');

  -- ========================================================================
  -- CALENDAR EVENTS (6 items)
  -- ========================================================================
  INSERT INTO calendar_events (title, description, event_type, start_time, end_time, all_day, assigned_to, equipment_id, created_by)
  VALUES
    ('Boiler #1 — Annual Insurance Inspection', 'Inspector from Hartford Steam Boiler. Full internal inspection required. Boiler must be cold and drained.', 'inspection', (CURRENT_DATE + interval '14 days')::timestamp + interval '9 hours', (CURRENT_DATE + interval '14 days')::timestamp + interval '16 hours', false, admin_id, eq1, admin_id),
    ('Elevator Safety Test — Otis', 'Annual ASME A17.1 safety test. Elevator will be out of service all day.', 'inspection', (CURRENT_DATE + interval '7 days')::timestamp + interval '9 hours', (CURRENT_DATE + interval '8 days')::timestamp + interval '17 hours', false, admin_id, eq9, admin_id),
    ('Cooling Tower Spring Startup', 'Seasonal startup of cooling tower. Fill basin, start chemical treatment, commission pumps.', 'pm_scheduled', (CURRENT_DATE + interval '21 days')::timestamp + interval '7 hours', (CURRENT_DATE + interval '21 days')::timestamp + interval '15 hours', false, admin_id, eq6, admin_id),
    ('Fire Pump Flow Test', 'Annual NFPA 25 flow test with Allied Fire Protection.', 'inspection', (CURRENT_DATE + interval '30 days')::timestamp + interval '8 hours', (CURRENT_DATE + interval '30 days')::timestamp + interval '12 hours', false, admin_id, eq8, admin_id),
    ('Safety Committee Meeting', 'Monthly safety committee meeting. Review incidents, near-misses, and upcoming hot work.', 'meeting', (CURRENT_DATE + interval '10 days')::timestamp + interval '10 hours', (CURRENT_DATE + interval '10 days')::timestamp + interval '11 hours', false, admin_id, NULL, admin_id),
    ('Planned Shutdown — Mechanical Room 1', 'Full shutdown of Mechanical Room 1 for chiller maintenance and pipe insulation repair.', 'shutdown', (CURRENT_DATE + interval '35 days')::timestamp + interval '6 hours', (CURRENT_DATE + interval '36 days')::timestamp + interval '18 hours', false, admin_id, eq3, admin_id);

  -- ========================================================================
  -- WORK REQUESTS (5 items)
  -- ========================================================================
  INSERT INTO work_requests (equipment, description, urgency, submitter, status)
  VALUES
    ('AHU-1 — Main Office', 'Office on 2nd floor is too warm. Thermostat reads 78°F, setpoint is 72°F.', 'medium', 'Sarah Johnson — Office Manager', 'pending'),
    ('Passenger Elevator #1', 'Elevator making grinding noise when stopping at floor 3. Passengers concerned.', 'high', 'Mike Torres — Security', 'pending'),
    ('Boiler House', 'Small water leak spotted near the condensate return pipe in the boiler room.', 'high', 'Dave Chen — Maintenance Tech', 'approved'),
    ('Compressor — Plant Air', 'Air hose fitting on production line 4 is leaking. Can hear hissing.', 'low', 'Lisa Park — Production Lead', 'pending'),
    ('Main Parking Lot', 'Two light poles in the south parking lot are out. Safety concern for night shift.', 'medium', 'Tom Bradley — Facilities', 'pending');

  RAISE NOTICE 'Demo data inserted successfully!';
END $$;
