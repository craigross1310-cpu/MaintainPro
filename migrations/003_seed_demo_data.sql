-- ============================================================================
-- Cradero — Demo Seed Data
-- Run this in Supabase Dashboard > SQL Editor
-- IMPORTANT: Run 004_reset first if you have existing data!
-- ============================================================================

DO $$
DECLARE
  admin_id uuid;
  -- Pre-generated equipment UUIDs
  eq1 uuid := 'a1000000-0000-0000-0000-000000000001';
  eq2 uuid := 'a1000000-0000-0000-0000-000000000002';
  eq3 uuid := 'a1000000-0000-0000-0000-000000000003';
  eq4 uuid := 'a1000000-0000-0000-0000-000000000004';
  eq5 uuid := 'a1000000-0000-0000-0000-000000000005';
  eq6 uuid := 'a1000000-0000-0000-0000-000000000006';
  eq7 uuid := 'a1000000-0000-0000-0000-000000000007';
  eq8 uuid := 'a1000000-0000-0000-0000-000000000008';
  eq9 uuid := 'a1000000-0000-0000-0000-000000000009';
  eq10 uuid := 'a1000000-0000-0000-0000-000000000010';
BEGIN
  SELECT id INTO admin_id FROM profiles WHERE role = 'admin' LIMIT 1;
  IF admin_id IS NULL THEN
    RAISE EXCEPTION 'No admin user found. Set your profile role to admin first.';
  END IF;

  -- ========================================================================
  -- EQUIPMENT (10 items)
  -- ========================================================================
  INSERT INTO equipment (id, name, equipment_type, location, serial_number, manufacturer, model, install_date, status, notes, created_by)
  VALUES
    (eq1, 'Boiler #1 — Main Steam', 'Boiler', 'Boiler House', 'BLR-2019-4421', 'Cleaver-Brooks', 'CBLE-700', '2019-03-15', 'operational', 'Main steam boiler — 700 HP, natural gas fired. Annual inspection due March.', admin_id),
    (eq2, 'Boiler #2 — Backup', 'Boiler', 'Boiler House', 'BLR-2019-4422', 'Cleaver-Brooks', 'CBLE-500', '2019-03-15', 'operational', 'Backup boiler — 500 HP. Used during peak demand or BLR-001 downtime.', admin_id),
    (eq3, 'Chiller — Primary', 'HVAC', 'Mechanical Room 1', 'YK-2021-88190', 'York', 'YK-450T', '2021-06-01', 'operational', 'Primary chiller for building cooling. 450-ton capacity.', admin_id),
    (eq4, 'AHU-1 — Main Office', 'HVAC', 'Rooftop', 'TR-2020-55612', 'Trane', 'IntelliPak', '2020-01-10', 'operational', 'Serves main office area, floors 1-3. Belt-driven supply fan.', admin_id),
    (eq5, 'AHU-2 — Production Floor', 'HVAC', 'Rooftop', 'TR-2020-55613', 'Trane', 'IntelliPak', '2020-01-10', 'maintenance', 'Serves production floor. VFD on supply fan. Currently undergoing filter replacement.', admin_id),
    (eq6, 'Cooling Tower #1', 'HVAC', 'Rooftop', 'BAC-2021-33100', 'BAC', 'Series 3000', '2021-06-01', 'operational', 'Paired with primary chiller. Chemical treatment by Nalco.', admin_id),
    (eq7, 'Emergency Generator', 'Electrical', 'Generator Yard', 'CAT-2018-76200', 'Caterpillar', 'C15 — 500kW', '2018-09-20', 'operational', 'Diesel backup generator. Weekly test runs every Monday 07:00.', admin_id),
    (eq8, 'Fire Pump — Electric', 'Fire Protection', 'Pump Room B2', 'AC-2019-11050', 'AC Fire Pump', 'A-10-8-13F', '2019-05-01', 'operational', 'Electric fire pump, 1000 GPM. Annual flow test due May.', admin_id),
    (eq9, 'Passenger Elevator #1', 'Vertical Transport', 'Lobby', 'OTIS-2017-90443', 'Otis', 'Gen2 MRL', '2017-11-15', 'operational', 'Main lobby elevator, floors B1 to 5. Under Otis service contract.', admin_id),
    (eq10, 'Compressor — Plant Air', 'Compressed Air', 'Mechanical Room 2', 'AS-2020-22780', 'Atlas Copco', 'GA37 VSD', '2020-04-01', 'operational', 'Variable speed 50 HP rotary screw compressor. Serves production floor air tools.', admin_id);

  -- ========================================================================
  -- WORK ORDERS (8 items)
  -- ========================================================================
  INSERT INTO work_orders (title, description, equipment_id, equipment_name, priority, status, assigned_to, created_by, due_date, estimated_hours, wo_number, comments)
  VALUES
    ('AHU-2 Filter Replacement', 'Replace all supply and return air filters on AHU-2. Production floor reporting poor air quality and increased dust.', eq5, 'AHU-2 — Production Floor', 'high', 'in_progress', admin_id, 'Craig Ross', CURRENT_DATE + 2, 4.0, 'WO-2026-001', '[]'::jsonb),
    ('Boiler #1 Annual Inspection Prep', 'Prepare boiler for annual insurance inspection. Drain, clean fireside, inspect tubes, test safety valves.', eq1, 'Boiler #1 — Main Steam', 'critical', 'open', admin_id, 'Craig Ross', CURRENT_DATE + 14, 16.0, 'WO-2026-002', '[]'::jsonb),
    ('Generator Weekly Test — Failed Start', 'Weekly test run failed to start on first attempt. Investigate fuel system and battery condition.', eq7, 'Emergency Generator', 'high', 'open', admin_id, 'Craig Ross', CURRENT_DATE + 1, 3.0, 'WO-2026-003', '[]'::jsonb),
    ('Chiller Condenser Tube Cleaning', 'Annual condenser tube cleaning. Water treatment report shows increased fouling factor.', eq3, 'Chiller — Primary', 'medium', 'open', admin_id, 'Craig Ross', CURRENT_DATE + 21, 8.0, 'WO-2026-004', '[]'::jsonb),
    ('Cooling Tower Basin Cleaning', 'Drain and clean cooling tower basin. Remove sediment and inspect fill media for damage.', eq6, 'Cooling Tower #1', 'medium', 'open', admin_id, 'Craig Ross', CURRENT_DATE + 28, 6.0, 'WO-2026-005', '[]'::jsonb),
    ('Compressor Oil Change', 'Scheduled oil change on plant air compressor. Replace oil filter and separator element.', eq10, 'Compressor — Plant Air', 'low', 'completed', admin_id, 'Craig Ross', CURRENT_DATE - 3, 2.0, 'WO-2026-006', '[]'::jsonb),
    ('Elevator Annual Safety Test', 'Coordinate with Otis for annual safety test and certificate renewal. Required by insurance.', eq9, 'Passenger Elevator #1', 'medium', 'open', admin_id, 'Craig Ross', CURRENT_DATE + 30, 4.0, 'WO-2026-007', '[]'::jsonb),
    ('Fire Pump Flow Test', 'Annual fire pump flow test per NFPA 25. Coordinate with fire protection contractor.', eq8, 'Fire Pump — Electric', 'high', 'open', admin_id, 'Craig Ross', CURRENT_DATE + 60, 4.0, 'WO-2026-008', '[]'::jsonb);

  -- ========================================================================
  -- PARTS INVENTORY (15 items)
  -- ========================================================================
  INSERT INTO parts_inventory (part_name, part_number, description, quantity_in_stock, minimum_stock, unit_cost, location)
  VALUES
    ('AHU Filter 20x20x2 MERV-13', 'FLT-20202-M13', 'Pleated air filter, 20x20x2 inch, MERV-13 rating', 48, 24, 12.50, 'Storeroom A'),
    ('AHU Filter 24x24x2 MERV-13', 'FLT-24242-M13', 'Pleated air filter, 24x24x2 inch, MERV-13 rating', 36, 12, 14.75, 'Storeroom A'),
    ('V-Belt B68', 'BLT-B68', 'V-belt, B section, 68 inch. AHU supply fan drive belt.', 6, 4, 18.90, 'Storeroom A'),
    ('Bearing 6205-2RS', 'BRG-6205-2RS', 'Deep groove ball bearing, 25mm bore, sealed both sides', 8, 4, 9.50, 'Storeroom A'),
    ('Compressor Oil — Roto-Xtend', 'OIL-RX-5L', 'Atlas Copco Roto-Xtend Duty Fluid, 5 liter', 3, 2, 89.00, 'Storeroom B'),
    ('Oil Separator Element', 'SEP-GA37', 'Oil separator element for GA37 compressor', 2, 1, 245.00, 'Storeroom B'),
    ('Boiler Gauge Glass', 'GG-BLR-12', 'Sight glass for boiler water level, 12 inch', 4, 2, 35.00, 'Storeroom B'),
    ('Safety Relief Valve 150PSI', 'SRV-150', 'ASME safety relief valve, 150 PSI set pressure, 1 inch', 2, 1, 185.00, 'Storeroom B'),
    ('Cooling Tower Fill Media', 'CT-FILL-24', 'Cross-flow fill media sheet, 24x24 inch', 10, 5, 42.00, 'Warehouse'),
    ('Chemical Treatment — Nalco 3D TRASAR', 'CHEM-3DT-25', 'Cooling water treatment chemical, 25 gallon drum', 2, 1, 320.00, 'Chemical Store'),
    ('Generator Fuel Filter', 'FF-CAT-C15', 'Primary fuel filter for CAT C15 diesel generator', 4, 2, 28.50, 'Storeroom B'),
    ('Generator Battery 12V', 'BAT-8D-12V', 'Heavy duty 8D battery, 12V, 1400 CCA', 2, 1, 275.00, 'Storeroom B'),
    ('Refrigerant R-134a (30 lb)', 'REF-134A-30', 'R-134a refrigerant, 30 lb cylinder', 3, 2, 165.00, 'Chemical Store'),
    ('Contactor 3-Pole 40A', 'CTR-3P-40A', 'Definite purpose contactor, 3-pole, 40 amp, 24V coil', 3, 2, 32.00, 'Storeroom A'),
    ('Pressure Gauge 0-300 PSI', 'PG-300-4', '4 inch dial pressure gauge, 0-300 PSI, 1/4 NPT bottom mount', 5, 3, 22.00, 'Storeroom A');

  -- ========================================================================
  -- PM TASKS (8 items)
  -- ========================================================================
  INSERT INTO pm_tasks (title, description, equipment_id, frequency, assigned_to, next_due_date, estimated_hours, is_active, created_by)
  VALUES
    ('AHU-1 & AHU-2 Filter Change', 'Replace all supply and return filters. Check belt tension. Inspect coils for fouling.', eq4, 'monthly', admin_id, CURRENT_DATE + 12, 3.0, true, admin_id),
    ('Boiler #1 Blowdown & Water Test', 'Perform bottom blowdown. Test boiler water chemistry (pH, TDS, hardness). Log results.', eq1, 'weekly', admin_id, CURRENT_DATE + 3, 1.0, true, admin_id),
    ('Generator Weekly Test Run', 'Start generator under no-load. Run for 30 minutes. Check oil pressure, coolant temp, battery voltage. Log hours.', eq7, 'weekly', admin_id, CURRENT_DATE + 4, 1.0, true, admin_id),
    ('Chiller Log Review', 'Review chiller operating logs. Check suction/discharge pressures, oil level, approach temps. Flag anomalies.', eq3, 'weekly', admin_id, CURRENT_DATE + 5, 0.5, true, admin_id),
    ('Cooling Tower Chemical Treatment Check', 'Check Nalco 3D TRASAR readings. Verify chemical feed rates. Inspect basin for algae. Bleed conductivity.', eq6, 'weekly', admin_id, CURRENT_DATE + 5, 1.0, true, admin_id),
    ('Fire Pump Churn Test', 'Run fire pump for 10 minutes under churn (no-flow) conditions. Record suction/discharge pressure and RPM.', eq8, 'weekly', admin_id, CURRENT_DATE + 6, 0.5, true, admin_id),
    ('Compressor Air Dryer Check', 'Check desiccant dryer operation. Verify dewpoint readings. Drain auto-drain traps. Check pressure drop across filters.', eq10, 'monthly', admin_id, CURRENT_DATE + 18, 1.0, true, admin_id),
    ('Emergency Lighting & Exit Sign Test', 'Monthly 30-second test of all emergency lights and exit signs. Log any failures for repair.', eq1, 'monthly', admin_id, CURRENT_DATE + 20, 2.0, true, admin_id);

  -- ========================================================================
  -- PURCHASE ORDERS (4 items)
  -- ========================================================================
  INSERT INTO purchase_orders (po_number, supplier, status, requested_by, total_cost, title, priority, notes, order_date, expected_delivery, budget_code)
  VALUES
    ('PO-2026-001', 'Grainger', 'ordered', admin_id, 594.00, 'AHU Filters — Q2 Stock', 'high', 'Quarterly filter order for AHU-1 and AHU-2.', CURRENT_DATE - 5, CURRENT_DATE + 5, 'MNT-HVAC'),
    ('PO-2026-002', 'Atlas Copco Direct', 'approved', admin_id, 579.00, 'Compressor Maintenance Kit', 'medium', 'Annual service kit: oil, separator, air filter.', CURRENT_DATE - 2, CURRENT_DATE + 14, 'MNT-MECH'),
    ('PO-2026-003', 'Caterpillar', 'draft', admin_id, 607.00, 'Generator Service Parts', 'medium', 'Fuel filters, oil filters, coolant test strips for annual service.', NULL, NULL, 'MNT-ELEC'),
    ('PO-2026-004', 'Nalco Water', 'received', admin_id, 640.00, 'Cooling Water Treatment Chemicals', 'low', 'Monthly chemical delivery for cooling tower treatment.', CURRENT_DATE - 15, CURRENT_DATE - 5, 'MNT-HVAC');

  -- ========================================================================
  -- PERMITS (4 items)
  -- ========================================================================
  INSERT INTO permits (permit_type, title, description, status, requested_by, contractor_name, contractor_company, work_location, equipment_id, valid_from, valid_until, fire_watch_required)
  VALUES
    ('hot_work', 'Boiler Tube Welding', 'Welding repair on boiler #1 economizer tubes. Hot work permit required per facility policy.', 'active', admin_id, NULL, NULL, 'Boiler House', eq1, CURRENT_DATE, CURRENT_DATE + 3, true),
    ('contractor', 'Otis Elevator Annual Inspection', 'Annual safety inspection and certificate renewal for passenger elevator #1.', 'approved', admin_id, 'James Wright', 'Otis Elevator Co.', 'Lobby — Elevator #1', eq9, CURRENT_DATE + 7, CURRENT_DATE + 8, false),
    ('hot_work', 'Cooling Tower Pipe Repair', 'Brazing repair on condenser water piping near cooling tower. Open flame work above grade.', 'active', admin_id, NULL, NULL, 'Rooftop — Near CT-001', eq6, CURRENT_DATE - 1, CURRENT_DATE + 1, true),
    ('contractor', 'Fire Pump Test — Annual Flow', 'Annual flow test of electric fire pump per NFPA 25 by certified contractor.', 'pending_approval', admin_id, 'Tom Bradley', 'Allied Fire Protection', 'Pump Room B2', eq8, CURRENT_DATE + 30, CURRENT_DATE + 30, false);

  -- ========================================================================
  -- BREAKDOWNS (4 items)
  -- ========================================================================
  INSERT INTO breakdowns (equipment_id, equipment_name, reported_by, title, description, severity, status, downtime_started, downtime_ended, root_cause, resolution)
  VALUES
    (eq5, 'AHU-2 — Production Floor', admin_id, 'AHU-2 Supply Fan Tripped on Overload', 'Supply fan motor tripped on thermal overload. Production floor lost cooling.', 'high', 'resolved', CURRENT_DATE - 10, CURRENT_DATE - 10 + interval '4 hours', 'Dirty filters caused excessive static pressure, overloading the motor.', 'Replaced all filters. Reset thermal overload. Motor tested OK — no damage.'),
    (eq7, 'Emergency Generator', admin_id, 'Generator Failed to Start — Weekly Test', 'Generator cranked but did not fire during weekly test run.', 'critical', 'investigating', CURRENT_DATE - 1, NULL, NULL, NULL),
    (eq10, 'Compressor — Plant Air', admin_id, 'Low Air Pressure Alarm', 'Plant air pressure dropped below 90 PSI. Production air tools losing power.', 'medium', 'resolved', CURRENT_DATE - 21, CURRENT_DATE - 21 + interval '2 hours', 'Inlet filter clogged with dust from nearby construction.', 'Replaced inlet filter. Pressure returned to 110 PSI operating setpoint.'),
    (eq3, 'Chiller — Primary', admin_id, 'Chiller High Head Pressure Alarm', 'Chiller tripped on high head pressure during afternoon peak load.', 'high', 'resolved', CURRENT_DATE - 45, CURRENT_DATE - 45 + interval '6 hours', 'Condenser tubes fouled — approach temp was 12F (spec: 5F).', 'Emergency condenser tube cleaning performed. Approach temp returned to 4.5F.');

  -- ========================================================================
  -- CALENDAR EVENTS (6 items)
  -- ========================================================================
  INSERT INTO calendar_events (title, description, event_type, start_time, end_time, all_day, assigned_to, equipment_id, created_by)
  VALUES
    ('Boiler #1 — Annual Insurance Inspection', 'Inspector from Hartford Steam Boiler. Full internal inspection required.', 'inspection', (CURRENT_DATE + 14)::timestamp + interval '9 hours', (CURRENT_DATE + 14)::timestamp + interval '16 hours', false, admin_id, eq1, admin_id),
    ('Elevator Safety Test — Otis', 'Annual ASME A17.1 safety test. Elevator will be out of service all day.', 'inspection', (CURRENT_DATE + 7)::timestamp + interval '9 hours', (CURRENT_DATE + 7)::timestamp + interval '17 hours', false, admin_id, eq9, admin_id),
    ('Cooling Tower Spring Startup', 'Seasonal startup of cooling tower. Fill basin, start chemical treatment, commission pumps.', 'pm_scheduled', (CURRENT_DATE + 21)::timestamp + interval '7 hours', (CURRENT_DATE + 21)::timestamp + interval '15 hours', false, admin_id, eq6, admin_id),
    ('Fire Pump Flow Test', 'Annual NFPA 25 flow test with Allied Fire Protection.', 'inspection', (CURRENT_DATE + 30)::timestamp + interval '8 hours', (CURRENT_DATE + 30)::timestamp + interval '12 hours', false, admin_id, eq8, admin_id),
    ('Safety Committee Meeting', 'Monthly safety committee meeting. Review incidents, near-misses, and upcoming hot work.', 'meeting', (CURRENT_DATE + 10)::timestamp + interval '10 hours', (CURRENT_DATE + 10)::timestamp + interval '11 hours', false, admin_id, NULL, admin_id),
    ('Planned Shutdown — Mechanical Room 1', 'Full shutdown of Mechanical Room 1 for chiller maintenance and pipe insulation repair.', 'shutdown', (CURRENT_DATE + 35)::timestamp + interval '6 hours', (CURRENT_DATE + 36)::timestamp + interval '18 hours', false, admin_id, eq3, admin_id);

  -- ========================================================================
  -- WORK REQUESTS (5 items)
  -- ========================================================================
  INSERT INTO work_requests (equipment, description, urgency, submitter, status)
  VALUES
    ('AHU-1 — Main Office', 'Office on 2nd floor is too warm. Thermostat reads 78F, setpoint is 72F.', 'medium', 'Sarah Johnson — Office Manager', 'pending'),
    ('Passenger Elevator #1', 'Elevator making grinding noise when stopping at floor 3. Passengers concerned.', 'high', 'Mike Torres — Security', 'pending'),
    ('Boiler House', 'Small water leak spotted near the condensate return pipe in the boiler room.', 'high', 'Dave Chen — Maintenance Tech', 'approved'),
    ('Compressor — Plant Air', 'Air hose fitting on production line 4 is leaking. Can hear hissing.', 'low', 'Lisa Park — Production Lead', 'pending'),
    ('Main Parking Lot', 'Two light poles in the south parking lot are out. Safety concern for night shift.', 'medium', 'Tom Bradley — Facilities', 'pending');

  RAISE NOTICE 'Demo data inserted successfully!';
END $$;
