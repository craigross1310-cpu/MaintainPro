# Cradero — Privacy Policy

**Last updated:** March 2026

---

## 1. Introduction

This Privacy Policy explains how Cradero ("we", "us", "our") collects, uses, stores, and protects personal data when you use our maintenance management software ("Service").

We are committed to protecting your privacy and handling your data in accordance with the UK General Data Protection Regulation (UK GDPR) and the Data Protection Act 2018.

---

## 2. Data Controller

Cradero is the data controller for the personal data we collect through the Service.

**Contact:**
Cradero
Email: [your-email@example.com]

---

## 3. What Data We Collect

### 3.1 Account Data
When you create an account, we collect:
- Full name
- Email address
- Password (stored securely as a hash — we never store plain text passwords)
- Phone number (optional)
- Department (optional)

### 3.2 Usage Data
When you use the Service, we process:
- Work orders, equipment records, parts inventory, and other maintenance data you enter
- Audit trail records (actions performed, timestamps, user identity)
- Photos and documents you upload (work order photos, equipment SOPs, manuals)
- Comments and notes you add to records

### 3.3 Technical Data
We automatically collect:
- IP address
- Browser type and version
- Device type
- Pages accessed and features used
- Login timestamps and session duration

### 3.4 Data We Do Not Collect
- We do not use cookies for tracking or advertising
- We do not collect location data
- We do not collect data from third-party social media profiles
- We do not sell, rent, or trade your personal data to third parties

---

## 4. How We Use Your Data

We process your personal data for the following purposes:

| Purpose | Legal Basis (UK GDPR) |
|---------|----------------------|
| Providing and operating the Service | Performance of contract (Art. 6(1)(b)) |
| User authentication and account security | Performance of contract / Legitimate interest |
| Generating audit trails and activity logs | Legitimate interest (Art. 6(1)(f)) |
| Sending service-related communications (e.g. account approval, password reset) | Performance of contract |
| Improving and developing the Service | Legitimate interest |
| Complying with legal obligations | Legal obligation (Art. 6(1)(c)) |
| Preventing fraud and abuse | Legitimate interest |

---

## 5. Data Sharing and Third Parties

We use the following third-party service providers to operate the Service:

| Provider | Purpose | Data Processed | Location |
|----------|---------|---------------|----------|
| Supabase | Database hosting, user authentication, file storage | All Customer Data, account credentials | EU (Frankfurt) or UK (London) — configured per project |
| Vercel | Website hosting and delivery | Technical data (IP, browser) | Global CDN |
| Cloudflare | Domain registration and DNS | DNS queries, domain registration details | Global |
| Google Fonts | Font delivery | IP address (standard web request) | Global |
| jsDelivr CDN | JavaScript library delivery | IP address (standard web request) | Global |

We do not share your personal data with any other third parties, advertisers, or data brokers.

### 5.1 Sub-processors
Our primary data processor is Supabase (Supabase Inc.), which provides the database, authentication, and file storage infrastructure. Supabase processes data in accordance with their Data Processing Agreement and maintains SOC 2 Type II certification.

### 5.2 Law Enforcement
We may disclose your data if required by law, court order, or governmental regulation, or if we believe disclosure is necessary to protect our rights, your safety, or the safety of others.

---

## 6. Data Storage and Security

### 6.1 Where Your Data is Stored
Your data is stored in Supabase's PostgreSQL database, hosted in the EU (Frankfurt) or UK (London) region. File uploads (photos, documents) are stored in Supabase Storage in the same region.

### 6.2 Security Measures
We implement the following security measures:
- All data transmitted between your browser and our servers is encrypted using HTTPS/TLS
- Passwords are hashed using industry-standard algorithms (bcrypt via Supabase Auth)
- Row Level Security (RLS) policies enforce data access controls at the database level
- Session timeout after 30 minutes of inactivity
- Login rate limiting (5 failed attempts triggers temporary lockout)
- Content Security Policy (CSP) headers to prevent cross-site scripting attacks
- File upload validation (type checking, size limits, malicious filename detection)
- Role-based access controls restrict what each user can view and modify

### 6.3 Data Breaches
In the event of a personal data breach that poses a risk to your rights and freedoms, we will notify the Information Commissioner's Office (ICO) within 72 hours and inform affected individuals without undue delay, as required by UK GDPR.

---

## 7. Data Retention

| Data Type | Retention Period |
|-----------|-----------------|
| Account data (name, email, role) | Duration of subscription + 30 days |
| Customer Data (work orders, equipment, etc.) | Duration of subscription + 30 days |
| Uploaded files (photos, documents) | Duration of subscription + 30 days |
| Audit trail | Duration of subscription + 30 days |
| Backups | Up to 90 days after deletion for disaster recovery |
| Technical/access logs | 90 days |

After the retention period, data is permanently deleted from our systems and backups.

---

## 8. Your Rights

Under UK GDPR, you have the following rights:

| Right | Description |
|-------|-------------|
| **Access** | Request a copy of the personal data we hold about you |
| **Rectification** | Request correction of inaccurate personal data |
| **Erasure** | Request deletion of your personal data ("right to be forgotten") |
| **Restriction** | Request that we limit processing of your personal data |
| **Portability** | Request your data in a structured, machine-readable format |
| **Objection** | Object to processing based on legitimate interests |
| **Withdraw consent** | Where processing is based on consent, withdraw it at any time |

To exercise any of these rights, contact us at [your-email@example.com]. We will respond within one month.

### 8.1 Right to Complain
If you are not satisfied with how we handle your data, you have the right to lodge a complaint with the Information Commissioner's Office (ICO):

- Website: https://ico.org.uk
- Phone: 0303 123 1113

---

## 9. Children's Data

The Service is not intended for use by individuals under the age of 16. We do not knowingly collect personal data from children. If we become aware that we have collected data from a child, we will take steps to delete it promptly.

---

## 10. International Data Transfers

Where data is processed outside the UK (e.g. by CDN providers), we ensure appropriate safeguards are in place, such as Standard Contractual Clauses (SCCs) or adequacy decisions recognised by the UK government.

---

## 11. Changes to This Policy

We may update this Privacy Policy from time to time. We will notify you of material changes via email or through the Service. The "Last updated" date at the top indicates when this policy was last revised.

---

## 12. Contact Us

If you have questions about this Privacy Policy or how we handle your data, contact us at:

**Cradero**
Email: [your-email@example.com]

---

*This Privacy Policy is provided as a starting template and should be reviewed by a qualified legal professional before use. Compliance with UK GDPR requires ongoing assessment and may necessitate additional documentation such as a Record of Processing Activities (ROPA) and Data Protection Impact Assessments (DPIAs).*
