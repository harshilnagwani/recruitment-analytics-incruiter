# Standard Operating Procedure
## Monthly Dashboard Refresh — Recruitment Analytics

**Document Owner:** HR Analytics / Business Analyst  
**Stakeholders:** HR Director, Talent Acquisition Head  
**Frequency:** Monthly (1st working day of each month)  
**Estimated Time:** ~30 minutes  
**Version:** 1.0 | **Last Updated:** April 2026

---

## Steps

| # | Step | Action | Time |
|---|---|---|---|
| 1 | **Export new data** | Download latest hiring records from ATS (Applicant Tracking System) as CSV | 5 min |
| 2 | **Paste into Raw_Data sheet** | Open `recruitment_data.xlsx` → Raw_Data tab → paste below existing rows | 3 min |
| 3 | **Extend derived columns** | Drag formulas in cols L–R (Application_Date through Month) down to cover new rows | 5 min |
| 4 | **Refresh all PivotTables** | Click any PivotTable → PivotTable Analyze tab → **Refresh All** | 1 min |
| 5 | **Verify funnel chart** | Confirm Funnel Chart bars updated. If not, right-click chart → Select Data → extend range | 3 min |
| 6 | **Check KPI traffic lights** | Confirm 3 KPI cells show correct ✅/⚠️/❌ icons based on thresholds | 2 min |
| 7 | **Update month slicer** | Click Month Slicer → select new month → verify dashboard filters correctly | 2 min |
| 8 | **Save & export PDF** | File → Export → Create PDF/XPS → save as `Recruitment_Report_MMM-YYYY.pdf` | 2 min |
| 9 | **Email to HR Director** | Attach PDF + note top 2 insights from the month | 5 min |

---

## Troubleshooting

| Issue | Likely Cause | Fix |
|---|---|---|
| Pivot not refreshing | New rows outside named range | Extend Table (Ctrl+T range) or manually extend PivotTable source |
| Funnel chart not updating | Chart data range not extended | Right-click chart → Select Data → update range to include new rows |
| #REF! or #VALUE! errors | Formula dragged incorrectly | Re-drag from last clean row; check col references |
| Wrong Month label | Month formula needs rechecking | Verify Offer_Date col has valid dates; check =TEXT(M2,"MMM-YYYY") formula |

---

*For questions, contact the Business Analyst owner of this workbook.*
