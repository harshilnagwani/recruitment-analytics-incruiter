# 📊 Recruitment Analytics Dashboard — InCruiter BA Project

<div align="center">

![Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![SQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)

**Role Simulated:** Business Analyst @ InCruiter &nbsp;|&nbsp; **Tool:** Microsoft Excel + SQL &nbsp;|&nbsp; **Dataset:** Kaggle (1,500 rows)

</div>

---

## 🎯 Project Objective

Simulate the analytical responsibilities of a **Business Analyst at InCruiter** — India's AI-powered recruitment SaaS platform. Starting from a raw 1,500-row hiring decision dataset, this project builds a fully interactive Excel dashboard that gives HR leadership instant visibility into:

- 📉 **Pipeline health** — where candidates drop out of the funnel
- 🔗 **Source quality** — which channel produces the best hires fastest
- ⏱️ **Time-to-hire** — monthly trend of days from application to offer

---

## 🔑 Key Business Insights

### 💡 Insight 1 — Referral Hires Are ~40% Faster
> Referral-sourced candidates reach offer stage in **~18 days** vs. **~35 days** for Job Board hires.  
> **Recommendation:** Increase referral bonus budget; target 30% referral hires per quarter.

### 💡 Insight 2 — 37% of Pipeline Drops at Screening
> 553 out of 1,500 candidates exit at the Screening stage — the **single largest drop-off point**.  
> **Recommendation:** Add pre-screening ATS questions; revise JDs to attract better-qualified applicants.

### 💡 Insight 3 — LinkedIn Drives Volume, Referral Drives Quality
> LinkedIn: ~503 apps @ 29% hire rate vs. Referral: ~523 apps @ **higher hire rate + better scores**.  
> **Recommendation:** Reallocate 15% of LinkedIn spend to employee referral incentives.

---

## 📁 Project Structure

```
recruitment-analytics-incruiter/
│
├── 📊 recruitment_data.xlsx          ← Main Excel workbook (dashboard + data)
├── 📄 recruitment_data_clean.csv     ← Clean 1,500-row dataset (18 columns)
├── 🗄️ recruitment_analysis.sql       ← Full SQL analysis (8 query sections)
├── 📋 Documentation_Pack.xlsx        ← SOP + Data Dictionary + Impact Summary
└── 📝 README.md                      ← This file
```

---

## 📊 Excel Dashboard Features

| Feature | Description |
|---|---|
| 🔽 **3 Slicers** | Filter entire dashboard by Source, Month, and Hiring Decision |
| 📉 **Funnel Chart** | Drop-off at each stage: Screening → Interview → Offer → Joined |
| 📊 **Bar Chart** | Applications vs. Hires by recruitment channel |
| 📈 **Line Chart** | Monthly average time-to-offer trend (Jan–Jun 2024) |
| 🚦 **Traffic Light KPIs** | Offer-to-Join Rate, Avg Days to Offer, Avg Interview Score |
| 🎨 **Conditional Formatting** | Color scales on recruiter productivity scorecard |

---

## 🗄️ SQL Analysis (recruitment_analysis.sql)

The SQL file contains **8 fully commented query sections** for MySQL/PostgreSQL:

| Section | Queries |
|---|---|
| 0. Schema Setup | `CREATE TABLE` with all 18 columns |
| 1. Data Quality | Null checks, value validation, range checks |
| 2. Funnel Analysis | Drop-off count, % per stage, conversion rates |
| 3. Source Effectiveness | Hire rate, avg days, composite quality score per channel |
| 4. Time-to-Hire Trend | Monthly avg days to offer + by source |
| 5. Recruiter Scorecard | Full productivity metrics per channel |
| 6. KPI Summary | Overall pipeline health snapshot |
| 7. Candidate Profiles | Hired vs. not-hired comparison by education & experience |
| 8. Advanced Queries | Top missed hires, quality risks, cumulative hires, gap analysis |

---

## 🛠️ Tools & Techniques

| Category | Details |
|---|---|
| **Excel** | PivotTables, PivotCharts, Slicers, Named Ranges, Data Validation |
| **Excel Formulas** | IF, TEXT, COUNTIF, COUNTIFS, AVERAGEIF, SUMPRODUCT, RANDBETWEEN |
| **Conditional Formatting** | Traffic lights (CellIsRule), Color scales, Icon sets |
| **SQL** | DDL, aggregations, CASE WHEN, window functions, subqueries, UNION |
| **Data Engineering** | 7 derived columns: date offsets, funnel logic, month bucketing |
| **Documentation** | SOP (1-page), Data Dictionary (18 cols), Business Impact Summary |

---

## 📋 Dataset

**Source:** [Predicting Hiring Decisions in Recruitment Data](https://www.kaggle.com/datasets/rabieelkharoua/predicting-hiring-decisions-in-recruitment-data) — Rabie El Kharoua (Kaggle, 2024)

| Column | Type | Description |
|---|---|---|
| Age | Integer | Candidate age (18–60) |
| Gender | 0/1 | 0=Female, 1=Male |
| EducationLevel | 1–3 | 1=Bachelor, 2=Master, 3=PhD |
| ExperienceYears | Integer | Years of work experience |
| PreviousCompanies | Integer | Number of prior employers |
| DistanceFromCompany | Decimal | Distance in km |
| InterviewScore | 0–100 | Interviewer-assigned score |
| SkillScore | 0–100 | Technical assessment score |
| PersonalityScore | 0–100 | Culture-fit score |
| RecruitmentStrategy | 1–3 | 1=LinkedIn, 2=Referral, 3=Job Board |
| HiringDecision | 0/1 | Final outcome (1=Hired) |
| Application_Date | Date | Derived: simulated application date |
| Offer_Date | Date | Derived: application + channel-based offset |
| Join_Date | Date | Derived: offer + 7–30 days (hired only) |
| Days_to_Offer | Integer | Offer_Date − Application_Date |
| Days_to_Join | Integer | Join_Date − Offer_Date |
| Funnel_Stage_Drop | Text | Derived from InterviewScore thresholds |
| Month | MMM-YYYY | Derived from Offer_Date |

---

## 💼 Resume Bullets (XYZ Format)

- Designed a **5-sheet interactive Excel recruitment dashboard** tracking 1,500 candidates across 4 pipeline stages, identifying a **37% screening drop-off** that supported a JD revision recommendation.
- Built **7 derived KPI columns** using advanced Excel formulas (IF, COUNTIFS, TEXT, RANDBETWEEN), reducing estimated manual reporting effort by **~4 hrs/month**.
- Identified Referral hires are **40% faster** than Job Board hires (18 vs. 35 avg. days to offer) via source × time-to-hire pivot — directly informing a **referral programme investment proposal**.
- Implemented **3 cross-filtered slicers** and traffic-light conditional formatting on 3 KPIs, enabling one-click insight extraction for non-technical HR stakeholders.
- Authored a **1-page SOP**, 18-column **Data Dictionary**, and **8-section SQL analysis script** covering funnel analytics, source effectiveness, and candidate profiling.

---

## 🚀 How to Run

**Excel Dashboard:**
1. Open `recruitment_data.xlsx`
2. Enable editing + content if prompted
3. Use the slicers on the Dashboard sheet to filter by Source / Month / Hiring Decision

**SQL Queries:**
```sql
-- 1. Create the table
source recruitment_analysis.sql;   -- MySQL
-- or \i recruitment_analysis.sql  -- PostgreSQL

-- 2. Load data
LOAD DATA INFILE 'recruitment_data_clean.csv'
INTO TABLE recruitment_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. Run any section query
```

---

## 👤 Author

**Harshil Nagwani** — Data Analyst | CS Final Year  
📧 harshil.nagwani22@gmail.com  
🌐 [harshilnagwani.github.io](https://harshilnagwani.github.io)  
💼 [LinkedIn](https://linkedin.com/in/harshilnagwani)  
🐙 [GitHub](https://github.com/harshilnagwani)

---

*Dataset credit: Rabie El Kharoua — Kaggle (2024)*
