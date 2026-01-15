-- =================================================================
-- DATA OVERVIEW
-- Dataset: bank_loan_data
-- Scope: High-level summary of the dataset before analysis
-- =================================================================

SELECT
    COUNT(id) AS Total_Loan_Applications,                 -- Total number of loan applications
    COUNT(DISTINCT id) AS Unique_Loan_IDs,                -- Unique loan identifiers
    MIN(issue_date) AS First_Issue_Date,                  -- Earliest loan issue date
    MAX(issue_date) AS Last_Issue_Date,                   -- Latest loan issue date
    MIN(loan_amount) AS Min_Loan_Amount,                  -- Smallest loan issued
    MAX(loan_amount) AS Max_Loan_Amount,                  -- Largest loan issued
    ROUND(AVG(loan_amount), 2) AS Avg_Loan_Amount,        -- Average loan amount
    ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate,   -- Average interest rate (%)
    ROUND(AVG(dti) * 100, 2) AS Avg_DTI                   -- Average debt-to-income ratio (%)
FROM bank_loan_data;


-- =================================================================
-- LOAN STATUS DISTRIBUTION
-- =================================================================

SELECT
    loan_status,
    COUNT(id) AS Total_Loan_Applications,
    COUNT(id) * 100.0 / NULLIF(SUM(COUNT(id)) OVER (), 0) AS Percentage
FROM bank_loan_data
GROUP BY loan_status
ORDER BY Total_Loan_Applications DESC;

