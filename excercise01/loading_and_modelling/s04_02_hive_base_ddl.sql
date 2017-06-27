CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.land_measure_dates;

CREATE EXTERNAL TABLE hospital_compare.land_measure_dates (
    measure_name VARCHAR(200),
    measure_id VARCHAR(50),
    measure_start_quarter VARCHAR(50),
    measure_start_date VARCHAR(50),
    measure_end_quarter VARCHAR(50),
    measure_end_date VARCHAR(50)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = "," , "quoteChar" = '"' , "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measure_dates';

DROP TABLE hospital_compare.discover_measure_dates;

CREATE TABLE hospital_compare.discover_measure_dates AS
SELECT
    measure_id,
    measure_name,
    UNIX_TIMESTAMP(measure_start_date, 'MM/dd/yyyy') AS measure_start_date,
    measure_start_quarter,
    UNIX_TIMESTAMP(measure_end_date, 'MM/dd/yyyy') AS measure_end_date,
    measure_end_quarter
FROM hospital_compare.land_measure_dates;

