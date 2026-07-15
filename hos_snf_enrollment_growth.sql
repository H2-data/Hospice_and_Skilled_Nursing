-- Active: 1780043201174@@127.0.0.1@3306@hos_snf
DROP VIEW v_hos_enrollment_state_growth;

-- What if there WERE nulls? What would I do in that situation? Just kinda, leave them in? Turn them into zeros?
-- I can't put in 'incomplete data' because Im pretty sure it would screw up my data type and calculations later.

CREATE VIEW v_hos_enrollment_state_growth AS
SELECT
	`ENROLLMENT STATE`,
	COUNT(CASE WHEN DATE = '01/2025' THEN `ENROLLMENT STATE` END) AS Jan_2025,
    COUNT(CASE WHEN DATE = '10/2025' THEN `ENROLLMENT STATE` END) AS Oct_2025,
	(COUNT(CASE WHEN DATE = '10/2025' THEN `ENROLLMENT STATE` END) - COUNT(CASE WHEN DATE = '01/2025' THEN `ENROLLMENT STATE` END)) AS raw_growth
 FROM hospice_enrollments
 GROUP BY `ENROLLMENT STATE`;
 
SELECT 
    * 
FROM v_hos_enrollment_state_growth
ORDER BY raw_growth DESC;

-- When compared to the millions of Medicare beneficiaries and hundreds of thousands of hospice care enrolles, the growth shown is insignificant.
-- Now I'll run the same code for Skilled Nursing facilities.

DROP VIEW v_snf_enrollment_state_growth;

CREATE VIEW v_snf_enrollment_state_growth AS
SELECT
	`ENROLLMENT STATE`,
	COUNT(CASE WHEN DATE = '01/2025' THEN `ENROLLMENT STATE` END) AS Jan_2025,
    COUNT(CASE WHEN DATE = '12/2025' THEN `ENROLLMENT STATE` END) AS Dec_2025,
	(COUNT(CASE WHEN DATE = '12/2025' THEN `ENROLLMENT STATE` END) - COUNT(CASE WHEN DATE = '01/2025' THEN `ENROLLMENT STATE` END)) AS raw_growth
 FROM snf_enrollments
 GROUP BY `ENROLLMENT STATE`;
 
SELECT 
    * 
FROM v_snf_enrollment_state_growth
ORDER BY raw_growth DESC;