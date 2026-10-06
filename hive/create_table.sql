CREATE DATABASE IF NOT EXISTS employee_attrition_db;

USE employee_attrition_db;

DROP TABLE IF EXISTS employee_attrition;

CREATE EXTERNAL TABLE employee_attrition (
    Age INT,
    Attrition STRING,
    BusinessTravel STRING,
    DailyRate INT,
    Department STRING,
    DistanceFromHome INT,
    Education INT,
    EducationField STRING,
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender STRING,
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole STRING,
    JobSatisfaction INT,
    MaritalStatus STRING,
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 STRING,
    OverTime STRING,
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/employee_attrition/raw/'
TBLPROPERTIES ("skip.header.line.count"="1");