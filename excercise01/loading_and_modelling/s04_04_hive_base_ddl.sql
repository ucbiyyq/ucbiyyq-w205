CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.land_hcahps_hospital;

CREATE EXTERNAL TABLE hospital_compare.land_hcahps_hospital (
    provider_id VARCHAR(50),
    hospital_name VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(50),
    county_name VARCHAR(50),
    phone_number VARCHAR(50),
    hcahps_measure_id VARCHAR(50),
    hcahps_question VARCHAR(200),
    hcahps_answer_description VARCHAR(50),
    patient_survey_star_rating VARCHAR(50),
    patient_survey_star_rating_footnote VARCHAR(500),
    hcahps_answer_percent VARCHAR(50),
    hcahps_answer_percent_footnote VARCHAR(500),
    hcahps_linear_mean_value VARCHAR(50),
    number_of_completed_surveys VARCHAR(50),
    number_of_completed_surveys_footnote VARCHAR(500),
    survey_response_rate_percent VARCHAR(50),
    survey_response_rate_percent_footnote VARCHAR(500),
    measure_start_date VARCHAR(50),
    measure_end_date VARCHAR(50)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = "," , "quoteChar" = '"' , "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hcahps_hospital';


