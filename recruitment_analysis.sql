-- ============================================================
--  RECRUITMENT ANALYTICS SQL ANALYSIS
--  Project : Recruitment Analytics Dashboard — InCruiter BA Project
--  Author  : Harshil Nagwani
--  Dataset : recruitment_data (1,500 records)
--  DB      : MySQL / PostgreSQL compatible
--  Date    : April 2026
-- ============================================================


-- ──────────────────────────────────────────────────────────────
-- 0. TABLE CREATION (run once to set up the schema)
-- ──────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS recruitment_data (
    CandidateID         INT AUTO_INCREMENT PRIMARY KEY,
    Age                 INT,
    Gender              TINYINT,          -- 0=Female, 1=Male
    EducationLevel      TINYINT,          -- 1=Bachelor, 2=Master, 3=PhD
    ExperienceYears     INT,
    PreviousCompanies   INT,
    DistanceFromCompany DECIMAL(5,2),
    InterviewScore      INT,
    SkillScore          INT,
    PersonalityScore    INT,
    RecruitmentStrategy TINYINT,          -- 1=LinkedIn, 2=Referral, 3=Job Board
    HiringDecision      TINYINT,          -- 0=Not Hired, 1=Hired
    Application_Date    DATE,
    Offer_Date          DATE,
    Join_Date           DATE,
    Days_to_Offer       INT,
    Days_to_Join        INT,
    Funnel_Stage_Drop   VARCHAR(30),
    Month               VARCHAR(10)
);

-- Import CSV after creating the table:
-- LOAD DATA INFILE '/path/to/recruitment_data_clean.csv'
-- INTO TABLE recruitment_data
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;


-- ──────────────────────────────────────────────────────────────
-- 1. DATA QUALITY CHECKS
-- ──────────────────────────────────────────────────────────────

-- Check 1: Total records
SELECT COUNT(*) AS total_records FROM recruitment_data;
-- Expected: 1500

-- Check 2: Nulls in critical columns
SELECT
    SUM(CASE WHEN HiringDecision IS NULL THEN 1 ELSE 0 END) AS null_hiring,
    SUM(CASE WHEN InterviewScore  IS NULL THEN 1 ELSE 0 END) AS null_interview,
    SUM(CASE WHEN Days_to_Offer   IS NULL THEN 1 ELSE 0 END) AS null_days_offer,
    SUM(CASE WHEN Funnel_Stage_Drop IS NULL THEN 1 ELSE 0 END) AS null_funnel
FROM recruitment_data;
-- All should return 0

-- Check 3: HiringDecision only 0 or 1
SELECT HiringDecision, COUNT(*) AS count
FROM recruitment_data
GROUP BY HiringDecision;

-- Check 4: RecruitmentStrategy only 1, 2, or 3
SELECT RecruitmentStrategy, COUNT(*) AS count
FROM recruitment_data
GROUP BY RecruitmentStrategy
ORDER BY RecruitmentStrategy;

-- Check 5: No negative Days_to_Offer
SELECT COUNT(*) AS negative_days
FROM recruitment_data
WHERE Days_to_Offer < 0;


-- ──────────────────────────────────────────────────────────────
-- 2. FUNNEL DROP-OFF ANALYSIS
-- ──────────────────────────────────────────────────────────────

SELECT
    Funnel_Stage_Drop                           AS stage,
    COUNT(*)                                    AS candidates,
    ROUND(COUNT(*) * 100.0 / 1500, 1)          AS pct_of_total
FROM recruitment_data
GROUP BY Funnel_Stage_Drop
ORDER BY
    CASE Funnel_Stage_Drop
        WHEN 'Dropped at Screening' THEN 1
        WHEN 'Dropped at Interview' THEN 2
        WHEN 'Dropped at Offer'     THEN 3
        WHEN 'Joined'               THEN 4
    END;

SELECT
    ROUND(SUM(CASE WHEN Funnel_Stage_Drop != 'Dropped at Screening' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS screening_pass_pct,
    ROUND(SUM(CASE WHEN Funnel_Stage_Drop != 'Dropped at Interview'
                    AND Funnel_Stage_Drop != 'Dropped at Screening' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS interview_pass_pct,
    ROUND(SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1)                         AS offer_accept_pct
FROM recruitment_data;


-- ──────────────────────────────────────────────────────────────
-- 3. SOURCE EFFECTIVENESS ANALYSIS
-- ──────────────────────────────────────────────────────────────

SELECT
    CASE RecruitmentStrategy
        WHEN 1 THEN 'LinkedIn'
        WHEN 2 THEN 'Referral'
        WHEN 3 THEN 'Job Board'
    END                                                         AS source,
    COUNT(*)                                                    AS total_applications,
    SUM(HiringDecision)                                         AS total_hires,
    ROUND(SUM(HiringDecision) * 100.0 / COUNT(*), 1)           AS hire_rate_pct,
    ROUND(AVG(Days_to_Offer), 1)                                AS avg_days_to_offer,
    ROUND(AVG(InterviewScore), 1)                               AS avg_interview_score
FROM recruitment_data
GROUP BY RecruitmentStrategy
ORDER BY hire_rate_pct DESC;

SELECT
    CASE RecruitmentStrategy
        WHEN 1 THEN 'LinkedIn'
        WHEN 2 THEN 'Referral'
        WHEN 3 THEN 'Job Board'
    END                                                         AS source,
    ROUND(AVG(InterviewScore), 1)                               AS avg_interview,
    ROUND(AVG(SkillScore), 1)                                   AS avg_skill,
    ROUND(AVG(PersonalityScore), 1)                             AS avg_personality,
    ROUND((AVG(InterviewScore) + AVG(SkillScore) + AVG(PersonalityScore)) / 3, 1) AS composite_quality_score
FROM recruitment_data
GROUP BY RecruitmentStrategy
ORDER BY composite_quality_score DESC;

-- KEY INSIGHT: Referral vs Job Board time-to-hire gap
SELECT
    CASE RecruitmentStrategy WHEN 2 THEN 'Referral' WHEN 3 THEN 'Job Board' END AS source,
    ROUND(AVG(Days_to_Offer), 1) AS avg_days_to_offer
FROM recruitment_data
WHERE RecruitmentStrategy IN (2, 3)
GROUP BY RecruitmentStrategy;


-- ──────────────────────────────────────────────────────────────
-- 4. TIME-TO-HIRE TREND ANALYSIS
-- ──────────────────────────────────────────────────────────────

SELECT
    Month,
    COUNT(*)                        AS applications,
    ROUND(AVG(Days_to_Offer), 1)    AS avg_days_to_offer,
    ROUND(AVG(Days_to_Join), 1)     AS avg_days_to_join,
    SUM(HiringDecision)             AS hires
FROM recruitment_data
GROUP BY Month
ORDER BY MIN(Application_Date);

SELECT
    Month,
    CASE RecruitmentStrategy
        WHEN 1 THEN 'LinkedIn'
        WHEN 2 THEN 'Referral'
        WHEN 3 THEN 'Job Board'
    END                             AS source,
    ROUND(AVG(Days_to_Offer), 1)    AS avg_days_to_offer
FROM recruitment_data
GROUP BY Month, RecruitmentStrategy
ORDER BY MIN(Application_Date), RecruitmentStrategy;


-- ──────────────────────────────────────────────────────────────
-- 5. RECRUITER / CHANNEL PRODUCTIVITY SCORECARD
-- ──────────────────────────────────────────────────────────────

SELECT
    CASE RecruitmentStrategy
        WHEN 1 THEN 'LinkedIn'
        WHEN 2 THEN 'Referral'
        WHEN 3 THEN 'Job Board'
    END                                                             AS channel,
    COUNT(*)                                                        AS pipeline_total,
    SUM(HiringDecision)                                             AS total_hires,
    ROUND(SUM(HiringDecision) * 100.0 / COUNT(*), 1)               AS hire_rate_pct,
    ROUND(AVG(Days_to_Offer), 1)                                    AS avg_days_to_offer,
    ROUND(AVG(CASE WHEN HiringDecision = 1 THEN InterviewScore END), 1) AS avg_score_hired,
    COUNT(CASE WHEN Funnel_Stage_Drop = 'Dropped at Screening' THEN 1 END) AS dropped_screening,
    ROUND(COUNT(CASE WHEN Funnel_Stage_Drop = 'Dropped at Screening' THEN 1 END) * 100.0 / COUNT(*), 1) AS screening_drop_pct
FROM recruitment_data
GROUP BY RecruitmentStrategy
ORDER BY hire_rate_pct DESC;


-- ──────────────────────────────────────────────────────────────
-- 6. KPI SUMMARY — OFFER ACCEPTANCE & PIPELINE HEALTH
-- ──────────────────────────────────────────────────────────────

SELECT
    COUNT(*)                                                        AS total_candidates,
    SUM(HiringDecision)                                             AS total_hires,
    ROUND(SUM(HiringDecision) * 100.0 / COUNT(*), 1)               AS offer_to_join_rate_pct,
    ROUND(AVG(Days_to_Offer), 1)                                    AS avg_days_to_offer,
    ROUND(AVG(Days_to_Join), 1)                                     AS avg_days_to_join,
    ROUND(AVG(CASE WHEN HiringDecision = 1 THEN InterviewScore END), 1) AS avg_interview_score_hired,
    ROUND(AVG(CASE WHEN HiringDecision = 1 THEN SkillScore END), 1)     AS avg_skill_score_hired,
    COUNT(CASE WHEN Funnel_Stage_Drop = 'Dropped at Screening' THEN 1 END) AS total_dropped_screening,
    COUNT(CASE WHEN Funnel_Stage_Drop = 'Dropped at Interview' THEN 1 END) AS total_dropped_interview,
    COUNT(CASE WHEN Funnel_Stage_Drop = 'Dropped at Offer'     THEN 1 END) AS total_dropped_offer
FROM recruitment_data;


-- ──────────────────────────────────────────────────────────────
-- 7. CANDIDATE PROFILE ANALYSIS (HIRED vs NOT HIRED)
-- ──────────────────────────────────────────────────────────────

SELECT
    CASE HiringDecision WHEN 1 THEN 'Hired' ELSE 'Not Hired' END    AS outcome,
    COUNT(*)                                                          AS count,
    ROUND(AVG(Age), 1)                                               AS avg_age,
    ROUND(AVG(ExperienceYears), 1)                                   AS avg_experience,
    ROUND(AVG(InterviewScore), 1)                                    AS avg_interview_score,
    ROUND(AVG(SkillScore), 1)                                        AS avg_skill_score,
    ROUND(AVG(PersonalityScore), 1)                                  AS avg_personality_score,
    ROUND(AVG(DistanceFromCompany), 1)                               AS avg_distance_km
FROM recruitment_data
GROUP BY HiringDecision;

SELECT
    CASE EducationLevel
        WHEN 1 THEN 'Bachelor'
        WHEN 2 THEN 'Master'
        WHEN 3 THEN 'PhD'
    END                                                              AS education,
    COUNT(*)                                                         AS total,
    SUM(HiringDecision)                                              AS hires,
    ROUND(SUM(HiringDecision) * 100.0 / COUNT(*), 1)                AS hire_rate_pct
FROM recruitment_data
GROUP BY EducationLevel
ORDER BY EducationLevel;

SELECT
    CASE
        WHEN ExperienceYears BETWEEN 0  AND 2  THEN '0-2 yrs  (Junior)'
        WHEN ExperienceYears BETWEEN 3  AND 5  THEN '3-5 yrs  (Mid)'
        WHEN ExperienceYears BETWEEN 6  AND 10 THEN '6-10 yrs (Senior)'
        ELSE                                        '11+ yrs  (Expert)'
    END                                                              AS experience_band,
    COUNT(*)                                                         AS total,
    SUM(HiringDecision)                                             AS hires,
    ROUND(SUM(HiringDecision) * 100.0 / COUNT(*), 1)                AS hire_rate_pct,
    ROUND(AVG(InterviewScore), 1)                                    AS avg_interview_score
FROM recruitment_data
GROUP BY experience_band
ORDER BY MIN(ExperienceYears);


-- ──────────────────────────────────────────────────────────────
-- 8. ADVANCED / BONUS QUERIES
-- ──────────────────────────────────────────────────────────────

-- Top 10 highest-scoring candidates NOT hired (potential mis-decisions)
SELECT
    CandidateID, Age, ExperienceYears,
    InterviewScore, SkillScore, PersonalityScore,
    CASE RecruitmentStrategy WHEN 1 THEN 'LinkedIn' WHEN 2 THEN 'Referral' ELSE 'Job Board' END AS source,
    Funnel_Stage_Drop
FROM recruitment_data
WHERE HiringDecision = 0
ORDER BY (InterviewScore + SkillScore + PersonalityScore) DESC
LIMIT 10;

-- Running monthly cumulative hires
SELECT
    Month,
    SUM(HiringDecision)                                              AS monthly_hires,
    SUM(SUM(HiringDecision)) OVER (ORDER BY MIN(Application_Date))  AS cumulative_hires
FROM recruitment_data
GROUP BY Month
ORDER BY MIN(Application_Date);

-- Referral vs Job Board statistical gap (proves the 40% insight)
SELECT 'Referral'  AS source, ROUND(AVG(Days_to_Offer),1) AS avg_days, ROUND(MIN(Days_to_Offer),1) AS min_days, ROUND(MAX(Days_to_Offer),1) AS max_days FROM recruitment_data WHERE RecruitmentStrategy = 2
UNION ALL
SELECT 'Job Board' AS source, ROUND(AVG(Days_to_Offer),1), ROUND(MIN(Days_to_Offer),1), ROUND(MAX(Days_to_Offer),1) FROM recruitment_data WHERE RecruitmentStrategy = 3;

-- ──────────────────────────────────────────────────────────────
-- END OF SCRIPT
-- ──────────────────────────────────────────────────────────────
