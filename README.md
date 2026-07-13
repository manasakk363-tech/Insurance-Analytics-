# Insurance Analytics  Project

## 📌 Overview
This project analyzes insurance policy, claims, brokerage, and customer data to uncover trends in policy performance, claim behavior, renewals, and revenue. It combines **SQL** for data modeling, **Excel** for exploratory analysis, and **Power BI** & **Tableau** for interactive dashboards.

## 🎯 Objectives
- Consolidate policy, claims, customer, payment, and brokerage data into a unified view
- Track key metrics: active vs. lapsed policies, claim ratios, renewal trends, and revenue by product/branch
- Build interactive dashboards to help stakeholders monitor performance across regions and executives
- Identify patterns in policy lapses, cross-sell/renewal opportunities, and high-risk segments

## 🗂️ Repository Structure
```
Insurance Analytics/
│
├── Excel/
│   ├── Policy Dashboard.xlsx        # Excel-based policy dashboard
│   └── Insurance_dashboard.xlsm     # Macro-enabled Excel dashboard
│
├── Power bi & sql/
│   ├── Policy Analysis.sql          # Master view joining policy, claims, customer & payment tables
│   ├── insurance_analytics.sql      # Database schema & data dump (brokerage, policy, etc.)
│   ├── Insurance Analytics Dashboard.pbix
│   └── Policy Dashboard.pbix
│
├── Tableau & sql/
│   ├── Policy Data sql.sql
│   ├── Insurence_analysis(PK and FK).sql   # Schema with primary/foreign keys
│   ├── tableau_PolicyData.twbx
│   └── Insurence Dashboard.twbx
│
└── INSURANCE ANALYTICS CAPSTONE PROJECT.pptx   # Final presentation
```

## 🛠️ Tools & Technologies
- **SQL (MySQL)** – Data modeling, joins, master views
- **Microsoft Excel** – Data cleaning & dashboarding
- **Power BI** – Interactive business dashboards
- **Tableau** – Visual analytics & storytelling
- **PowerPoint** – Final project presentation

## 📊 Key Dashboards
| Tool | File | Purpose |
|------|------|---------|
| Excel | `Policy Dashboard.xlsx` | Quick policy-level KPIs |
| Power BI | `Insurance Analytics Dashboard.pbix` | Executive-level insights |
| Tableau | `Insurence Dashboard.twbx` | Regional & agent performance view |

## 🧩 Data Model
The core dataset is built around a master SQL view (`insurance_master`) joining:
- **Policy Details** – coverage, premium, dates, status
- **Claims** – claim amount, status, reason, settlement date
- **Customer Information** – demographics, occupation, address
- **Payments** – payment status, method, date
- **Additional Fields** – agent, renewal status, discounts, risk score

## 🚀 How to Use
1. Clone/download the repository
2. Run the `.sql` files in a MySQL instance to set up the database
3. Open the `.pbix` file in Power BI Desktop or `.twbx` in Tableau Desktop to explore dashboards
4. Refer to the `.pptx` for a summarized walkthrough of findings and recommendations

## 📈 Key Insights (fill in with your findings)
- Policy renewal rate trends across products/regions
- Top reasons for policy lapses
- Claim settlement turnaround time
- Revenue contribution by branch/executive

## Dashboard

  ## Excel  Insurance and Policy Dashboards
 <img width="1242" height="701" alt="Screenshot 2026-07-09 212736" src="https://github.com/user-attachments/assets/08a36ee9-7e01-42c2-83ea-ec2150a875f8" />
 <img width="1237" height="701" alt="Screenshot 2026-07-09 212819" src="https://github.com/user-attachments/assets/698541b5-420b-43ab-8c97-6fcf300a793d" />

 ### SQL Queries
  <img width="1601" height="647" alt="Screenshot 2026-07-09 214407" src="https://github.com/user-attachments/assets/331111a6-14c3-44c0-ada3-1efcd0450921" />

  ## Power BI  Insurance and Policy Dashboards 
  <img width="1236" height="707" alt="Screenshot 2026-07-09 213013" src="https://github.com/user-attachments/assets/8c5305bb-2512-432a-8ed6-a5a441968552" />
  <img width="1236" height="701" alt="Screenshot 2026-07-09 213043" src="https://github.com/user-attachments/assets/f64f4f38-0082-4632-a6a8-d5e24f349fac" />

  ## Tableau  Insurance and Policy Dashboards 
  <img width="1237" height="693" alt="Screenshot 2026-07-09 212834" src="https://github.com/user-attachments/assets/896be139-3524-426b-af58-73a65c3263fa" />
 <img width="1243" height="695" alt="Screenshot 2026-07-09 212929" src="https://github.com/user-attachments/assets/6bf5a80c-801c-46c0-af01-a8d453d44adc" />




