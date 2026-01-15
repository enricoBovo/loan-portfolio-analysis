-- =================================================================
-- SEGMENTATION ANALYSIS
-- Dataset: bank_loan_data
-- Scope: Loan portfolio segmentation for dashboard analysis
-- =================================================================


-- =================================================================
-- (1) MONTHLY TRENDS BY ISSUE DATE
-- Aggregated KPIs by calendar month
-- =================================================================

SELECT 
    MONTH(issue_date) AS Month_Number,                   -- Month number (1–12)
    DATENAME(MONTH, issue_date) AS Month_Name,           -- Month name
    COUNT(id) AS Total_Loan_Applications,                -- Number of loan applications
    SUM(loan_amount) AS Total_Funded_Amount,             -- Total funded amount
    SUM(total_payment) AS Total_Amount_Received          -- Total amount received
FROM bank_loan_data
GROUP BY 
    MONTH(issue_date),
    DATENAME(MONTH, issue_date)
ORDER BY 
    Month_Number;


-- =================================================================
-- (2) SEGMENTATION BY STATE
-- =================================================================

SELECT 
    address_state AS State,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY Total_Funded_Amount DESC;


-- =================================================================
-- (3) SEGMENTATION BY LOAN TERM
-- =================================================================

SELECT 
    term AS Loan_Term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY Loan_Term;


-- =================================================================
-- (4) SEGMENTATION BY EMPLOYMENT LENGTH
-- =================================================================

SELECT 
    emp_length AS Employment_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC;


-- =================================================================
-- (5) SEGMENTATION BY LOAN PURPOSE
-- =================================================================

SELECT 
    purpose AS Loan_Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC;


-- =================================================================
-- (6) SEGMENTATION BY HOME OWNERSHIP
-- =================================================================

SELECT 
    home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;