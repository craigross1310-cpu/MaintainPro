# Cradero - Complete Maintenance Management Software

## Feature Overview & Product Guide

**Prepared for:** Engineering Team Meeting
**Date:** February 2026
**Version:** 1.0

---

## What is Cradero?

Cradero is a web-based maintenance management system (CMMS) designed for manufacturing and production environments. It centralises work order management, equipment tracking, preventive maintenance scheduling, parts inventory, reactive breakdown logging, and reporting into a single application.

The software is available in two tiers: **Essential** and **Pro**.

---

## Essential Tier Features

### 1. Work Order Management

- **Create, edit, and delete** work orders with full detail capture
- **Priority levels** — High, Medium, Low — with visual colour coding
- **Status tracking** — Open, In Progress, On Hold, Completed
- **Engineer assignment** — assign or reassign to any team member
- **Photo attachments** — drag-and-drop image upload with preview
- **Comments thread** — timestamped comments from any team member on each work order
- **Time tracking** — start time, finish time, auto-calculated total job time
- **Machine downtime logging** — record downtime per work order
- **Search** — full-text search across all work orders

### 2. Equipment Asset Management

- **Full equipment register** — name, ID, manufacturer, model, location, install date
- **Criticality ratings** — A (Critical), B (Important), C (Low)
- **Status tracking** — Operational, Maintenance, Down
- **Warranty management** — expiry date, provider, notes, with automatic status badges (Active / Expiring / Expired)
- **Equipment history** — view maintenance statistics, compatible parts, and full info from a single panel
- **Compatible parts linking** — see which inventory parts fit each piece of equipment
- **Add, edit, delete** any equipment record

### 3. Parts Inventory

- **Full parts register** — name, part number, quantity, minimum stock level, shelf/bin location
- **Stock status indicators** — In Stock, Low Stock, Out of Stock (auto-calculated from quantity vs min stock)
- **Monthly usage tracking** — records how many times each part has been used
- **Compatible equipment linking** — associate parts with specific machines
- **Edit and delete** parts
- **Reorder functionality** — order more stock directly from the parts screen

### 4. Preventive Maintenance (PM)

- **Schedule PM tasks** with equipment, frequency (Daily through Annual), duration, and assigned engineer
- **Checklists** — define step-by-step checks that must all be ticked off before a task can be marked complete
- **Per-item notes** — engineers can add notes to individual checklist items during completion
- **Start/finish time capture** on completion
- **Due status tracking** — Overdue, Due Soon, Upcoming, Completed — with colour-coded badges
- **Reassignment** — reassign PM tasks to different engineers directly from the list
- **Filters** — filter by status (Complete / Scheduled / Unscheduled), equipment, and date range
- **View completed checklist results** — review what was checked and any notes from previous completions
- **Auto-creates calendar events** when a PM is scheduled (Pro tier calendar)

### 5. Daily Activity Log

- **Timeline view** of all maintenance activity for a selected date
- **Activity types** — work orders created, started, completed; PM tasks completed
- **Metadata** — engineer name, duration, parts used
- **Daily summary KPIs** — work orders created, completed, PM tasks completed, total downtime

### 6. Reactive Maintenance / Breakdown Logging

- **Log breakdowns** with machine, date/time, fault description, root cause, and resolution
- **Status tracking** — Resolved, In Progress, Pending
- **Auto-raise work orders** — optionally create a linked work order when logging a breakdown
- **Linked WO tracking** — see which breakdowns have associated work orders
- **Resolution recording** — document the fix applied and time to resolve
- **Production loss tracking** — record hours of production lost per breakdown
- **Filters** — filter by machine, status, and date range
- **Edit and delete** breakdown records

### 7. My Tasks / Engineer Dashboard

- **Per-engineer view** — select an engineer to see their assigned work
- **Work orders section** — all open/in-progress work orders assigned to that engineer
- **PM tasks section** — all preventive maintenance tasks assigned, with due status and quick-complete button
- **Auto-selects current user** on login

### 8. Work Requests

- **Submit maintenance requests** from the shop floor — select equipment, describe the issue, set urgency
- **Urgency levels** — Low, Medium, High
- **Admin/Manager approval workflow** — managers can approve (auto-creates a work order with optional engineer assignment) or decline
- **Status tracking** — Pending, Approved, Declined
- **Filter** by status and urgency
- **Pending count badge** on the tab

### 9. Notifications

- **Notification bell** with unread count badge
- **Dropdown panel** with categorised alerts:
  - Overdue PM tasks
  - Unassigned work orders
  - Expiring permits
  - Completed work orders
  - Warranty expirations
  - Emergency lighting tests due
- **Click-to-navigate** — clicking a notification takes you to the relevant tab/item

---

## Pro Tier Features

Everything in Essential, plus:

### 10. Purchase Orders

- **Create purchase orders** with vendor, line items, quantities, unit prices, and auto-calculated totals
- **Approval workflow** — pending POs require manager approval before being sent to vendors
- **Status tracking** — Pending, Approved, Ordered, In Transit, Received, Cancelled
- **Quick filters** — filter POs by status with one click
- **Tracking numbers** — record and display shipping tracking info
- **Budget codes** — assign POs to budget categories (Maintenance, Emergency, Capital, Line Operating)
- **Spending analysis dashboard** — spending breakdowns by vendor, category, and budget code
- **Summary KPIs** — open POs, total value, monthly spending, YTD budget usage
- **Auto-PO creation** — ordering parts from inventory automatically creates a purchase order

### 11. Permits Management

#### Hot Work Permits
- **Issue permits** for welding, cutting, grinding, or any spark-producing work
- **Safety checklist** — mandatory checks (fire extinguisher, area cleared, fire watch assigned, equipment inspected, emergency procedures reviewed)
- **Time-limited** — set start and end times with expiry countdown
- **Close permits** when work is complete

#### Contractor Work Permits
- **Issue permits** for external contractors working on-site
- **Capture** company name, supervisor, phone, worker count, insurance certificate number
- **Date range validity** with expiry tracking
- **Compliance checklist** — safety orientation, insurance verified, emergency procedures, PPE, tools inspected
- **Scope of work** documentation
- **View full details** and revoke permits

### 12. Analytics & Reports

#### Dashboards (Chart.js)
- **Equipment Downtime by Line** — bar chart showing hours per production line
- **Work Order Status Distribution** — doughnut chart (Open / In Progress / Completed)
- **PM Compliance Trend** — line chart showing compliance % over 6 months

#### Metrics
- **Top 5 Problem Equipment** — ranked by work order count (30 days)
- **Maintenance Cost Breakdown** — labor, parts, contractor costs with total
- **PM Completion Rate** — on-time, late, overdue, with compliance percentage
- **Parts Stock Forecast** — parts at risk of depletion with months remaining
- **MTTR & MTBF** — Mean Time to Repair and Mean Time Between Failures per machine, calculated from breakdown data
- **Technician Workload** — active work orders and PM tasks per engineer
- **Equipment Health Scores** — composite 0-100 score per machine based on age, breakdown frequency, status, and work order load
- **Labor Costs** — calculated from tracked time on work orders multiplied by engineer hourly rates

#### CSV Exports
- Export any data set as CSV: Work Orders, Equipment, Parts Inventory, Breakdowns, PM Schedule, Purchase Orders
- **Full Maintenance Report** — comprehensive text export covering all KPIs, equipment status, active work orders, PM schedule, and parts requiring attention

### 13. Maintenance Calendar

- **Month view** — full calendar grid with colour-coded event pills
- **Week view** — 7-day column layout with detailed event cards
- **Event types** with colour coding:
  - Blue — Weekly PM
  - Purple — Monthly PM
  - Red — Major Service
  - Yellow — Inspection
  - Dark Red — Factory Shutdown
- **Add planned jobs** — title, equipment, type, date, duration, assigned engineer, status
- **Navigate** between months/weeks with arrow buttons
- **Today highlighting** — current day outlined in blue

### 14. Supplier Management (on Parts)

- **Multiple suppliers per part** — record supplier name, supplier part number, unit price, and lead time
- **Supplier comparison panel** — when ordering a part, see all suppliers side-by-side with pricing and lead times
- **Smart vendor dropdown** — pre-populated from the part's supplier data when placing an order

### 15. Offline Mode

- **Service Worker** registered for Pro tier users
- **Cached authentication** — if Supabase is unreachable, the app falls back to cached session data
- **Offline indicator** — red "OFFLINE" badge in the header when connection is lost
- **All data persisted locally** — full functionality continues offline via localStorage

---

## Technical Architecture

| Component | Technology |
|---|---|
| Frontend | Single HTML file, vanilla JavaScript, CSS custom properties |
| Authentication | Supabase Auth (email/password) |
| Database | Supabase (PostgreSQL) |
| Charts | Chart.js 4.4.0 |
| Data Persistence | localStorage with prefix-based namespacing |
| Offline Support | Service Worker + cached auth |
| Fonts | Work Sans, IBM Plex Mono (Google Fonts) |
| Security | Content Security Policy headers |

### User Roles

| Role | Capabilities |
|---|---|
| **Admin** | Full access, approve users, approve work requests, manage all data |
| **Manager** | Approve work requests, approve purchase orders, full operational access |
| **Engineer** | Create/edit work orders, complete PM tasks, log breakdowns, submit work requests |
| **Pending** | Blocked from app access until admin approval |

### Data Persistence

- All data stores (work orders, equipment, parts, PMs, breakdowns, calendar events, purchase orders, permits, work requests) are saved to localStorage
- Data migrations run automatically on load to add new fields to existing records
- Default seed data provided on first load

---

## Tier Comparison

| Feature | Essential | Pro |
|---|:---:|:---:|
| Work Orders | Yes | Yes |
| Equipment Management | Yes | Yes |
| Parts Inventory | Yes | Yes |
| Preventive Maintenance | Yes | Yes |
| PM Checklists | Yes | Yes |
| Daily Activity Log | Yes | Yes |
| Reactive Maintenance | Yes | Yes |
| My Tasks Dashboard | Yes | Yes |
| Work Requests | Yes | Yes |
| Notifications | Yes | Yes |
| Search | Yes | Yes |
| Purchase Orders | — | Yes |
| Permits (Hot Work + Contractor) | — | Yes |
| Analytics & Reports | — | Yes |
| CSV Exports | — | Yes |
| Maintenance Calendar | — | Yes |
| Supplier Management | — | Yes |
| Equipment Health Scores | — | Yes |
| MTTR / MTBF Metrics | — | Yes |
| Technician Workload Analytics | — | Yes |
| Labor Cost Tracking | — | Yes |
| Parts Stock Forecasting | — | Yes |
| Offline Mode | — | Yes |

---

## Key Workflows

### Work Order Lifecycle
1. Work order created (manually, from work request approval, or auto-raised from breakdown)
2. Assigned to engineer
3. Engineer starts work — status moves to In Progress, start time recorded
4. Engineer adds comments, tracks time
5. Work completed — finish time recorded, total job time auto-calculated
6. Machine downtime logged

### PM Completion Workflow
1. PM task becomes due (overdue/due-soon badge appears)
2. Engineer clicks "Complete Now"
3. Start time pre-filled, each checklist item must be ticked
4. Optional notes added per checklist item
5. Finish time entered
6. All items verified — task marked complete
7. Checklist results saved for audit trail

### Breakdown → Work Order Flow
1. Breakdown logged in Reactive Maintenance
2. "Also raise a Work Order" checkbox auto-checked for unresolved issues
3. Work order auto-created with high priority, linked to breakdown
4. When breakdown is resolved, linked work order auto-completed

### Work Request → Work Order Flow
1. Floor worker submits maintenance request with equipment, description, urgency
2. Manager reviews in Work Requests tab
3. Manager selects engineer and clicks "Approve & Create WO"
4. Work order auto-created with request details, assigned to selected engineer

---

*Document generated from Cradero v1.0 source code — February 2026*
