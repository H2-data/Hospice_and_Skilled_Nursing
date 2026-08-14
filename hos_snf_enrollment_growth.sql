-- Active: 1780043201174@@127.0.0.1@3306@hos_snf

WITH hos_growth AS (
SELECT
	`ENROLLMENT STATE`,
	COUNT(CASE WHEN DATE = '01/2025' THEN `ENROLLMENT STATE` END) AS Jan_2025,
    COUNT(CASE WHEN DATE = '10/2025' THEN `ENROLLMENT STATE` END) AS Oct_2025
FROM hospice_enrollments
GROUP BY `ENROLLMENT STATE`
)
SELECT
	`ENROLLMENT STATE`,
	Jan_2025,
	Oct_2025,
	Oct_2025 - Jan_2025 AS raw_growth
 FROM hos_growth
 GROUP BY `ENROLLMENT STATE`;

SELECT
	`ENROLLMENT STATE`,
	COUNT(*) AS no_of_enrollments
FROM hospice_enrollments
WHERE `ENROLLMENT STATE` = 'CA'
AND `DATE` IN ('01/2025', '10/2025');

-- The California count data matches the Jan_2025 + Oct_2025 data of the previous query.

WITH snf_growth AS (
SELECT
	`ENROLLMENT STATE`,
	COUNT(CASE WHEN DATE = '01/2025' THEN `ENROLLMENT STATE` END) AS Jan_2025,
    COUNT(CASE WHEN DATE = '12/2025' THEN `ENROLLMENT STATE` END) AS Dec_2025
FROM snf_enrollments
GROUP BY `ENROLLMENT STATE`
)
SELECT
	`ENROLLMENT STATE`,
	Jan_2025,
	Dec_2025,
	Dec_2025 - Jan_2025 AS raw_growth
 FROM snf_growth
 GROUP BY `ENROLLMENT STATE`;

 -- Sanity Check

SELECT
	`ENROLLMENT STATE`,
	COUNT(*) AS no_of_enrollments
FROM snf_enrollments
WHERE `ENROLLMENT STATE` = 'CA'
AND `DATE` IN ('01/2025', '12/2025');

-- The California count data matches the Jan_2025 + Oct_2025 data of the previous query.
