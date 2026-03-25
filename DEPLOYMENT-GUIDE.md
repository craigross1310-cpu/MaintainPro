# Cradero — Complete Deployment & Backend Guide

This guide takes you from zero to a fully live, secure maintenance management app.
No coding experience required. Every step is explained.

---

## Table of Contents

1. [Overview & Costs](#1-overview--costs)
2. [Feature Overview by Tier](#2-feature-overview-by-tier)
3. [Part A — Get Your Site Live](#part-a--get-your-site-live)
   - [Step 1: Create a GitHub Account](#step-1-create-a-github-account)
   - [Step 2: Create a Repository & Upload Your Files](#step-2-create-a-repository--upload-your-files)
   - [Step 3: Deploy to Vercel (Free)](#step-3-deploy-to-vercel-free)
   - [Step 4: Buy a Domain](#step-4-buy-a-domain)
   - [Step 5: Connect Your Domain to Vercel](#step-5-connect-your-domain-to-vercel)
4. [Part B — Build the Backend with Supabase](#part-b--build-the-backend-with-supabase)
   - [Step 6: Create a Supabase Project](#step-6-create-a-supabase-project)
   - [Step 7: Create Database Tables](#step-7-create-database-tables)
   - [Step 8: Set Up Security (Row Level Security)](#step-8-set-up-security-row-level-security)
   - [Step 9: Set Up User Login (Authentication)](#step-9-set-up-user-login-authentication)
   - [Step 10: Connect Your Frontend to Supabase](#step-10-connect-your-frontend-to-supabase)
   - [Step 11: Create Storage Buckets (Photo & Document Uploads)](#step-11-create-storage-buckets-photo--document-uploads)
5. [Part C — Security & API Keys](#part-c--security--api-keys)
6. [Part D — Free Tier Limits & When to Upgrade](#part-d--free-tier-limits--when-to-upgrade)
7. [Part E — Roles, Tiers & Permissions](#part-e--roles-tiers--permissions)
8. [Part F — Seeding Demo Data (Optional)](#part-f--seeding-demo-data-optional)
9. [Part G — Resetting for a New Customer](#part-g--resetting-for-a-new-customer)
10. [Part H — Running Migrations on Existing Deployments](#part-h--running-migrations-on-existing-deployments)
11. [Part I — Next Steps](#part-i--next-steps)

---

## 1. Overview & Costs

| Item | Cost |
|------|------|
| GitHub account | Free |
| Vercel hosting (Hobby plan) | Free |
| Supabase backend (Free tier) | Free |
| SSL certificate (HTTPS) | Free (auto from Vercel) |
| Domain name (.com via Cloudflare) | ~£7.50/year (~$9.15/year) |
| **Total** | **~£7.50/year** |

When you outgrow free tiers (unlikely for the first year or two):
- Vercel Pro: $20/month
- Supabase Pro: $25/month

---

## 2. Feature Overview by Tier

Cradero has three subscription tiers that control which modules are available. The tier is set per-user in the `profiles.tier` column.

### Essential Tier (Default)

| Module | Description |
|--------|-------------|
| Work Orders | Create, assign, track, comment, attach photos, log time |
| Equipment | Register assets with criticality ratings, warranty tracking |
| Preventive Maintenance | Schedule recurring PMs with checklists, track completions |
| Reactive Maintenance | Log breakdowns with fault cause analysis, link to work orders |
| Work Requests | Production staff submit requests, managers approve/decline |
| Permits | Hot work and contractor permits with safety checklists |
| Daily Activity Log | Timeline view of all activity for any given day |
| My Tasks / Engineer Dashboard | Personal view of assigned WOs and PMs |
| Audit Trail | Full CRUD audit log (admin-read-only) |
| CSV Bulk Import | Import equipment, parts, and PM schedules from CSV files |

### Pro Tier (All Essential features plus)

| Module | Description |
|--------|-------------|
| Parts Inventory | Multi-supplier tracking, stock forecasting, bin locations |
| Purchase Orders | Create, approve, track POs with line items and PDF export |
| Analytics & Reports | 16 analytics panels with charts, MTTR/MTBF, fault analysis |
| Maintenance Calendar | Month/week view with colour-coded event types |
| QR Codes | Generate and scan QR codes for equipment identification |
| Equipment SOPs & Manuals | Upload and attach documents to equipment records |
| PDF Export | Export work orders, equipment, parts, PMs, POs, and full reports |
| Dark Mode | Full dark theme toggle |
| Offline / PWA | Service worker for offline access (network-first caching) |
| Equipment Health Scores | Composite health score (0-100) per asset |
| Stock Forecast | Months-until-depletion predictions for parts |

### User Roles (5 roles)

| Role | Description |
|------|-------------|
| `pending` | New sign-ups — blocked from the app until an admin approves them |
| `engineer` | Can create/update work orders, equipment, PMs, log breakdowns |
| `manager` | All engineer permissions plus approve permits, POs, work requests, delete records |
| `admin` | Full access — manage users, roles, tiers, delete anything, view audit trail |
| `production` | Limited access — can only see and submit Work Requests |

---

# Part A — Get Your Site Live

## Step 1: Create a GitHub Account

GitHub stores your code and connects to Vercel for automatic deployments.

1. Go to **https://github.com**
2. Click **Sign up** (top right)
3. Enter your **email**, create a **password**, and pick a **username**
4. Complete the CAPTCHA puzzle
5. Choose the **Free** plan (default)
6. Check your email — click the verification link from GitHub
7. Skip the personalisation questions if you want

You now have a GitHub account.

---

## Step 2: Create a Repository & Upload Your Files

A "repository" (repo) is a folder on GitHub that holds your project files.

1. From your GitHub dashboard, click the green **New** button (left sidebar) or the **+** icon (top right) → **New repository**
2. Fill in:
   - **Repository name**: `cradero` (no spaces — use hyphens)
   - **Description**: `Maintenance management software`
   - **Visibility**: **Public** (simpler for free Vercel hosting)
   - Tick **Add a README file**
3. Click **Create repository**

### Upload your project files:

4. In your new repo, click **Add file** → **Upload files**
5. Upload these files:
   - `index.html` — the main application (single-page app)
   - `config.js` — Supabase credentials (you'll edit this after Step 6)
   - `sw.js` — service worker for offline support (Pro tier)
6. At the bottom, type a message like `Add website files` and click **Commit changes**

**Do NOT upload** to the repo:
- `config.js.example` — this is a template, not needed in production
- `migrations/` — these are run manually in Supabase, not served as web files
- `sample-*.csv` — optional import templates, only upload if you want users to download them

Your code is now on GitHub.

---

## Step 3: Deploy to Vercel (Free)

Vercel hosts your site and makes it accessible at a URL like `cradero.vercel.app`.

1. Go to **https://vercel.com** and click **Sign Up**
2. Choose **Continue with GitHub** — authorise Vercel when prompted
3. Once logged in, click **Add New...** → **Project**
4. Find `cradero` in the list of repos → click **Import**
   - If you don't see it: click **Adjust GitHub App Permissions** and grant access
5. On the Configure Project screen:
   - **Project Name**: `cradero` (or whatever you want)
   - **Framework Preset**: select **Other**
   - **Build and Output Settings**: leave everything blank/default
6. Click **Deploy**
7. Wait 10–30 seconds. Done!

You'll see a "Congratulations" screen with a link like `https://cradero.vercel.app`. Click it — your site is live.

### Automatic updates:
From now on, every time you push changes to GitHub, Vercel automatically redeploys within seconds. Edit a file on GitHub, commit, and your live site updates.

---

## Step 4: Buy a Domain

**Recommended: Cloudflare** — cheapest registrar with no markup and no price increases on renewal.

1. Go to **https://dash.cloudflare.com/sign-up**
2. Create an account (email + password)
3. Verify your email via the link they send
4. In the left sidebar, click **Domain Registration** → **Register Domains**
5. Search for the domain you want, e.g. `cradero-scotland.com`
6. Click **Purchase** next to your choice
7. Fill in your contact info (Cloudflare hides this from the public for free)
8. Enter payment details (card or PayPal)
9. Click **Complete purchase**

Your domain is now registered. Typical `.com` cost: ~$9.15/year.

**Alternative registrars:**

| Registrar | 1st Year | Renewal | Free WHOIS Privacy |
|-----------|----------|---------|-------------------|
| Cloudflare | ~$9.15 | ~$9.15 | Yes |
| Namecheap | ~$8.88 | ~$12.98 | Yes |
| Dynadot | ~$9.49 | ~$9.99 | Yes |

---

## Step 5: Connect Your Domain to Vercel

### In Vercel:

1. Go to your Vercel dashboard → click your project
2. Click **Settings** (top nav) → **Domains** (left sidebar)
3. Type your domain (e.g. `cradero-scotland.com`) and click **Add**
4. Choose the recommended option (usually root domain as primary, `www` redirecting to it)
5. Vercel will show you **DNS records to create**. Keep this page open — you'll need these values.

You'll see something like:
- **A Record**: Name = `@`, Value = `76.76.21.21`
- **CNAME Record**: Name = `www`, Value = `cname.vercel-dns.com`

### In Cloudflare:

6. Log into **Cloudflare dashboard** → click your domain
7. Click **DNS** (left sidebar) → **Records**
8. Click **Add record**:
   - Type: **A**
   - Name: **@**
   - IPv4 address: paste the IP from Vercel (e.g. `76.76.21.21`)
   - **Proxy status**: click the orange cloud to make it **grey** (DNS only) — this is important
   - Click **Save**
9. Click **Add record** again:
   - Type: **CNAME**
   - Name: **www**
   - Target: `cname.vercel-dns.com`
   - **Proxy status**: **grey cloud** again
   - Click **Save**

### Verify:

10. Go back to Vercel → Settings → Domains
11. Wait 1–10 minutes for DNS to propagate
12. Status will change to a green checkmark
13. Vercel automatically sets up HTTPS (free SSL certificate)

Visit `https://yourdomain.com` — your site is live with a padlock!

---

# Part B — Build the Backend with Supabase

Right now, Cradero stores data in the browser — refresh the page and seed data resets. Supabase gives you a real database so data persists, multiple users can log in, and everything is secure.

## What is Supabase?

Supabase gives you four things without writing server code:
- **A database** (PostgreSQL) — where all your data lives permanently
- **Authentication** — user login/logout, passwords, sessions
- **Storage** — file uploads for photos, SOPs, and manuals
- **An API** — your frontend talks to the database through it automatically

---

## Step 6: Create a Supabase Project

1. Go to **https://supabase.com** → click **Start your project**
2. Sign up with your **GitHub account**
3. Click **New project**
4. Fill in:
   - **Name**: `cradero`
   - **Database Password**: use something strong like `Maint2026!SecureDB` — **save this somewhere safe**
   - **Region**: pick the closest to Scotland (London or Frankfurt)
   - **Plan**: Free (already selected)
5. Click **Create new project** — wait 1–2 minutes

### Find your API keys:

6. Click **Settings** (gear icon, bottom of left sidebar)
7. Click **API** under Configuration
8. Write down these two values — you'll need them later:
   - **Project URL**: `https://abcdefghijk.supabase.co`
   - **anon (public) key**: long string starting with `eyJ...`
   - **service_role key**: **NEVER put this in your website code** (it bypasses all security)

---

## Step 7: Create Database Tables

1. In your Supabase dashboard, click **SQL Editor** (left sidebar)
2. Click **New query**
3. Copy and paste the SQL below, then click **Run** (green play button)

You can paste it all at once or do each section separately.

### Profiles (extends the built-in user accounts)

```sql
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'pending'
    CHECK (role IN ('pending', 'engineer', 'manager', 'admin', 'production')),
  tier TEXT DEFAULT 'essential'
    CHECK (tier IN ('essential', 'pro')),
  department TEXT,
  phone TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Auto-create a profile when someone signs up (role defaults to 'pending')
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    'pending'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

### Equipment

```sql
CREATE TABLE public.equipment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  equipment_type TEXT,
  equipment_code TEXT DEFAULT '',
  location TEXT,
  serial_number TEXT,
  manufacturer TEXT,
  model TEXT,
  install_date DATE,
  status TEXT DEFAULT 'operational'
    CHECK (status IN ('operational', 'down', 'maintenance', 'decommissioned')),
  criticality TEXT DEFAULT 'B'
    CHECK (criticality IN ('A', 'B', 'C')),
  warranty_expiry DATE,
  warranty_provider TEXT DEFAULT '',
  warranty_notes TEXT DEFAULT '',
  sop_urls JSONB DEFAULT '[]'::jsonb,
  manual_urls JSONB DEFAULT '[]'::jsonb,
  notes TEXT,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### Work Orders

```sql
CREATE TABLE public.work_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  wo_number TEXT,
  title TEXT NOT NULL,
  description TEXT,
  equipment_id UUID REFERENCES public.equipment(id),
  equipment_name TEXT DEFAULT '',
  priority TEXT DEFAULT 'medium'
    CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  status TEXT DEFAULT 'open'
    CHECK (status IN ('open', 'in_progress', 'on_hold', 'completed', 'cancelled')),
  assigned_to TEXT,
  requested_by TEXT,
  created_by TEXT DEFAULT '',
  due_date DATE,
  completed_at TIMESTAMPTZ,
  estimated_hours NUMERIC(5,1),
  actual_hours NUMERIC(5,1),
  start_time TEXT,
  finish_time TEXT,
  total_job_time TEXT DEFAULT '',
  machine_downtime TEXT DEFAULT '',
  has_photos BOOLEAN DEFAULT false,
  photo_urls JSONB DEFAULT '[]'::jsonb,
  comments JSONB DEFAULT '[]'::jsonb,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Auto-generate WO numbers (WO-2026-001, WO-2026-002, etc.)
CREATE OR REPLACE FUNCTION generate_wo_number()
RETURNS trigger AS $$
BEGIN
    IF NEW.wo_number IS NULL THEN
        NEW.wo_number := 'WO-' || to_char(now(), 'YYYY') || '-' || lpad(NEW.id::text, 3, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_wo_number
    BEFORE INSERT ON work_orders
    FOR EACH ROW EXECUTE FUNCTION generate_wo_number();
```

### Parts Inventory

```sql
CREATE TABLE public.parts_inventory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  part_name TEXT NOT NULL,
  part_number TEXT UNIQUE,
  description TEXT,
  quantity_in_stock INTEGER DEFAULT 0,
  minimum_stock INTEGER DEFAULT 0,
  unit_cost NUMERIC(10,2),
  location TEXT,
  shelf TEXT DEFAULT '',
  bin TEXT DEFAULT '',
  monthly_usage INTEGER DEFAULT 0,
  compatible_equipment JSONB DEFAULT '[]'::jsonb,
  suppliers JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

**Note on `suppliers`**: This is a JSONB array of objects, each with `name`, `partNo`, `price`, and `leadTime` fields. Example:
```json
[
  {"name": "Grainger", "partNo": "GR-12345", "price": 12.50, "leadTime": "3-5 days"},
  {"name": "McMaster-Carr", "partNo": "MC-67890", "price": 11.95, "leadTime": "1-2 days"}
]
```

### Parts Usage (tracks parts consumed on work orders)

```sql
CREATE TABLE public.parts_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  work_order_id UUID REFERENCES public.work_orders(id),
  part_id UUID REFERENCES public.parts_inventory(id),
  quantity_used INTEGER NOT NULL DEFAULT 1,
  used_at TIMESTAMPTZ DEFAULT now(),
  returned BOOLEAN DEFAULT false,
  return_quantity INTEGER DEFAULT 0
);
```

### Breakdowns (Reactive Maintenance)

```sql
CREATE TABLE public.breakdowns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  equipment_id UUID NOT NULL REFERENCES public.equipment(id),
  equipment_name TEXT DEFAULT '',
  reported_by UUID REFERENCES public.profiles(id),
  title TEXT NOT NULL,
  description TEXT,
  severity TEXT DEFAULT 'medium'
    CHECK (severity IN ('low', 'medium', 'high', 'critical')),
  status TEXT DEFAULT 'reported'
    CHECK (status IN ('reported', 'investigating', 'repair_in_progress', 'resolved')),
  work_order_id UUID REFERENCES public.work_orders(id),
  linked_wo_id UUID,
  downtime_started TIMESTAMPTZ DEFAULT now(),
  downtime_ended TIMESTAMPTZ,
  root_cause TEXT,
  resolution TEXT,
  fault_cause TEXT,
  job_started TIMESTAMPTZ,
  job_finished TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

**Note on `fault_cause`**: The frontend uses 10 standard categories: Electrical, Mechanical, Hydraulic, Pneumatic, Software PLC, Operator Error, Wear & Tear, Contamination, Calibration, Other. These are used for fault cause analysis in the Analytics module.

### Calendar Events

```sql
CREATE TABLE public.calendar_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  event_type TEXT NOT NULL
    CHECK (event_type IN ('pm_scheduled', 'inspection', 'shutdown', 'meeting', 'training', 'other')),
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ,
  all_day BOOLEAN DEFAULT false,
  assigned_to TEXT,
  equipment_id UUID REFERENCES public.equipment(id),
  work_order_id UUID REFERENCES public.work_orders(id),
  recurrence_rule TEXT,
  created_by TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### Purchase Orders

```sql
CREATE TABLE public.purchase_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  po_number TEXT UNIQUE NOT NULL,
  title TEXT DEFAULT '',
  supplier TEXT NOT NULL,
  status TEXT DEFAULT 'draft'
    CHECK (status IN ('draft', 'pending', 'submitted', 'approved', 'ordered', 'in-transit', 'received', 'cancelled')),
  priority TEXT DEFAULT 'medium',
  requested_by UUID REFERENCES public.profiles(id),
  approved_by UUID REFERENCES public.profiles(id),
  total_cost NUMERIC(12,2),
  notes TEXT,
  order_date DATE,
  expected_delivery DATE,
  actual_delivery DATE,
  tracking_number TEXT,
  budget_code TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.po_line_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_order_id UUID NOT NULL REFERENCES public.purchase_orders(id) ON DELETE CASCADE,
  part_id UUID REFERENCES public.parts_inventory(id),
  description TEXT NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  unit_cost NUMERIC(10,2) NOT NULL,
  total_cost NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_cost) STORED,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

### Permits (Hot Work & Contractor)

```sql
CREATE TABLE public.permits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  permit_type TEXT NOT NULL
    CHECK (permit_type IN ('hot_work', 'contractor', 'confined_space', 'electrical', 'general')),
  title TEXT NOT NULL,
  description TEXT,
  status TEXT DEFAULT 'draft'
    CHECK (status IN ('draft', 'pending_approval', 'approved', 'active', 'expired', 'revoked', 'closed')),
  requested_by UUID REFERENCES public.profiles(id),
  approved_by UUID REFERENCES public.profiles(id),
  contractor_name TEXT,
  contractor_company TEXT,
  work_location TEXT,
  equipment_id UUID REFERENCES public.equipment(id),
  valid_from TIMESTAMPTZ,
  valid_until TIMESTAMPTZ,
  safety_precautions TEXT,
  fire_watch_required BOOLEAN DEFAULT false,
  approved_at TIMESTAMPTZ,
  engineer TEXT DEFAULT '',
  fire_watch TEXT DEFAULT '',
  start_time_of_day TEXT DEFAULT '',
  end_time_of_day TEXT DEFAULT '',
  workers INTEGER DEFAULT 0,
  phone TEXT DEFAULT '',
  insurance TEXT DEFAULT '',
  closed_date TIMESTAMPTZ,
  closed_by TEXT DEFAULT '',
  scope TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### Preventive Maintenance Tasks

```sql
CREATE TABLE public.pm_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  equipment_id UUID NOT NULL REFERENCES public.equipment(id),
  equipment_name TEXT DEFAULT '',
  frequency TEXT NOT NULL
    CHECK (frequency IN ('Daily', 'Weekly', 'Bi-weekly', 'Monthly', 'Quarterly', 'Semi-annual', 'Annual')),
  assigned_to TEXT,
  created_by TEXT,
  last_completed_at TIMESTAMPTZ,
  next_due_date DATE,
  estimated_hours NUMERIC(5,1),
  duration TEXT DEFAULT '',
  due_status TEXT DEFAULT 'upcoming',
  checklist JSONB DEFAULT '[]'::jsonb,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.pm_completions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pm_task_id UUID NOT NULL REFERENCES public.pm_tasks(id) ON DELETE CASCADE,
  completed_by UUID REFERENCES public.profiles(id),
  completed_at TIMESTAMPTZ DEFAULT now(),
  actual_hours NUMERIC(5,1),
  checklist_results JSONB,
  notes TEXT,
  work_order_id UUID REFERENCES public.work_orders(id),
  parts_used JSONB,
  start_time TEXT,
  finish_time TEXT,
  photo_urls JSONB DEFAULT '[]'::jsonb
);
```

**Note on `checklist`**: This is a JSONB array of objects with `text` and `checked` fields. Example:
```json
[
  {"text": "Check belt tension", "checked": false},
  {"text": "Inspect coils for fouling", "checked": false},
  {"text": "Test motor amp draw", "checked": false}
]
```

### Work Requests

```sql
CREATE TABLE public.work_requests (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  equipment TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  urgency TEXT NOT NULL DEFAULT 'medium',
  submitter TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'pending',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

### Audit Log

```sql
CREATE TABLE public.audit_log (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  details JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

### Auto-update timestamps

```sql
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.equipment FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.work_orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.parts_inventory FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.breakdowns FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.calendar_events FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.purchase_orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.permits FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.pm_tasks FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.work_requests FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
```

### Performance indexes

```sql
CREATE INDEX idx_work_orders_status ON public.work_orders(status);
CREATE INDEX idx_work_orders_assigned ON public.work_orders(assigned_to);
CREATE INDEX idx_breakdowns_equipment ON public.breakdowns(equipment_id);
CREATE INDEX idx_pm_tasks_due_date ON public.pm_tasks(next_due_date);
CREATE INDEX idx_equipment_status ON public.equipment(status);
```

After running all of the above, click **Table Editor** in the left sidebar — you'll see all 14 tables listed:

`profiles`, `equipment`, `work_orders`, `parts_inventory`, `parts_usage`, `breakdowns`, `calendar_events`, `purchase_orders`, `po_line_items`, `permits`, `pm_tasks`, `pm_completions`, `work_requests`, `audit_log`

---

## Step 8: Set Up Security (Row Level Security)

Without this, anyone with your API key could read and write every row in every table. RLS locks it down so users can only do what their role and tier allow.

Paste this in the SQL Editor and click Run:

```sql
-- ============================================================================
-- 1. ENABLE RLS ON ALL TABLES
-- ============================================================================

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.work_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.parts_inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.parts_usage ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.breakdowns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.calendar_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.purchase_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.po_line_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.permits ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pm_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pm_completions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.work_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_log ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- 2. HELPER FUNCTIONS
-- ============================================================================

-- Get current user's role from profiles
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS TEXT AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Get current user's tier from profiles
CREATE OR REPLACE FUNCTION public.get_my_tier()
RETURNS TEXT AS $$
  SELECT COALESCE(tier, 'essential') FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ============================================================================
-- 3. PROFILES
-- ============================================================================

-- Pending users can read ONLY their own profile (to check their role/status)
CREATE POLICY "Pending users can read own profile"
  ON public.profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Active (non-pending) users can view all profiles (employee directory)
CREATE POLICY "Active users can view profiles"
  ON public.profiles FOR SELECT
  TO authenticated
  USING (public.get_my_role() != 'pending');

-- Users can update their own profile (name, phone, etc.)
CREATE POLICY "Users can update own profile"
  ON public.profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Admins can update any profile (role changes, tier changes)
CREATE POLICY "Admins update any profile"
  ON public.profiles FOR UPDATE
  TO authenticated
  USING (public.get_my_role() = 'admin')
  WITH CHECK (public.get_my_role() = 'admin');

-- ============================================================================
-- 4. EQUIPMENT
-- ============================================================================

CREATE POLICY "View equipment"
  ON public.equipment FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Staff create equipment"
  ON public.equipment FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Staff update equipment"
  ON public.equipment FOR UPDATE TO authenticated
  USING (public.get_my_role() IN ('engineer', 'manager', 'admin'))
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Admins delete equipment"
  ON public.equipment FOR DELETE TO authenticated
  USING (public.get_my_role() = 'admin');

-- ============================================================================
-- 5. WORK ORDERS
-- ============================================================================

CREATE POLICY "View work orders"
  ON public.work_orders FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Staff create work orders"
  ON public.work_orders FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Managers or assigned update work orders"
  ON public.work_orders FOR UPDATE TO authenticated
  USING (public.get_my_role() IN ('manager', 'admin', 'engineer'))
  WITH CHECK (public.get_my_role() IN ('manager', 'admin', 'engineer'));

CREATE POLICY "Staff delete work orders"
  ON public.work_orders FOR DELETE TO authenticated
  USING (public.get_my_role() IN ('manager', 'admin'));

-- ============================================================================
-- 6. PARTS INVENTORY (Pro-only data, but RLS allows read for all)
-- ============================================================================

CREATE POLICY "View parts"
  ON public.parts_inventory FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Staff manage parts"
  ON public.parts_inventory FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Staff update parts"
  ON public.parts_inventory FOR UPDATE TO authenticated
  USING (public.get_my_role() IN ('engineer', 'manager', 'admin'))
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Admins delete parts"
  ON public.parts_inventory FOR DELETE TO authenticated
  USING (public.get_my_role() = 'admin');

-- ============================================================================
-- 7. PARTS USAGE
-- ============================================================================

CREATE POLICY "View parts usage"
  ON public.parts_usage FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Staff log parts usage"
  ON public.parts_usage FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Staff delete parts usage"
  ON public.parts_usage FOR DELETE TO authenticated
  USING (public.get_my_role() IN ('engineer', 'manager', 'admin'));

-- ============================================================================
-- 8. BREAKDOWNS
-- ============================================================================

CREATE POLICY "View breakdowns"
  ON public.breakdowns FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Anyone report breakdowns"
  ON public.breakdowns FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() != 'pending');

CREATE POLICY "Staff update breakdowns"
  ON public.breakdowns FOR UPDATE TO authenticated
  USING (public.get_my_role() IN ('engineer', 'manager', 'admin'))
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Staff delete breakdowns"
  ON public.breakdowns FOR DELETE TO authenticated
  USING (public.get_my_role() IN ('manager', 'admin'));

-- ============================================================================
-- 9. CALENDAR EVENTS (Pro-only)
-- ============================================================================

CREATE POLICY "View calendar"
  ON public.calendar_events FOR SELECT TO authenticated
  USING (
    public.get_my_role() != 'pending'
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Staff create events"
  ON public.calendar_events FOR INSERT TO authenticated
  WITH CHECK (
    public.get_my_role() IN ('engineer', 'manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Creator or managers update events"
  ON public.calendar_events FOR UPDATE TO authenticated
  USING (
    public.get_my_tier() = 'pro'
    AND (auth.uid()::text = created_by OR public.get_my_role() IN ('manager', 'admin'))
  )
  WITH CHECK (
    public.get_my_tier() = 'pro'
    AND (auth.uid()::text = created_by OR public.get_my_role() IN ('manager', 'admin'))
  );

CREATE POLICY "Managers delete events"
  ON public.calendar_events FOR DELETE TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

-- ============================================================================
-- 10. PURCHASE ORDERS (Pro-only)
-- ============================================================================

CREATE POLICY "View POs"
  ON public.purchase_orders FOR SELECT TO authenticated
  USING (
    public.get_my_role() != 'pending'
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Staff create POs"
  ON public.purchase_orders FOR INSERT TO authenticated
  WITH CHECK (
    public.get_my_role() IN ('engineer', 'manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Managers update POs"
  ON public.purchase_orders FOR UPDATE TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  )
  WITH CHECK (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Staff delete POs"
  ON public.purchase_orders FOR DELETE TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

-- PO LINE ITEMS (follows purchase_orders access)

CREATE POLICY "View PO items"
  ON public.po_line_items FOR SELECT TO authenticated
  USING (
    public.get_my_role() != 'pending'
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Staff create PO items"
  ON public.po_line_items FOR INSERT TO authenticated
  WITH CHECK (
    public.get_my_role() IN ('engineer', 'manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Managers update PO items"
  ON public.po_line_items FOR UPDATE TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  )
  WITH CHECK (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Managers delete PO items"
  ON public.po_line_items FOR DELETE TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

-- ============================================================================
-- 11. PERMITS (Pro-only)
-- ============================================================================

CREATE POLICY "View permits"
  ON public.permits FOR SELECT TO authenticated
  USING (
    public.get_my_role() != 'pending'
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Staff create permits"
  ON public.permits FOR INSERT TO authenticated
  WITH CHECK (
    public.get_my_role() IN ('engineer', 'manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

CREATE POLICY "Managers update permits"
  ON public.permits FOR UPDATE TO authenticated
  USING (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  )
  WITH CHECK (
    public.get_my_role() IN ('manager', 'admin')
    AND public.get_my_tier() = 'pro'
  );

-- ============================================================================
-- 12. PM TASKS & COMPLETIONS
-- ============================================================================

CREATE POLICY "View PM tasks"
  ON public.pm_tasks FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Staff create PM tasks"
  ON public.pm_tasks FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

CREATE POLICY "Managers or assigned update PM tasks"
  ON public.pm_tasks FOR UPDATE TO authenticated
  USING (public.get_my_role() IN ('manager', 'admin', 'engineer'))
  WITH CHECK (public.get_my_role() IN ('manager', 'admin', 'engineer'));

CREATE POLICY "Staff delete PM tasks"
  ON public.pm_tasks FOR DELETE TO authenticated
  USING (public.get_my_role() IN ('manager', 'admin'));

CREATE POLICY "View PM completions"
  ON public.pm_completions FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Staff log PM completions"
  ON public.pm_completions FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

-- ============================================================================
-- 13. WORK REQUESTS
-- ============================================================================

CREATE POLICY "View work requests"
  ON public.work_requests FOR SELECT TO authenticated
  USING (public.get_my_role() != 'pending');

CREATE POLICY "Submit work requests"
  ON public.work_requests FOR INSERT TO authenticated
  WITH CHECK (public.get_my_role() != 'pending');

CREATE POLICY "Managers approve work requests"
  ON public.work_requests FOR UPDATE TO authenticated
  USING (public.get_my_role() IN ('manager', 'admin'))
  WITH CHECK (public.get_my_role() IN ('manager', 'admin'));

-- ============================================================================
-- 14. AUDIT LOG
-- ============================================================================

-- Any authenticated user can insert audit entries (for their own user_id)
CREATE POLICY "Insert audit entries"
  ON public.audit_log FOR INSERT TO authenticated
  WITH CHECK (user_id = auth.uid());

-- Only admins can read audit log
CREATE POLICY "Admins read audit log"
  ON public.audit_log FOR SELECT TO authenticated
  USING (public.get_my_role() = 'admin');
```

### Who can do what:

| Action | Production | Engineer | Manager | Admin |
|--------|-----------|----------|---------|-------|
| View data (within tier) | Work Requests only | Yes | Yes | Yes |
| Submit work requests | Yes | Yes | Yes | Yes |
| Create work orders / equipment | No | Yes | Yes | Yes |
| Update own work orders | No | Yes | Yes | Yes |
| Log breakdowns | No | Yes | Yes | Yes |
| Approve permits | No | No | Yes | Yes |
| Approve purchase orders | No | No | Yes | Yes |
| Approve work requests | No | No | Yes | Yes |
| Delete records | No | No | Yes | Yes |
| Delete equipment | No | No | No | Yes |
| Change user roles / tiers | No | No | No | Yes |
| View audit trail | No | No | No | Yes |

---

## Step 9: Set Up User Login (Authentication)

### Configure login in Supabase:

1. Click **Authentication** in the left sidebar
2. Click **Providers** under Configuration
3. Verify **Email** is toggled ON (should be by default)

### Create your first admin user:

4. Click **Authentication** → **Users** tab
5. Click **Add user** → **Create new user**
6. Enter your email and a strong password
7. Tick **Auto Confirm User**
8. Click **Create user**
9. Copy the user's **UUID** from the table

### Make yourself an admin and set your tier:

10. Go to **SQL Editor** → New query → paste this (replace the UUID and name):

```sql
UPDATE public.profiles
SET role = 'admin', tier = 'pro', full_name = 'Your Name Here'
WHERE id = 'paste-your-uuid-here';
```

11. Click **Run**

You now have an admin account on the Pro tier with full access to everything.

### How new users work:

- When someone signs up, their profile is created with `role = 'pending'`
- Pending users see a "waiting for approval" screen — they cannot access any data
- Cradero approves new users by changing their role in the Supabase dashboard (per-user billing)
- Cradero also sets their `tier` to `essential` or `pro` based on the customer's subscription
- Once approved, the customer's admin can change roles between engineer/manager/admin/production using the in-app **User Management** tab

---

## Step 10: Connect Your Frontend to Supabase

Cradero uses a separate `config.js` file to store Supabase credentials. This keeps secrets out of the main `index.html`.

### Edit `config.js`:

Open `config.js` and replace the placeholder values with your real Supabase project URL and anon key:

```javascript
// Cradero Configuration
window.CRADERO_CONFIG = {
    SUPABASE_URL: 'https://your-project-id.supabase.co',
    SUPABASE_ANON_KEY: 'eyJ...your-anon-key-here'
};
```

### Push to GitHub:

Commit and push `config.js` to your repository. Vercel will auto-deploy.

**Important**: The `index.html` already includes `<script src="config.js"></script>` and the Supabase JS SDK. You do not need to edit `index.html`.

The app will read `CRADERO_CONFIG.SUPABASE_URL` and `CRADERO_CONFIG.SUPABASE_ANON_KEY` on page load and initialise the Supabase client automatically.

---

## Step 11: Create Storage Buckets (Photo & Document Uploads)

Cradero uses Supabase Storage for file uploads. You need to create three storage buckets.

### In the Supabase dashboard:

1. Click **Storage** in the left sidebar
2. Click **New bucket** and create these three buckets:

| Bucket Name | Public? | Description |
|-------------|---------|-------------|
| `work-order-photos` | Yes | Photos attached to work orders |
| `equipment-sops` | Yes | SOP documents attached to equipment (Pro only) |
| `equipment-manuals` | Yes | Manufacturer manuals attached to equipment (Pro only) |

3. For each bucket, set it to **Public** so authenticated users can view uploaded files

### Set up storage policies:

4. Click on each bucket → **Policies** tab → **New policy** → **For full customization**

For all three buckets, create these policies:

**Allow authenticated uploads:**
```sql
CREATE POLICY "Authenticated users can upload"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'work-order-photos');
```

**Allow public reads:**
```sql
CREATE POLICY "Public read access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'work-order-photos');
```

Repeat for `equipment-sops` and `equipment-manuals` buckets (change the `bucket_id` value in each policy).

### File upload details:

- **Work order photos**: Uploaded during WO creation or from the WO detail view. Supports drag & drop, multiple files. Max 10MB per file. Stored as `{wo-id}/{uuid}-{filename}`
- **Equipment SOPs**: PDF, Word, and image files. Uploaded via the Equipment Edit modal (Pro tier only). Stored in `sop_urls` JSONB column on equipment
- **Equipment manuals**: Same format as SOPs. Stored in `manual_urls` JSONB column on equipment
- **PM completion photos**: Managers/admins can attach photos when completing a PM task. Stored in `pm_completions.photo_urls`

The app validates file types and enforces a 10MB size limit. It also detects suspicious double-extension filenames (e.g. `photo.jpg.exe`).

---

# Part C — Security & API Keys

### What's safe to put in your website code:

| Key | Safe for frontend? | Why |
|-----|-------------------|-----|
| Project URL | Yes | It's public anyway |
| anon key | Yes | Can only do what RLS allows |
| service_role key | **NEVER** | Bypasses ALL security |

The `anon` key is safe in frontend code **because** of the Row Level Security policies you set up in Step 8. Without RLS, the anon key would be dangerous.

### Key safety rules:

1. **Never** put the `service_role` key in any frontend file
2. If you accidentally expose it, go to Settings → API in Supabase and regenerate it immediately
3. Credentials are stored in `config.js` — if using a public repo, consider making the repo private or using Vercel environment variables instead

### Additional security features built into Cradero:

- **Session timeout**: Users are automatically logged out after 30 minutes of inactivity (warning at 25 minutes)
- **Login rate limiting**: 5 failed login attempts triggers a 30-second client-side lockout
- **Pending user gate**: New sign-ups cannot access any data until an admin approves them
- **Content Security Policy**: CSP headers restrict script sources to `self` and approved CDNs
- **File upload validation**: Type checking, 10MB max size, double-extension detection
- **Service worker logout**: On logout, the service worker clears all cached data

---

# Part D — Free Tier Limits & When to Upgrade

### Supabase Free Tier:

| Resource | Limit |
|----------|-------|
| Database size | 500 MB |
| File storage | 1 GB |
| Monthly data transfer | 5 GB |
| Auth users | 50,000 monthly active |
| Realtime connections | 200 concurrent |
| Active projects | 2 |
| **Inactivity pause** | **Pauses after 7 days of no use** |

**In practice**: 500 MB is enough for tens of thousands of work orders. A factory with 50 engineers won't hit this for years. The inactivity pause is the main thing — if nobody uses the app for 7 days, the database pauses. Next request wakes it up but takes a few seconds. For a daily-use maintenance app, this won't happen.

**Storage note**: The 1 GB storage limit covers work order photos, SOPs, and manuals. If photo uploads are heavy, consider the Pro plan earlier.

### Vercel Free Tier:

| Resource | Limit |
|----------|-------|
| Bandwidth | 100 GB/month |
| Deployments | Unlimited |
| Custom domains | Unlimited |
| HTTPS | Included |

### When to upgrade:

- **Supabase Pro**: $25/month — no pausing, daily backups, 8 GB database, 100 GB storage
- **Vercel Pro**: $20/month — more bandwidth, team features

Upgrading is seamless — click a button in the dashboard, no migration needed.

---

# Part E — Roles, Tiers & Permissions

### Managing user roles (in-app):

Customer admins can manage user roles directly from the **User Management** tab in the app:

- Navigate to **User Management** (visible to admins only)
- See all users in a table with their name, email, department, and current role
- Use the dropdown to change an active user's role between: `engineer`, `manager`, `admin`, `production`
- Click **Save** to apply the change

**What admins cannot do:**
- **Approve pending users** — new sign-ups start as `pending` and are shown as "Pending — Contact Cradero". Only Cradero can approve new users (per-user billing)
- **Change subscription tiers** — the `tier` column (`essential` / `pro`) is managed by Cradero via the Supabase dashboard
- **Demote themselves** — the currently logged-in admin cannot change their own role (prevents lockouts)

### Approving new users and setting tiers (Cradero admin via Supabase):

When a new user signs up and needs to be activated:

1. Go to **Table Editor** → **profiles** in the Supabase dashboard
2. Find the user's row (role will be `pending`)
3. Change `role` from `pending` to one of: `engineer`, `manager`, `admin`, or `production`
4. Set `tier` to `essential` or `pro` based on the customer's subscription

### Tier module access:

| Module | Essential | Pro |
|--------|-----------|-----|
| Work Orders | Yes | Yes |
| Equipment | Yes | Yes |
| Preventive Maintenance | Yes | Yes |
| Reactive Maintenance | Yes | Yes |
| Work Requests | Yes | Yes |
| Permits | Yes | Yes |
| Daily Activity Log | Yes | Yes |
| My Tasks | Yes | Yes |
| Audit Trail | Yes | Yes |
| Parts Inventory | No | Yes |
| Purchase Orders | No | Yes |
| Analytics & Reports | No | Yes |
| Maintenance Calendar | No | Yes |
| QR Codes | No | Yes |
| PDF Export | No | Yes |
| Dark Mode | No | Yes |
| Offline / PWA | No | Yes |

### The Production role:

The `production` role is a special limited role for production floor staff. Users with this role can **only** see the Work Requests tab. They can submit new work requests but cannot access any other module. This lets shop floor workers report issues without giving them access to the full CMMS.

---

# Part F — Seeding Demo Data (Optional)

If you want to populate the database with realistic demo data for testing or demonstrations, use the seed migration.

1. Go to **SQL Editor** in Supabase
2. **Important**: Make sure you have at least one admin user created (Step 9) — the seed script requires it
3. Copy and paste the contents of `migrations/003_seed_demo_data.sql` and click **Run**

This creates:
- 10 equipment items (boilers, chillers, AHUs, generator, fire pump, elevator, compressor)
- 8 work orders across various priorities and statuses
- 15 parts inventory items with realistic part numbers
- 8 preventive maintenance tasks with varying frequencies
- 4 purchase orders in different statuses
- 4 permits (hot work and contractor)
- 4 breakdowns with root cause analysis
- 6 calendar events
- 5 work requests from different submitters

---

# Part G — Resetting for a New Customer

When onboarding a new customer on a fresh Supabase project, or if you need to clear demo data:

1. Go to **SQL Editor** in Supabase
2. Copy and paste the contents of `migrations/004_reset_for_new_customer.sql` and click **Run**

This deletes all data from every table **except profiles** — the customer's admin account stays intact. Identity sequences are reset so IDs start fresh.

**WARNING**: This deletes ALL data permanently. Only run this on a fresh customer project or when you intentionally want to wipe everything.

---

# Part H — Running Migrations on Existing Deployments

If you have an existing deployment and need to update the database schema to match the latest frontend code, run the migration files in order. These are in the `migrations/` folder.

### Migration order:

| File | What it does |
|------|-------------|
| `001_add_missing_columns.sql` | Adds new columns to existing tables (wo_number, equipment_code, criticality, warranty fields, fault_cause, etc.) and creates the `work_requests` and `audit_log` tables |
| `002_enable_rls.sql` | Drops and recreates all RLS policies with tier-awareness, adds the `tier` column to profiles, creates `get_my_tier()` helper function |
| `003_seed_demo_data.sql` | (Optional) Inserts demo data for testing |
| `004_reset_for_new_customer.sql` | (Optional) Clears all data for a fresh start |
| `005_fix_assigned_to_text.sql` | Changes `assigned_to`, `requested_by`, `created_by` columns from UUID to TEXT so the app can store engineer names directly |

### How to run:

1. Go to **SQL Editor** in Supabase
2. Open each migration file, copy its contents, paste into the editor
3. Click **Run**
4. Run them in order: 001, 002, then 005 (003 and 004 are optional)

**Important**: If deploying from scratch (Step 7), you do NOT need to run these migrations — the table definitions in Step 7 already include all the latest columns and types.

---

# Part I — Next Steps

Once everything is running:

1. **Test security**: Log in as different roles and tiers — check that pending users are blocked, production users only see Work Requests, and Essential users don't see Pro modules
2. **Import customer data**: Use the CSV import feature (managers/admins) to bulk-load equipment, parts, and PM schedules from spreadsheets. Sample CSV templates are provided: `sample-equipment.csv`, `sample-parts.csv`, `sample-pm.csv`
3. **Enable Realtime**: Add Supabase Realtime subscriptions so dashboards refresh live when someone logs a breakdown (no page refresh needed)
4. **Email notifications**: Use Supabase Edge Functions to send email when a high-priority breakdown is logged
5. **Data backups**: On Pro plan, automatic daily backups. On free tier, manually export via the dashboard
6. **Multiple factories**: Add an `organisation_id` column to tables and update RLS policies to isolate data per factory

### Useful links:

- Supabase docs: https://supabase.com/docs
- Vercel docs: https://vercel.com/docs
- Cloudflare registrar: https://dash.cloudflare.com
- GitHub docs: https://docs.github.com

---

**Total cost to get started: ~£7.50/year for the domain. Everything else is free.**
