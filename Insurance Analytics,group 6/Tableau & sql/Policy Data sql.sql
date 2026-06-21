create database Policy_Data;
use Policy_Data;
show tables;
select * from `additional_fields`; 
select * from claims;
select * from `customer_information`;
select * from `payment_history`;
select * from `policy_data`;

-- rename all the table


rename table `additional fields` to additional_fields;
rename table `customer information` to `customer_information`;
rename table `payment history` to `payment_history`;
rename table `polic_data` to `policy_data`;

-- fixing the column name and data types

alter table  `additional_fields` change column `ï»¿Agent ID` Agent_ID varchar(255);
alter table claims change column `ï»¿Claim ID` Claim_ID varchar(255);
alter table customer_information change column `ï»¿Customer ID` Customer_ID varchar(255);
alter table payment_history change column `ï»¿Payment ID` Payment_ID varchar(255);
alter table policy_data change column `ï»¿Policy ID` Policy_ID varchar(255);

desc additional_fields;	
desc claims;
desc `customer_information`;
desc `payment_history`;
desc `policy_data`;
desc `additional_fields`;
desc claims;

-- fixing all column data type from customer_informantion

alter table customer_information modify column Name varchar(100);
alter table customer_information modify column Gender varchar(50);
alter table customer_information modify column Age int unsigned;
alter table customer_information modify column `Marital Status` varchar(50);
alter table customer_information modify column Occupation varchar(100);
alter table customer_information modify column `Address (City, State, Zip Code)` varchar (100);

-- fixing all the column from claims
SET SQL_SAFE_UPDATES = 0;
alter table claims modify column `Date of Claim` date;
alter table claims modify column `claim status` varchar(50);
alter table claims modify column `Reason for Claim` varchar(100);
SELECT COUNT(*) FROM claims WHERE `Settlement Date` IS NULL;
UPDATE claims SET `Settlement Date` = NULL WHERE TRIM(`Settlement Date`) = '';
alter table claims modify column `Settlement Date` date;
alter table claims modify column `Policy ID` varchar(100);
alter table claims modify column `Claim Amount` int unsigned;

-- fixing all the column from additional_fields
alter table additional_fields modify column `Renewal Status` varchar(50);
alter table additional_fields modify column `Policy ID` varchar(100);

-- fixing all the column from `payment_history`
alter table payment_history modify column `Policy ID` varchar(100);
alter table payment_history modify column `Payment Status` varchar(50);
alter table payment_history modify column `Payment Method` varchar(50);
alter table payment_history modify column `Date of Payment` date;
alter table payment_history modify column `Amount Paid` int unsigned;

-- fixing all the column from `policy_data`
alter table policy_data modify column `Policy Type` varchar(50);
alter table policy_data modify column `Payment Frequency` varchar(50);
alter table policy_data modify column `Status` varchar(50);
alter table policy_data modify column `Customer ID` varchar(100);
alter table policy_data modify column `Coverage Amount` int unsigned;
alter table policy_data modify column `Premium Amount` decimal(12,5);
alter table policy_data modify column `Policy Start Date` date;
alter table policy_data modify column `Policy End Date` date;

-- Check duplicates and blanks first

SELECT Customer_ID, COUNT(*) FROM customer_information
GROUP BY Customer_ID HAVING COUNT(*) > 1;

SELECT * FROM customer_information WHERE Customer_ID IS NULL OR TRIM(Customer_ID) = '';

select Claim_ID,count(*) from claims group by Claim_ID having count(*) > 1;

SELECT * FROM claims WHERE claim_id IS NULL OR TRIM(claim_id) = '';

SELECT Agent_ID, COUNT(*) FROM additional_fields
GROUP BY Agent_ID HAVING COUNT(*) > 1;


SELECT * FROM additional_fields WHERE Agent_ID IS NULL OR TRIM(Agent_ID) = '';

SELECT Payment_ID, COUNT(*) FROM payment_history
GROUP BY Payment_ID HAVING COUNT(*) > 1;

SELECT * FROM payment_history WHERE Payment_ID IS NULL OR TRIM(Payment_ID) = '';

SELECT Policy_ID, COUNT(*) FROM policy_data
GROUP BY Policy_ID HAVING COUNT(*) > 1;

SELECT * FROM policy_data WHERE Policy_ID IS NULL OR TRIM(Policy_ID) = '';

-- Create Primary Keys

ALTER TABLE customer_information
ADD PRIMARY KEY (Customer_ID);

ALTER TABLE policy_data
ADD PRIMARY KEY (Policy_ID);

ALTER TABLE claims
ADD PRIMARY KEY (Claim_ID);

ALTER TABLE payment_history
ADD PRIMARY KEY (Payment_ID);

-- Create Foreign Keys

-- policy_details → customer_information

ALTER TABLE policy_data
ADD CONSTRAINT fk_policy_customer
FOREIGN KEY (`Customer ID`)
REFERENCES `customer_information`(Customer_ID);

-- claims → policy_details

ALTER TABLE claims
ADD CONSTRAINT fk_claims_policy
FOREIGN KEY (`Policy ID`)
REFERENCES policy_data(Policy_ID);


-- payment_history → policy_details

ALTER TABLE payment_history
ADD CONSTRAINT fk_payment_policy
FOREIGN KEY (`Policy ID`)
REFERENCES policy_data(Policy_ID);

-- additional_fields → policy_details

ALTER TABLE additional_fields
ADD CONSTRAINT fk_additional_policy
FOREIGN KEY (`Policy ID`)
REFERENCES policy_data(Policy_ID);

-- KPIS

-- Total Policies

SELECT COUNT(DISTINCT Policy_ID) AS Total_Policies
FROM policy_data;

-- Total Customers

SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM customer_information;

-- Total Premium Amount

SELECT SUM(`Premium Amount`) AS Total_Premium
FROM policy_data;

-- Total Coverage Amount

SELECT SUM(`Coverage Amount`) AS Total_Coverage
FROM policy_data;

-- Policy Type Distribution

SELECT `Policy Type`,
       COUNT(Policy_ID) AS Total_Policies
FROM policy_data
GROUP BY `Policy Type`
ORDER BY Total_Policies DESC;

-- Policy Status Distribution

SELECT Status,
       COUNT(Policy_ID) AS Total_Policies
FROM policy_data
GROUP BY Status
ORDER BY Total_Policies DESC;

-- Gender Wise Policy Count

SELECT Gender,
       COUNT(Customer_ID) AS Total_Customers
FROM customer_information
GROUP BY Gender;

-- Claim Status Analysis

SELECT `claim status`,
       COUNT(Claim_ID) AS Total_Claims
FROM claims
GROUP BY `claim status`;

-- Payment Frequency Analysis

SELECT `Payment Frequency`,
       COUNT(Policy_ID) AS Total_Policies
FROM policy_data
GROUP BY `Payment Frequency`;

-- Total Claim Amount

SELECT SUM(`Claim Amount`) AS Total_Claim_Amount
FROM claims;