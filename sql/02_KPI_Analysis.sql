-- =================================================================
-- KPI CALCULATION
-- Dataset: bank_loan_data
-- Scope: KPI computation for dashboarding (Power BI)
-- Period reference: Nov 2021 (PMTD) vs Dec 2021 (MTD)
-- =================================================================

-- =================================================================
-- (1) TOTAL LOAN APPLICATIONS
-- Definition: total number of loan applications (count of loan IDs)
-- =================================================================

-- Overall total loan applications (entire dataset)
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data;

-- Month-To-Date (MTD): loan applications issued in December 2021
SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;

-- Previous Month-To-Date (PMTD): loan applications issued in November 2021
SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11
  AND YEAR(issue_date) = 2021;

-- Month-over-Month (MoM) growth rate for total loan applications
-- Formula: (MTD - PMTD) / PMTD
-- NULLIF prevents division by zero
SELECT (MTD - PMTD) * 1.0 / NULLIF(PMTD, 0) AS MoM_Total_Loan_Applications
FROM (
    SELECT
        COUNT(CASE 
                WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN id 
             END) AS MTD,
        COUNT(CASE 
                WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN id 
             END) AS PMTD
    FROM bank_loan_data
) t;


-- =================================================================
-- (2) TOTAL FUNDED AMOUNT
-- Definition: total amount of money funded through loans
-- =================================================================

-- Overall total funded amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data;

-- MTD total funded amount (December 2021)
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;

-- PMTD total funded amount (November 2021)
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11
  AND YEAR(issue_date) = 2021;

-- MoM growth rate of total funded amount
SELECT (MTD - PMTD) * 1.0 / NULLIF(PMTD, 0) AS MoM_Total_Funded_Amount
FROM (
    SELECT
        SUM(CASE 
                WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN loan_amount 
             END) AS MTD,
        SUM(CASE 
                WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN loan_amount
             END) AS PMTD
    FROM bank_loan_data
) t;


-- =================================================================
-- (3) TOTAL AMOUNT RECEIVED
-- Definition: total payments received from borrowers
-- =================================================================

-- Overall total amount received
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data;

-- MTD total amount received (December 2021)
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;

-- PMTD total amount received (November 2021)
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 11
  AND YEAR(issue_date) = 2021;

-- MoM growth rate of total amount received
SELECT (MTD - PMTD) * 1.0 / NULLIF(PMTD, 0) AS MoM_Total_Amount_Received
FROM (
    SELECT
        SUM(CASE 
                WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN total_payment
             END) AS MTD,
        SUM(CASE 
                WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN total_payment
             END) AS PMTD
    FROM bank_loan_data
) t;


-- =================================================================
-- (4) AVERAGE INTEREST RATE
-- Definition: average interest rate across loans
-- Expressed as percentage
-- =================================================================

-- Overall average interest rate
SELECT ROUND(AVG(int_rate), 4) * 100 AS Avg_Interest_Rate
FROM bank_loan_data;

-- MTD average interest rate (December 2021)
SELECT ROUND(AVG(int_rate), 4) * 100 AS MTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;

-- PMTD average interest rate (November 2021)
SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11
  AND YEAR(issue_date) = 2021;

-- MoM change in average interest rate
SELECT ROUND((MTD - PMTD) * 1.0 / NULLIF(PMTD, 0),4) * 100 AS MoM_Avg_Interest_Rate
FROM (
    SELECT
        AVG(CASE 
                WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN int_rate 
             END) AS MTD,
        AVG(CASE 
                WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN int_rate 
             END) AS PMTD
    FROM bank_loan_data
) t;


-- =================================================================
-- (5) DEBT-TO-INCOME RATIO (DTI)
-- Definition: average borrower DTI
-- Expressed as percentage
-- =================================================================

-- Overall average DTI
SELECT ROUND(AVG(dti), 4) * 100 AS Avg_DTI
FROM bank_loan_data;

-- MTD average DTI (December 2021)
SELECT ROUND(AVG(dti), 4) * 100 AS MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;

-- PMTD average DTI (November 2021)
SELECT ROUND(AVG(dti), 4) * 100 AS PMTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11
  AND YEAR(issue_date) = 2021;

-- MoM change in average DTI
SELECT ROUND((MTD - PMTD) * 1.0 / NULLIF(PMTD, 0),4) * 100 AS MoM_Avg_DTI
FROM (
    SELECT
        AVG(CASE 
                WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN dti 
             END) AS MTD,
        AVG(CASE 
                WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN dti 
             END) AS PMTD
    FROM bank_loan_data
) t;
