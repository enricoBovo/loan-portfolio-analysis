-- =================================================================
-- GOOD vs BAD LOANS ANALYSIS
-- Dataset: bank_loan_data
--
-- Loan Status definitions:
--  - Good Loans: 'Fully Paid', 'Current'
--  - Bad Loans : 'Charged Off'
-- =================================================================


-- =================================================================
-- (1) KPI BY LOAN STATUS
-- Aggregated metrics grouped by loan_status
-- =================================================================

SELECT 
    loan_status,
    COUNT(id) AS Total_Loan_Applications,         -- Number of loan applications
    SUM(total_payment) AS Total_Amount_Received,  -- Total amount received
    SUM(loan_amount) AS Total_Funded_Amount,      -- Total funded amount
    ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate,  -- Avg interest rate (%)
    ROUND(AVG(dti) * 100, 2) AS Avg_DTI                  -- Avg DTI (%)
FROM bank_loan_data
GROUP BY loan_status;


-- =================================================================
-- (2) GOOD LOANS KPIs
-- Good loans are defined as: Fully Paid or Current
-- =================================================================

-- Percentage of good loans over total loan applications
SELECT 
    COUNT(CASE 
            WHEN loan_status IN ('Fully Paid', 'Current') 
            THEN id 
         END) * 100.0 
    / NULLIF(COUNT(id), 0) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Total number of good loan applications
SELECT 
    COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Total funded amount for good loans
SELECT 
    SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Total amount received from good loans
SELECT 
    SUM(total_payment) AS Good_Loan_Received_Amount
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');


-- =================================================================
-- (3) BAD LOANS KPIs
-- Bad loans are defined as: Charged Off
-- =================================================================

-- Percentage of bad loans over total loan applications
SELECT 
    COUNT(CASE 
            WHEN loan_status = 'Charged Off' 
            THEN id 
         END) * 100.0 
    / NULLIF(COUNT(id), 0) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Total number of bad loan applications
SELECT 
    COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Total funded amount for bad loans
SELECT 
    SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Total amount received from bad loans
SELECT 
    SUM(total_payment) AS Bad_Loan_Received_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';