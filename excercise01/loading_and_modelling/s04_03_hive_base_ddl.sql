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


