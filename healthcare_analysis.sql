##creating database

CREATE DATABASE healthcare_analysis;

##using database

USE healthcare_analysis;

##creating tables

CREATE TABLE healthcare_readmissions (
patient_id INT PRIMARY KEY,
age INT,
gender VARCHAR (1),
length_of_stay_days INT,
has_diabetes INT,
has_hypertension INT,
num_previous_admissions INT,
readmitted_30_days INT);

##load data and check data

USE healthcare_analysis;

SELECT * FROM healthcare_readmissions_data;


##overall readmission rate analysis

SELECT
    COUNT(*) AS total_admissions,
    SUM(readmitted_30_days) AS readmitted_count,
    ROUND( (SUM(readmitted_30_days) * 100.0) / COUNT(*), 2) AS readmission_rate_percentage
FROM healthcare_analysis.healthcare_readmission_data;


##readmission by age group
SELECT
    CASE
        WHEN age < 50 THEN '<50'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70+'
    END AS age_group,
    COUNT(*) AS total_admissions,
    SUM(readmitted_30_days) AS readmitted_count,
    ROUND( (SUM(readmitted_30_days) * 100.0) / COUNT(*), 2) AS readmission_rate_percentage
FROM healthcare_analysis.healthcare_readmission_data
GROUP BY age_group
ORDER BY age_group;

## Diabetes vs Readmission
SELECT
	CASE
    WHEN has_diabetes =1 THEN 'diabetic'
    WHEN has_diabetes =0 THEN 'non_diabetic'
    END
    AS
    patient_type,
    COUNT(*) AS total_admissions,
    SUM(readmitted_30_days) AS readmitted_count,
    ROUND( (SUM(readmitted_30_days) * 100.0) / COUNT(*), 2) AS readmission_rate_percentage
FROM healthcare_analysis.healthcare_readmission_data
GROUP BY
patient_type;
    
## Length of Stay Impact on readmition
SELECT
	CASE
    WHEN length_of_stay_days BETWEEN 1 AND 5 THEN '0-5'
    WHEN length_of_stay_days BETWEEN 6 AND 10 THEN '6-10'
    ELSE '>10'
    END
    AS
    Length_of_Stay,
    COUNT(*) AS total_admissionions,
    SUM(readmitted_30_days) AS readmitted_count,
    ROUND((SUM(readmitted_30_days)*100)/COUNT(*), 2) AS readmission_rate_percentage
    FROM healthcare_readmission_data
    GROUP BY 
    Length_of_Stay
    ORDER BY
    Length_of_Stay ASC;

##High-Risk Patient Identification

SELECT
    patient_id,
    age,
    gender,
    num_previous_admissions,
    readmitted_30_days
FROM healthcare_analysis.healthcare_readmission_data
WHERE num_previous_admissions >= 2 AND readmitted_30_days = 1
ORDER BY num_previous_admissions DESC;



