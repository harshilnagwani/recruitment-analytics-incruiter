# Data Dictionary
## Recruitment Analytics Dashboard

**Dataset:** recruitment_data (1,500 rows, 18 columns)  
**Source:** Kaggle — Rabie El Kharoua (2024)  
**Last Updated:** April 2026

---

## Section A — Original Kaggle Columns

| Column | Data Type | Range / Values | Description | Used In KPI? |
|---|---|---|---|---|
| Age | Integer | 18–60 | Candidate age in years | No |
| Gender | Binary | 0=Female, 1=Male | Candidate gender | No |
| EducationLevel | Integer | 1=Bachelor, 2=Master, 3=PhD | Highest education attained | No |
| ExperienceYears | Integer | 0–15 | Total years of work experience | No |
| PreviousCompanies | Integer | 0–5 | Number of prior employers | No |
| DistanceFromCompany | Decimal | 1.0–50.0 km | Candidate’s commute distance | No |
| InterviewScore | Integer | 0–100 | Interviewer-assigned performance score | ✅ Avg Interview Score KPI |
| SkillScore | Integer | 0–100 | Technical / skills assessment score | No |
| PersonalityScore | Integer | 0–100 | Culture-fit / personality score | No |
| RecruitmentStrategy | Integer | 1=LinkedIn, 2=Referral, 3=Job Board | Sourcing channel used | ✅ Source bar chart |
| HiringDecision | Binary | 0=Not Hired, 1=Hired | Final hiring outcome | ✅ Hire rate, offer-to-join |

---

## Section B — Analyst-Derived Columns

| Column | Formula (Excel) | Description |
|---|---|---|
| Application_Date | `=DATE(2024, RANDBETWEEN(1,6), RANDBETWEEN(1,28))` | Simulated application date (Jan–Jun 2024) |
| Offer_Date | `=L2 + IF(K2=1, IF(J2=2,18,IF(J2=1,15,35)), 35)` | Application date + channel-specific processing days |
| Join_Date | `=IF(K2=1, M2+RANDBETWEEN(7,30), "N/A")` | Offer date + joining lag (hired candidates only) |
| Days_to_Offer | `=M2-L2` | Days from application to offer letter |
| Days_to_Join | `=IF(K2=1, N2-M2, "N/A")` | Days from offer to joining (hired only) |
| Funnel_Stage_Drop | `=IF(K2=1,"Joined",IF(H2<50,"Dropped at Screening",IF(H2<70,"Dropped at Interview","Dropped at Offer")))` | Derived pipeline exit stage |
| Month | `=TEXT(M2,"MMM-YYYY")` | Month label for timeline slicing |

---

## Section C — KPI Definitions

| KPI | Formula | Target | Traffic Light |
|---|---|---|---|
| **Offer-to-Join Rate** | `=COUNTIF(K:K,1)/COUNTA(K2:K1501)` | ≥65% | ✅ Green ≥65%, ⚠️ Amber 50–64%, ❌ Red <50% |
| **Avg Days to Offer** | `=AVERAGE(O2:O1501)` | ≤25 days | ✅ Green ≤25, ⚠️ Amber 26–35, ❌ Red >35 |
| **Avg Interview Score** | `=AVERAGEIF(K2:K1501,1,H2:H1501)` | ≥75 | ✅ Green ≥75, ⚠️ Amber 60–74, ❌ Red <60 |

---

*Last updated by: Harshil Nagwani, April 2026*
