Create Database `Insurence_analysis`;
use `Insurence_analysis`;
Show tables;
USE `Insurence_analysis`;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'insurance_analysis'
AND REFERENCED_TABLE_NAME IS NOT NULL;

SHOW TABLES;
DESCRIBE `dim clientcsv`;
DESCRIBE `dim_policy  csv`;
DESCRIBE `dim  accoount   csv`;
DESCRIBE `dim_solution csv`;
DESCRIBE `dim branch   csv`;
DESCRIBE `brokerage csv`;
ALTER TABLE `dim branch   csv`
MODIFY `Branch ID` VARCHAR(50) NOT NULL;

ALTER TABLE `dim branch   csv`
ADD PRIMARY KEY (`Branch ID`);

SELECT `Branch ID`, COUNT(*)
FROM `dim branch   csv`
GROUP BY `Branch ID`
HAVING COUNT(*) > 1;

SELECT *
FROM `dim branch   csv`;

SELECT `Branch Head ID`, COUNT(*)
FROM `dim branch   csv`
GROUP BY `Branch Head ID`;

ALTER TABLE `dim branch   csv`
MODIFY `Branch Head ID` INT NOT NULL;

ALTER TABLE `dim branch   csv`
ADD PRIMARY KEY (`Branch Head ID`);

DESCRIBE `dim branch   csv`;

SELECT `Solution Group ID`, COUNT(*)
FROM `dim_solution csv`
GROUP BY `Solution Group ID`;

ALTER TABLE `dim_solution csv`
MODIFY `Solution Group ID` VARCHAR(50) NOT NULL;

ALTER TABLE `dim_solution csv`
ADD PRIMARY KEY (`Solution Group ID`);

DESCRIBE `dim_solution csv`;

DESCRIBE `dim  accoount   csv`;

SELECT `Account ID`, COUNT(*)
FROM `dim  accoount   csv`
GROUP BY `Account ID`
HAVING COUNT(*) > 1;
SELECT `Account Exe ID`, COUNT(*)
FROM `dim  accoount   csv`
GROUP BY `Account Exe ID`
HAVING COUNT(*) > 1;

ALTER TABLE `dim  accoount   csv`
MODIFY `Account Exe ID` INT NOT NULL;

ALTER TABLE `dim  accoount   csv`
ADD PRIMARY KEY (`Account Exe ID`);
DESCRIBE`dim  accoount   csv`;

DESCRIBE `dim clientcsv`;

DESCRIBE `dim_policy  csv`;
DESCRIBE `fees csv`;

SELECT `Account Exe ID`, COUNT(*)
FROM `fees csv`
GROUP BY `Account Exe ID`
HAVING COUNT(*) > 1;

SELECT Amount, COUNT(*)
FROM `fees csv`
GROUP BY Amount
HAVING COUNT(*) > 1;

SELECT COUNT(*)
FROM  `fees csv` f
LEFT JOIN `dim  accoount   csv`  a
ON f.`Account Exe ID` = a.`Account Exe ID`
WHERE a.`Account Exe ID` IS NULL;

ALTER TABLE `fees csv`
ADD CONSTRAINT fk_fees_account
FOREIGN KEY (`Account Exe ID`)
REFERENCES `dim  accoount   csv` (`Account Exe ID`);

SHOW CREATE TABLE `fees csv`;
SHOW CREATE TABLE `fees csv`;
