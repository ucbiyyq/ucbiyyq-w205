CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.land_complications_hospital;

CREATE EXTERNAL TABLE hospital_compare.land_complications_hospital (
    provider_id VARCHAR(50),
    hospital_name VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(50),
    county_name VARCHAR(50),
    phone_number VARCHAR(50),
    measure_name VARCHAR(100),
    measure_id VARCHAR(50),
    compared_to_national VARCHAR(50),
    denominator VARCHAR(50),
    score VARCHAR(50),
    lower_estimate VARCHAR(50),
    higher_estimate VARCHAR(50),
    footnote VARCHAR(100),
    measure_start_date VARCHAR(50),
    measure_end_date VARCHAR(50)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = "," , "quoteChar" = '"' , "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/complications_hospital';

DROP TABLE hospital_compare.discover_complications_hospital;

CREATE TABLE hospital_compare.discover_complications_hospital AS
SELECT
    provider_id,
    hospital_name,
    measure_id,
    measure_name,
    compared_to_national,
    denominator,
    CASE WHEN score = 'Not Available' THEN NULL ELSE CAST(score AS FLOAT) END AS score,
    CASE WHEN lower_estimate = 'Not Available' THEN NULL ELSE CAST(lower_estimate AS FLOAT) END AS lower_estimate,
    CASE WHEN higher_estimate = 'Not Available' THEN NULL ELSE CAST(higher_estimate AS FLOAT) END AS higher_estimate,
    footnote,
    UNIX_TIMESTAMP(measure_start_date, 'MM/dd/yyyy') AS measure_start_date,
    UNIX_TIMESTAMP(measure_end_date, 'MM/dd/yyyy') AS measure_end_date
FROM hospital_compare.land_complications_hospital;


