USE employee_attrition_db;


-- =========================================================
-- 1. TOTAL NUMBER OF EMPLOYEES
-- =========================================================

SELECT COUNT(*) AS total_employees
FROM employee_attrition;


-- =========================================================
-- 2. ATTRITION DISTRIBUTION
-- =========================================================

SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Attrition;


-- =========================================================
-- 3. ATTRITION RATE
-- =========================================================

SELECT
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate_percent
FROM employee_attrition;


-- =========================================================
-- 4. ATTRITION BY DEPARTMENT
-- =========================================================

SELECT
    Department,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Department, Attrition
ORDER BY Department, Attrition;


-- =========================================================
-- 5. ATTRITION BY JOB ROLE
-- =========================================================

SELECT
    JobRole,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY JobRole, Attrition
ORDER BY JobRole, Attrition;


-- =========================================================
-- 6. ATTRITION BY OVERTIME
-- =========================================================

SELECT
    OverTime,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY OverTime, Attrition
ORDER BY OverTime, Attrition;


-- =========================================================
-- 7. ATTRITION BY BUSINESS TRAVEL
-- =========================================================

SELECT
    BusinessTravel,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY BusinessTravel, Attrition
ORDER BY BusinessTravel, Attrition;


-- =========================================================
-- 8. ATTRITION BY JOB SATISFACTION
-- =========================================================

SELECT
    JobSatisfaction,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY JobSatisfaction, Attrition
ORDER BY JobSatisfaction, Attrition;


-- =========================================================
-- 9. ATTRITION BY JOB LEVEL
-- =========================================================

SELECT
    JobLevel,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY JobLevel, Attrition
ORDER BY JobLevel, Attrition;


-- =========================================================
-- 10. AGE GROUP ANALYSIS
-- =========================================================

SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    Attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END,
    Attrition
ORDER BY age_group, Attrition;