# Employee Attrition Prediction using Big Data Analytics

## Project Overview

This project develops a Big Data Analytics pipeline for analyzing and
predicting employee attrition using distributed storage, SQL analytics,
distributed processing, machine learning, and NoSQL-based employee-level
prediction retrieval.

The project uses the Employee Attrition dataset containing **1,470
employee records and 35 attributes**.

## Objectives

1.  Store employee data using HDFS.
2.  Analyze employee attrition using Apache Hive.
3.  Clean and transform data using PySpark.
4.  Build machine-learning models using Spark MLlib.
5.  Compare Logistic Regression and Random Forest.
6.  Select the best-performing model.
7.  Generate attrition probabilities and employee risk levels.
8.  Store prediction results in HDFS.
9.  Store predictions in HBase for employee-level lookup.
10. Generate business insights.

## Technologies

  Technology               Purpose
  ------------------------ ------------------------------------
  Docker                   Containerized Big Data environment
  Hadoop HDFS              Distributed storage
  Apache Hive              SQL-based analytics
  Apache Spark / PySpark   Distributed processing
  Spark MLlib              Machine learning
  HBase                    Employee-level prediction lookup
  ZooKeeper                HBase coordination
  JupyterLab               PySpark development
  Python                   Data processing and ML
  Git/GitHub               Version control and documentation

Pig and Streamlit were not included because they were not required for
the implemented project pipeline.

## Dataset

**File:** `Employee_Attrition_data.csv`

-   Records: **1,470**
-   Features: **35**
-   Target variable: `Attrition`

`Attrition = Yes` indicates that the employee left the organization,
while `No` indicates that the employee stayed.

## Architecture

``` text
Employee Attrition Dataset
          |
          v
        HDFS
          |
     +----+----+
     |         |
     v         v
   Hive     PySpark
 Analytics   Processing
                |
                v
       Feature Engineering
                |
                v
          Spark MLlib
                |
                v
         Model Evaluation
                |
                v
        Attrition Prediction
                |
                v
      HDFS Prediction Storage
                |
                v
              HBase
                |
                v
     Employee-Level Lookup
```

The detailed architecture diagram is available in `architecture/`.

## HDFS

The main HDFS project directory is:

``` text
/employee_attrition/
├── raw/
├── processed/
└── results/
```

Raw data:

``` text
/employee_attrition/raw/Employee_Attrition_data.csv
```

Prediction results:

``` text
/employee_attrition/results/predictions
```

## Hive Analytics

**Database:** `employee_attrition_db`

**Table:** `employee_attrition`

Hive was used for employee count, attrition distribution, attrition
rate, department-wise analysis, job-role analysis, overtime, business
travel, job satisfaction, job level, and age-group analysis.

### Attrition distribution

  Attrition     Employees
  ----------- -----------
  No                1,233
  Yes                 237
  **Total**     **1,470**

Overall attrition rate: **16.12%**

## PySpark Processing

The PySpark pipeline:

1.  Reads the CSV from HDFS.
2.  Checks schema and missing values.
3.  Removes `EmployeeCount`, `StandardHours`, and `Over18`.
4.  Converts `Attrition` to a binary label.
5.  Encodes categorical variables using `StringIndexer` and
    `OneHotEncoder`.
6.  Assembles the feature vector.
7.  Splits the data into training and testing sets.

### Data split

``` text
Training: 1216
Testing:   254
Total:    1470
```

An 80:20 split with seed 42 was used.

## Machine Learning

Two Spark MLlib models were evaluated.

### Logistic Regression

  Metric           Value
  ----------- ----------
  Accuracy      0.874016
  Precision     0.861909
  Recall        0.874016
  F1 Score      0.863431
  ROC-AUC       0.870058

### Random Forest

  Metric           Value
  ----------- ----------
  Accuracy      0.842520
  Precision     0.816993
  Recall        0.842520
  F1 Score      0.789627
  ROC-AUC       0.791779

**Final model:** Logistic Regression, because it outperformed Random
Forest on all reported evaluation metrics.

## Attrition Risk Prediction

Risk levels were assigned from predicted attrition probability:

  Probability       Risk
  ----------------- --------
  `< 0.30`          Low
  `0.30 – < 0.60`   Medium
  `>= 0.60`         High

For the **254 test employees**:

  Risk Level     Employees
  ------------ -----------
  Low                  201
  Medium                37
  High                  16
  **Total**        **254**

## HDFS Prediction Results

Predictions were stored as Parquet in:

``` text
/employee_attrition/results/predictions
```

The prediction dataset contains:

-   `EmployeeNumber`
-   `actual_attrition`
-   `prediction`
-   `attrition_probability`
-   `risk_level`

## HBase Integration

HBase was used as the employee-level serving layer.

**Table:** `employee_attrition_predictions`

**Row key:** `EmployeeNumber`

**Column family:** `prediction`

**Stored columns:**

``` text
prediction:probability
prediction:prediction
prediction:risk_level
prediction:model_version
```

All **254** Spark test predictions were successfully stored and verified
in HBase.

### Example: Employee 65

``` text
Prediction:       1
Probability:      0.754102
Risk Level:       High
Model Version:    LogisticRegression
```

This demonstrates employee-level key-based retrieval.

## Role of Technologies

-   **HDFS:** distributed storage for raw data and prediction results.
-   **Hive:** SQL-based batch analytics.
-   **Spark/PySpark:** distributed processing and feature engineering.
-   **Spark MLlib:** machine-learning models.
-   **HBase:** fast employee-level prediction lookup.
-   **Docker:** reproducible containerized environment.

## Project Structure

``` text
Employee-Attrition-BigData/
├── architecture/
├── data/
├── documentation/
├── hbase/
├── hdfs/
├── hive/
├── pig/
├── results/
├── screenshots/
├── spark/
├── docker-compose.yml
├── README.md
├── project_plan.md
└── requirements_notes.txt
```

## Evidence

The `screenshots/` directory contains evidence for:

-   Docker services
-   HDFS structure
-   Hive table
-   Hive analytics
-   Spark schema
-   Model comparison
-   Risk distribution
-   Prediction results
-   HBase record count
-   HBase employee-level lookup

## Key Results

-   **1,470** employee records analyzed.
-   **237** employees recorded as having left.
-   Overall attrition rate: **16.12%**.
-   Logistic Regression accuracy: **87.40%**.
-   Logistic Regression ROC-AUC: **0.8701**.
-   Logistic Regression outperformed Random Forest on the evaluated
    metrics.
-   **254** test-set predictions generated.
-   **254** prediction records successfully stored in HBase.
-   Employee-level prediction retrieval demonstrated using
    `EmployeeNumber`.

## Limitations

The machine-learning evaluation and risk distribution are based on the
**254-record test set**, not the complete 1,470-record dataset.

The model is an analytical prediction system and should support, rather
than replace, organizational decision-making.

## Conclusion

This project demonstrates an end-to-end Big Data Analytics workflow for
employee attrition, from raw-data ingestion and distributed storage
through Hive analytics, PySpark processing, Spark MLlib prediction, HDFS
result storage, and HBase employee-level serving.

The final Logistic Regression model achieved **87.40% accuracy** and
**0.8701 ROC-AUC** on the test dataset, and its 254 predictions were
successfully integrated into HBase.
