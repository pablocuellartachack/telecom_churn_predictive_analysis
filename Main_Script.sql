CREATE DATABASE telecom_churn;

LOAD DATA INFILE 'C:\Users\Pablo\Desktop\Analysis_Projects\Telecom_Customer_Churn\Raw_Data'
INTO TABLE raw_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

SELECT *
FROM raw_data;

SELECT count(*)
FROM raw_data
WHERE churn = 'No';

SELECT count(*)
FROM raw_data
WHERE churn = 'Yes';

# Percentage breakdown of churn vs no-churn
CREATE VIEW Churn_Breakdown_Overview AS
SELECT
    COUNT(customerID) AS Total_Group_Count,
	SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
    ROUND(SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Active_Percentage,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Churn_Percentage
FROM 
    raw_data;
    
# Percentage breakdown of churn vs no-churn by GENDER
CREATE VIEW Churn_By_Gender AS
SELECT 
    gender,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

# Percentage breakdown of churn vs no-churn by SeniorCitizen
CREATE VIEW Churn_By_SeniorCitizen AS
SELECT 
    SeniorCitizen,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;
    
# Percentage breakdown of churn vs no-churn by Partner
CREATE VIEW Churn_By_Partner AS
SELECT 
    Partner,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;
    
# Percentage breakdown of churn vs no-churn by DEPENDANTS
CREATE VIEW Churn_By_Dependents AS
SELECT 
    Dependents,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

# Percentage breakdown of churn vs no-churn by TENURE
CREATE VIEW Churn_By_Tenure AS
SELECT 
    tenure,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

# Percentage breakdown of churn vs no-churn by SERVICE TYPES
CREATE VIEW Churn_By_PhoneService AS
SELECT 
    PhoneService,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_MultipleLines AS
SELECT 
    MultipleLines,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_InternetService AS
SELECT 
    InternetService,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_OnlineSecurity AS
SELECT 
    OnlineSecurity,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_OnlineBackup AS
SELECT 
    OnlineBackup,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_DeviceProtection AS
SELECT 
    DeviceProtection,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_TechSupport AS
SELECT 
    TechSupport,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_StreamingTV AS
SELECT 
    StreamingTV,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_StreamingMovies AS
SELECT 
    StreamingMovies,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;
    
# Percentage breakdown of churn vs no-churn by CONTRACT, PAYMENT TYPES, AND CHARGES
CREATE VIEW Churn_By_Contract AS
SELECT 
    Contract,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_PaperlessBilling AS
SELECT 
    PaperlessBilling,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;

CREATE VIEW Churn_By_PaymentMethod AS
SELECT 
    PaymentMethod,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;
    
CREATE VIEW Churn_By_MonthlyCharges AS
SELECT 
	CONCAT(FLOOR(MonthlyCharges/10)*10, '-', FLOOR(MonthlyCharges/10)*10 + 10) AS MonthlyCharge_Range,
    ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
    COUNT(customerID) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
    raw_data
GROUP BY 
    1
ORDER BY
	5 DESC, 6 DESC;
    

    
### Complete aggregate breakdown of churn vs non-churn by a mix of different "features" ###

# Exploratory findings
SELECT *
FROM churn_breakdown_overview;

SELECT *
FROM churn_by_gender;

SELECT SUM(Churn_Count) As t
FROM churn_by_tenure
WHERE tenure Between 1 and 18
ORDER BY 1;

SELECT *
FROM churn_by_deviceprotection;

SELECT *
FROM churn_by_dependents;

SELECT *
FROM churn_by_seniorcitizen;

SELECT *
FROM churn_by_partner;

SELECT *
FROM churn_by_contract;

SELECT *
FROM churn_by_monthlycharges;

SELECT *
FROM churn_by_paymentmethod;

SELECT *
FROM churn_by_internetservice;

SELECT *
FROM raw_data;

# Percentage breakdown of churn vs no-churn by certain societal features such as GENDER, DEPENDENT, PARTNER, aswell as TENURE, and CONTRACT
CREATE TABLE General_Customer_Churn AS
SELECT 
	gender,
	Dependents,
	Partner,
	tenure,
	Contract,
	ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
	COUNT(customerID) AS Total_Group_Count,
	SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
	raw_data
WHERE
	SeniorCitizen = '0' AND tenure BETWEEN 1 and 18
GROUP BY 
	1, 2, 3, 4, 5
ORDER BY
	9 DESC, 10 DESC
LIMIT 20;

# Percentage breakdown of churn vs no-churn by SENIORCITIZEN primarily
CREATE TABLE Senior_Citizen_Churn AS
SELECT 
	PhoneService,
	InternetService,
	TechSupport,
	StreamingTV,
	StreamingMovies,
	CONCAT(FLOOR(MonthlyCharges/10)*10, '-', FLOOR(MonthlyCharges/10)*10 + 10) AS MonthlyCharge_Range,
	ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
	COUNT(customerID) AS Total_Group_Count,
	SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Group_Churn_Percent
FROM 
	raw_data
WHERE
	SeniorCitizen = '1'
GROUP BY 
	1, 2, 3, 4, 5, 6
ORDER BY
	10 DESC, 11 DESC
LIMIT 20;

# Percentage breakdown of churn vs no-churn by SERVICE's primarily
CREATE TABLE Service_Type_Churn AS
SELECT 
	InternetService,
	OnlineSecurity,
	OnlineBackup,
	DeviceProtection,
	TechSupport,
	StreamingTv,
	StreamingMovies,
	ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
	COUNT(customerID) AS Total_Group_Count,
	SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Churn_Rate
FROM 
	raw_data
WHERE
	SeniorCitizen = '0'
GROUP BY 
	1, 2, 3, 4, 5, 6, 7
ORDER BY
	11 DESC, 12 DESC
LIMIT 20;

select *
from service_type_churn;

# Percentage breakdown of churn vs no-churn by PAYMENT's primarily
CREATE TABLE Payment_Type_Churn AS
SELECT
	CONCAT(FLOOR(MonthlyCharges/10)*10, '-', FLOOR(MonthlyCharges/10)*10 + 10) AS MonthlyCharge_Range,
	Contract,
	PaperlessBilling,
	PaymentMethod,
	ROUND(COUNT(customerID) / (SELECT COUNT(customerID) FROM raw_data) * 100, 2) AS Percent_Of_Population,
	ROUND(COUNT(customerID)) AS Total_Group_Count,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Count,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customerID) * 100, 2) AS Churn_Rate
FROM 
	raw_data
WHERE
	SeniorCitizen = '0'
GROUP BY 
	1, 2, 3, 4
ORDER BY
	8 DESC, 9 DESC
LIMIT 20;