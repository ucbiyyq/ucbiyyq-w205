CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.land_readmissions_deaths_state;

CREATE EXTERNAL TABLE hospital_compare.land_readmissions_deaths_state (
    state VARCHAR(50),
    measure_name VARCHAR(100),
    measure_id VARCHAR(50),
    number_of_hospitals_worse VARCHAR(50),
    number_of_hospitals_same VARCHAR(50),
    number_of_hospitals_better VARCHAR(50),
    number_of_hospitals_too_few VARCHAR(50),
    footnote VARCHAR(100),
    measure_start_date VARCHAR(50),
    measure_end_date VARCHAR(50)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = "," , "quoteChar" = '"' , "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions_deaths_state';

