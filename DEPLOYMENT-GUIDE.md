# Cradero — Complete Deployment & Backend Guide

This guide takes you from zero to a fully live, secure maintenance management app.
No coding experience required. Every step is explained.

---

## Table of Contents

1. [Overview & Costs](#1-overview--costs)
2. [Part A — Get Your Site Live](#part-a--get-your-site-live)
   - [Step 1: Create a GitHub Account](#step-1-create-a-github-account)
   - [Step 2: Create a Repository & Upload Your Files](#step-2-create-a-repository--upload-your-files)
   - [Step 3: Deploy to Vercel (Free)](#step-3-deploy-to-vercel-free)
   - [Step 4: Buy a Domain](#step-4-buy-a-domain)
   - [Step 5: Connect Your Domain to Vercel](#step-5-connect-your-domain-to-vercel)
3. [Part B — Build the Backend with Supabase](#part-b--build-the-backend-with-supabase)
   - [Step 6: Create a Supabase Project](#step-6-create-a-supabase-project)
   - [Step 7: Create Database Tables](#step-7-create-database-tables)
   - [Step 8: Set Up Security (Row Level Security)](#step-8-set-up-security-row-level-security)
   - [Step 9: Set Up User Login (Authentication)](#step-9-set-up-user-login-authentication)
   - [Step 10: Connect Your Frontend to Supabase](#step-10-connect-your-frontend-to-supabase)
4. [Part C — Security & API Keys](#part-c--security--api-keys)
5. [Part D — Free Tier Limits & When to Upgrade](#part-d--free-tier-limits--when-to-upgrade)
6. [Part E — Next Steps](#part-e--next-steps)

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

### Upload your HTML file:

4. In your new repo, click **Add file** → **Upload files**
5. **Important**: First, rename your file from `cradero-complete (3).html` to `index.html`
   - On your Mac: right-click the file in Finder → Rename → type `index.html`
   - Vercel needs this exact name to know it's your homepage
6. Drag `index.html` into the upload area on GitHub
7. At the bottom, type a message like `Add website files` and click **Commit changes**

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

Supabase gives you three things without writing server code:
- **A database** (PostgreSQL) — where all your data lives permanently
- **Authentication** — user login/logout, passwords, sessions
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
  role TEXT NOT NULL CHECK (role IN ('engineer', 'manager', 'admin', 'viewer')),
  department TEXT,
  phone TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Auto-create a profile when someone signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(NEW.raw_user_meta_data->>'role', 'engineer')
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
  location TEXT,
  serial_number TEXT,
  manufacturer TEXT,
  model TEXT,
  install_date DATE,
  status TEXT DEFAULT 'operational'
    CHECK (status IN ('operational', 'down', 'maintenance', 'decommissioned')),
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
  title TEXT NOT NULL,
  description TEXT,
  equipment_id UUID REFERENCES public.equipment(id),
  priority TEXT DEFAULT 'medium'
    CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  status TEXT DEFAULT 'open'
    CHECK (status IN ('open', 'in_progress', 'on_hold', 'completed', 'cancelled')),
  assigned_to UUID REFERENCES public.profiles(id),
  requested_by UUID REFERENCES public.profiles(id),
  due_date DATE,
  completed_at TIMESTAMPTZ,
  estimated_hours NUMERIC(5,1),
  actual_hours NUMERIC(5,1),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
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
  supplier TEXT,
  equipment_id UUID REFERENCES public.equipment(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### Breakdowns (Reactive Maintenance)

```sql
CREATE TABLE public.breakdowns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  equipment_id UUID NOT NULL REFERENCES public.equipment(id),
  reported_by UUID REFERENCES public.profiles(id),
  title TEXT NOT NULL,
  description TEXT,
  severity TEXT DEFAULT 'medium'
    CHECK (severity IN ('low', 'medium', 'high', 'critical')),
  status TEXT DEFAULT 'reported'
    CHECK (status IN ('reported', 'investigating', 'repair_in_progress', 'resolved')),
  work_order_id UUID REFERENCES public.work_orders(id),
  downtime_started TIMESTAMPTZ DEFAULT now(),
  downtime_ended TIMESTAMPTZ,
  root_cause TEXT,
  resolution TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

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
  assigned_to UUID REFERENCES public.profiles(id),
  equipment_id UUID REFERENCES public.equipment(id),
  work_order_id UUID REFERENCES public.work_orders(id),
  recurrence_rule TEXT,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### Purchase Orders

```sql
CREATE TABLE public.purchase_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  po_number TEXT UNIQUE NOT NULL,
  supplier TEXT NOT NULL,
  status TEXT DEFAULT 'draft'
    CHECK (status IN ('draft', 'submitted', 'approved', 'ordered', 'received', 'cancelled')),
  requested_by UUID REFERENCES public.profiles(id),
  approved_by UUID REFERENCES public.profiles(id),
  total_cost NUMERIC(12,2),
  notes TEXT,
  order_date DATE,
  expected_delivery DATE,
  actual_delivery DATE,
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
    CHECK (status IN ('draft', 'pending_approval', 'approved', 'active', 'expired', 'revoked')),
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
  frequency TEXT NOT NULL
    CHECK (frequency IN ('daily', 'weekly', 'biweekly', 'monthly', 'quarterly', 'semi_annual', 'annual')),
  assigned_to UUID REFERENCES public.profiles(id),
  last_completed_at TIMESTAMPTZ,
  next_due_date DATE,
  estimated_hours NUMERIC(5,1),
  checklist JSONB,
  is_active BOOLEAN DEFAULT true,
  created_by UUID REFERENCES public.profiles(id),
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
  work_order_id UUID REFERENCES public.work_orders(id)
);
```

### Auto-update timestamps (recommended)

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
```

### Performance indexes

```sql
CREATE INDEX idx_work_orders_status ON public.work_orders(status);
CREATE INDEX idx_work_orders_assigned ON public.work_orders(assigned_to);
CREATE INDEX idx_breakdowns_equipment ON public.breakdowns(equipment_id);
CREATE INDEX idx_pm_tasks_due_date ON public.pm_tasks(next_due_date);
CREATE INDEX idx_equipment_status ON public.equipment(status);
```

After running all of the above, click **Table Editor** in the left sidebar — you'll see all your tables listed like a spreadsheet.

---

## Step 8: Set Up Security (Row Level Security)

Without this, anyone with your API key could read and write every row in every table. RLS locks it down so users can only do what their role allows.

Paste this in the SQL Editor and click Run:

```sql
-- Enable RLS on every table
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.work_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.parts_inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.breakdowns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.calendar_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.purchase_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.po_line_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.permits ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pm_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pm_completions ENABLE ROW LEVEL SECURITY;

-- Helper: get current user's role
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS TEXT AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- PROFILES
CREATE POLICY "Anyone can view profiles" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id) WITH CHECK (auth.uid() = id);
CREATE POLICY "Admins can update any profile" ON public.profiles FOR UPDATE USING (public.get_my_role() = 'admin') WITH CHECK (public.get_my_role() = 'admin');

-- EQUIPMENT
CREATE POLICY "View equipment" ON public.equipment FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create equipment" ON public.equipment FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Staff update equipment" ON public.equipment FOR UPDATE TO authenticated USING (public.get_my_role() IN ('engineer', 'manager', 'admin')) WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Admins delete equipment" ON public.equipment FOR DELETE TO authenticated USING (public.get_my_role() = 'admin');

-- WORK ORDERS
CREATE POLICY "View work orders" ON public.work_orders FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create work orders" ON public.work_orders FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Assigned or managers update work orders" ON public.work_orders FOR UPDATE TO authenticated USING (auth.uid() = assigned_to OR public.get_my_role() IN ('manager', 'admin')) WITH CHECK (auth.uid() = assigned_to OR public.get_my_role() IN ('manager', 'admin'));

-- PARTS
CREATE POLICY "View parts" ON public.parts_inventory FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff manage parts" ON public.parts_inventory FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Staff update parts" ON public.parts_inventory FOR UPDATE TO authenticated USING (public.get_my_role() IN ('engineer', 'manager', 'admin')) WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

-- BREAKDOWNS
CREATE POLICY "View breakdowns" ON public.breakdowns FOR SELECT TO authenticated USING (true);
CREATE POLICY "Anyone report breakdowns" ON public.breakdowns FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Staff update breakdowns" ON public.breakdowns FOR UPDATE TO authenticated USING (public.get_my_role() IN ('engineer', 'manager', 'admin')) WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));

-- CALENDAR EVENTS
CREATE POLICY "View calendar" ON public.calendar_events FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create events" ON public.calendar_events FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Creator or managers update events" ON public.calendar_events FOR UPDATE TO authenticated USING (auth.uid() = created_by OR public.get_my_role() IN ('manager', 'admin')) WITH CHECK (auth.uid() = created_by OR public.get_my_role() IN ('manager', 'admin'));
CREATE POLICY "Managers delete events" ON public.calendar_events FOR DELETE TO authenticated USING (public.get_my_role() IN ('manager', 'admin'));

-- PURCHASE ORDERS
CREATE POLICY "View POs" ON public.purchase_orders FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create POs" ON public.purchase_orders FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Managers update POs" ON public.purchase_orders FOR UPDATE TO authenticated USING (public.get_my_role() IN ('manager', 'admin')) WITH CHECK (public.get_my_role() IN ('manager', 'admin'));
CREATE POLICY "View PO items" ON public.po_line_items FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create PO items" ON public.po_line_items FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Managers update PO items" ON public.po_line_items FOR UPDATE TO authenticated USING (public.get_my_role() IN ('manager', 'admin')) WITH CHECK (public.get_my_role() IN ('manager', 'admin'));
CREATE POLICY "Managers delete PO items" ON public.po_line_items FOR DELETE TO authenticated USING (public.get_my_role() IN ('manager', 'admin'));

-- PERMITS
CREATE POLICY "View permits" ON public.permits FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create permits" ON public.permits FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Managers update permits" ON public.permits FOR UPDATE TO authenticated USING (public.get_my_role() IN ('manager', 'admin')) WITH CHECK (public.get_my_role() IN ('manager', 'admin'));

-- PM TASKS
CREATE POLICY "View PM tasks" ON public.pm_tasks FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff create PM tasks" ON public.pm_tasks FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
CREATE POLICY "Assigned or managers update PM tasks" ON public.pm_tasks FOR UPDATE TO authenticated USING (auth.uid() = assigned_to OR public.get_my_role() IN ('manager', 'admin')) WITH CHECK (auth.uid() = assigned_to OR public.get_my_role() IN ('manager', 'admin'));
CREATE POLICY "View PM completions" ON public.pm_completions FOR SELECT TO authenticated USING (true);
CREATE POLICY "Staff log PM completions" ON public.pm_completions FOR INSERT TO authenticated WITH CHECK (public.get_my_role() IN ('engineer', 'manager', 'admin'));
```

### Who can do what:

| Action | Viewer | Engineer | Manager | Admin |
|--------|--------|----------|---------|-------|
| View all data | Yes | Yes | Yes | Yes |
| Create work orders | No | Yes | Yes | Yes |
| Update own work orders | No | Yes | Yes | Yes |
| Approve permits | No | No | Yes | Yes |
| Approve purchase orders | No | No | Yes | Yes |
| Delete equipment | No | No | No | Yes |
| Change user roles | No | No | No | Yes |

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

### Make yourself an admin:

10. Go to **SQL Editor** → New query → paste this (replace the UUID):

```sql
UPDATE public.profiles
SET role = 'admin', full_name = 'Your Name Here'
WHERE id = 'paste-your-uuid-here';
```

11. Click **Run**

You now have an admin account that can manage everything.

---

## Step 10: Connect Your Frontend to Supabase

### Add the Supabase library to your HTML:

In the `<head>` section of your `index.html`, add this line:

```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
```

### Initialise the client:

Add this at the top of your `<script>` section:

```javascript
// Replace with YOUR values from Supabase Settings > API
const SUPABASE_URL = 'https://your-project-id.supabase.co';
const SUPABASE_ANON_KEY = 'eyJ...your-anon-key-here';
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```

### Sign up a new user:

```javascript
async function signUp(email, password, fullName, role) {
  const { data, error } = await supabase.auth.signUp({
    email: email,
    password: password,
    options: {
      data: { full_name: fullName, role: role }
    }
  });
  if (error) { showToast('Sign up failed: ' + error.message, 'error'); return null; }
  showToast('Account created! Check email to confirm.', 'success');
  return data;
}
```

### Log in:

```javascript
async function logIn(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: email, password: password
  });
  if (error) { showToast('Login failed: ' + error.message, 'error'); return null; }
  return data;
}
```

### Log out:

```javascript
async function logOut() {
  await supabase.auth.signOut();
  window.location.href = '/login.html';
}
```

### Protect pages (redirect if not logged in):

```javascript
async function requireAuth() {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) { window.location.href = '/login.html'; return null; }
  return session;
}
// Call on page load:
requireAuth();
```

### Example: Fetch all work orders from the database:

```javascript
async function getWorkOrders() {
  const { data, error } = await supabase
    .from('work_orders')
    .select('*, equipment:equipment_id(name), assigned:assigned_to(full_name)')
    .order('created_at', { ascending: false });
  if (error) { console.error(error.message); return []; }
  return data;
}
```

### Example: Create a new work order:

```javascript
async function createWorkOrder(title, description, equipmentId, priority, assignedTo) {
  const { data: { user } } = await supabase.auth.getUser();
  const { data, error } = await supabase
    .from('work_orders')
    .insert({
      title, description,
      equipment_id: equipmentId,
      priority, assigned_to: assignedTo,
      requested_by: user.id
    })
    .select().single();
  if (error) { showToast('Failed: ' + error.message, 'error'); return null; }
  showToast('Work order created!', 'success');
  return data;
}
```

### Example: Report a breakdown:

```javascript
async function reportBreakdown(equipmentId, title, description, severity) {
  const { data: { user } } = await supabase.auth.getUser();
  const { data, error } = await supabase
    .from('breakdowns')
    .insert({
      equipment_id: equipmentId,
      reported_by: user.id,
      title, description, severity
    })
    .select().single();
  if (error) { showToast('Failed: ' + error.message, 'error'); return null; }
  // Also mark equipment as down
  await supabase.from('equipment').update({ status: 'down' }).eq('id', equipmentId);
  return data;
}
```

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
3. When you eventually use a build tool, store keys in a `.env` file and add it to `.gitignore`

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

### Vercel Free Tier:

| Resource | Limit |
|----------|-------|
| Bandwidth | 100 GB/month |
| Deployments | Unlimited |
| Custom domains | Unlimited |
| HTTPS | Included |

### When to upgrade:

- **Supabase Pro**: $25/month — no pausing, daily backups, 8 GB database
- **Vercel Pro**: $20/month — more bandwidth, team features

Upgrading is seamless — click a button in the dashboard, no migration needed.

---

# Part E — Next Steps

Once everything is running:

1. **Test security**: Log in as different roles and check they can only do what's allowed
2. **Add photo uploads**: Use Supabase Storage for attaching photos to work orders and breakdowns
3. **Enable Realtime**: Live updates so dashboards refresh when someone logs a breakdown (no page refresh needed)
4. **Mobile responsiveness**: The current CSS has some responsive styles — test on phones/tablets
5. **Email notifications**: Use Supabase Edge Functions to send email when a high-priority breakdown is logged
6. **Data backups**: On Pro plan, automatic daily backups. On free tier, manually export via the dashboard
7. **Multiple factories**: Add an `organisation_id` column to tables and update RLS policies to isolate data per factory

### Useful links:

- Supabase docs: https://supabase.com/docs
- Vercel docs: https://vercel.com/docs
- Cloudflare registrar: https://dash.cloudflare.com
- GitHub docs: https://docs.github.com

---

**Total cost to get started: ~£7.50/year for the domain. Everything else is free.**
