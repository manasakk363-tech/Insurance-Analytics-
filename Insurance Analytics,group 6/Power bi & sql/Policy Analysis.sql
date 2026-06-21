
USE policy_analysis;

-- 1. MASTER VIEW (MAIN DATASET)

CREATE OR REPLACE VIEW insurance_master AS
SELECT 
    -- POLICY
    p.Policy_ID,
    p.Policy_Type,
    p.Coverage_Amount,
    p.Premium_Amount,
    p.Policy_Start_Date,
    p.Policy_End_Date,
    p.Payment_Frequency,
    p.Status AS Policy_Status,

    -- CLAIMS
    c.Claim ID,
    c.Date_of_Claim,
    c.Claim_Amount,
    c.Claim_Status,
    c.Reason_for_Claim,
    c.Settlement_Date,

    -- CUSTOMER
    cust.Customer_ID,
    cust.Name,
    cust.Gender,
    cust.Age,
    cust.Occupation,
    cust.Marital_Status,
    cust.Address,

    -- PAYMENTS
    pay.Payment_ID,
    pay.Date_of_Payment,
    pay.Amount_Paid,
    pay.Payment_Method,
    pay.Payment_Status,

    -- ADDITIONAL
    a.Agent_ID,
    a.Renewal_Status,
    a.Policy_Discounts,
    a.Risk_Score

FROM policy_details p

LEFT JOIN claims c 
    ON p.Policy_ID = c.Policy_ID

LEFT JOIN customer_information cust 
    ON p.Customer_ID = cust.Customer_ID



LEFT JOIN additional_fields a 
    ON p.Policy_ID = a.Policy_ID;

-- 2. KPI QUERIES

-- TOTAL PREMIUM
SELECT SUM(Premium_Amount) AS total_premium
FROM policy_details;

-- TOTAL CLAIMS
SELECT SUM(`Claim Amount`) AS total_claim_amount
FROM claims;

-- TOTAL PAYMENTS
SELECT SUM(`Amount Paid`) AS total_payments
FROM `payment history`;

-- CLAIM RATIO
SELECT 
    SUM(c.`Claim Amount`) / SUM(p.Premium_Amount) AS claim_ratio
FROM policy_details p
JOIN claims c 
ON p.Policy_ID = c.`Policy ID`;


-- 3. POLICY ANALYSIS

-- POLICY TYPE PERFORMANCE
SELECT 
    Policy_Type,
    COUNT(*) AS total_policies,
    SUM(Premium_Amount) AS total_premium
FROM policy_details
GROUP BY Policy_Type;

-- ACTIVE vs INACTIVE POLICIES
SELECT 
    Status,
    COUNT(*) AS total
FROM policy_details
GROUP BY Status;

-- 4. CLAIM ANALYSIS

-- CLAIM STATUS BREAKDOWN
SELECT 
    `Claim Status`,
    COUNT(*) AS total_claims,
    SUM(`Claim Amount`) AS total_amount
FROM claims
GROUP BY `Claim Status`;

-- CLAIM REASON ANALYSIS
SELECT 
    `Reason for Claim`,
    COUNT(*) AS total_cases
FROM claims
GROUP BY `Reason for Claim`
ORDER BY total_cases DESC;

-- CLAIM SETTLEMENT TIME (IN DAYS)
SELECT 
    `Claim ID`,
    DATEDIFF(`Settlement Date`, `Date of Claim`) AS settlement_days
FROM claims;


-- 5. CUSTOMER ANALYSIS

-- AGE GROUP ANALYSIS
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 40 THEN '25-40'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_customers
FROM customer_information
GROUP BY age_group;

-- GENDER DISTRIBUTION
SELECT 
    Gender,
    COUNT(*) AS total
FROM customer_information
GROUP BY Gender;

-- 6. PAYMENT ANALYSIS


-- PAYMENT METHOD USAGE
SELECT 
    `Payment Method`,
    SUM(`Amount Paid`) AS total_amount
FROM `payment history`
GROUP BY `Payment Method`;

-- PAYMENT STATUS
SELECT 
    `Payment Status`,
    COUNT(*) AS total_transactions
FROM `payment history`
GROUP BY `Payment Status`;

-- =========================================
-- 7. RISK & BUSINESS ANALYSIS
-- =========================================

-- RISK SCORE ANALYSIS
SELECT 
    Risk_Score,
    COUNT(*) AS total_policies
FROM additional_fields
GROUP BY Risk_Score
ORDER BY Risk_Score DESC;

-- RENEWAL STATUS
SELECT 
    Renewal_Status,
    COUNT(*) AS total
FROM additional_fields
GROUP BY Renewal_Status;

-- 8. TREND ANALYSIS


-- YEAR-WISE PREMIUM VS CLAIM
SELECT 
    YEAR(p.Policy_Start_Date) AS year,
    SUM(p.Premium_Amount) AS total_premium,
    SUM(c.Claim_Amount) AS total_claim
FROM policy_details p
LEFT JOIN claims c 
    ON p.Policy_ID = c.Policy_ID
GROUP BY YEAR(p.Policy_Start_Date);

-- PAYMENT TREND
SELECT 
    YEAR(`Date of Payment`) AS year,
    SUM(`Amount Paid`) AS total_payment
FROM `payment history`
GROUP BY YEAR(`Date of Payment`);


-- TOP CUSTOMERS BY PREMIUM
SELECT 
    cust.Name,
    SUM(p.Premium_Amount) AS total_premium,
    RANK() OVER (ORDER BY SUM(p.Premium_Amount) DESC) AS rank_no
FROM policy_details p
JOIN customer_information cust 
    ON p.Customer_ID = cust.Customer_ID
GROUP BY cust.Name;

-- HIGH RISK POLICIES
SELECT *
FROM additional_fields
WHERE `Risk Score` > 80;
