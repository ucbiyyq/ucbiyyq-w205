CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.land_hospitals;

CREATE EXTERNAL TABLE hospital_compare.land_hospitals (
    provider_id VARCHAR(50),
    hospital_name VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(50),
    county_name VARCHAR(50),
    phone_number VARCHAR(50),
    hospital_type VARCHAR(50),
    hospital_ownership VARCHAR(50),
    emergency_services VARCHAR(50)

)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = "," , "quoteChar" = '"' , "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

DROP TABLE hospital_compare.discover_hospitals;

CREATE TABLE hospital_compare.discover_hospitals AS
SELECT
    provider_id,
    hospital_name,
    state
FROM hospital_compare.land_hospitals;

