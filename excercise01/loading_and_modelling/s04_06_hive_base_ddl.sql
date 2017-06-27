CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.land_hvbp_hcahps;

CREATE EXTERNAL TABLE hospital_compare.land_hvbp_hcahps (
    provider_number VARCHAR(50),
    hospital_name VARCHAR(100),
    address VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(50),
    county_name VARCHAR(50),
    communication_with_nurses_floor VARCHAR(50),
    communication_with_nurses_achievement_threshold VARCHAR(50),
    communication_with_nurses_benchmark VARCHAR(50),
    communication_with_nurses_baseline_rate VARCHAR(50),
    communication_with_nurses_performance_rate VARCHAR(50),
    communication_with_nurses_achievement_points VARCHAR(50),
    communication_with_nurses_improvement_points VARCHAR(50),
    communication_with_nurses_dimension_score VARCHAR(50),
    communication_with_doctors_floor VARCHAR(50),
    communication_with_doctors_achievement_threshold VARCHAR(50),
    communication_with_doctors_benchmark VARCHAR(50),
    communication_with_doctors_baseline_rate VARCHAR(50),
    communication_with_doctors_performance_rate VARCHAR(50),
    communication_with_doctors_achievement_points VARCHAR(50),
    communication_with_doctors_improvement_points VARCHAR(50),
    communication_with_doctors_dimension_score VARCHAR(50),
    responsiveness_of_hospital_staff_floor VARCHAR(50),
    responsiveness_of_hospital_staff_achievement_threshold VARCHAR(50),
    responsiveness_of_hospital_staff_benchmark VARCHAR(50),
    responsiveness_of_hospital_staff_baseline_rate VARCHAR(50),
    responsiveness_of_hospital_staff_performance_rate VARCHAR(50),
    responsiveness_of_hospital_staff_achievement_points VARCHAR(50),
    responsiveness_of_hospital_staff_improvement_points VARCHAR(50),
    responsiveness_of_hospital_staff_dimension_score VARCHAR(50),
    pain_management_floor VARCHAR(50),
    pain_management_achievement_threshold VARCHAR(50),
    pain_management_benchmark VARCHAR(50),
    pain_management_baseline_rate VARCHAR(50),
    pain_management_performance_rate VARCHAR(50),
    pain_management_achievement_points VARCHAR(50),
    pain_management_improvement_points VARCHAR(50),
    pain_management_dimension_score VARCHAR(50),
    communication_about_medicines_floor VARCHAR(50),
    communication_about_medicines_achievement_threshold VARCHAR(50),
    communication_about_medicines_benchmark VARCHAR(50),
    communication_about_medicines_baseline_rate VARCHAR(50),
    communication_about_medicines_performance_rate VARCHAR(50),
    communication_about_medicines_achievement_points VARCHAR(50),
    communication_about_medicines_improvement_points VARCHAR(50),
    communication_about_medicines_dimension_score VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_floor VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_achievement_threshold VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_benchmark VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_baseline_rate VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_performance_rate VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_achievement_points VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_improvement_points VARCHAR(50),
    cleanliness_and_quietness_of_hospital_environment_dimension_score VARCHAR(50),
    discharge_information_floor VARCHAR(50),
    discharge_information_achievement_threshold VARCHAR(50),
    discharge_information_benchmark VARCHAR(50),
    discharge_information_baseline_rate VARCHAR(50),
    discharge_information_performance_rate VARCHAR(50),
    discharge_information_achievement_points VARCHAR(50),
    discharge_information_improvement_points VARCHAR(50),
    discharge_information_dimension_score VARCHAR(50),
    overall_rating_of_hospital_floor VARCHAR(50),
    overall_rating_of_hospital_achievement_threshold VARCHAR(50),
    overall_rating_of_hospital_benchmark VARCHAR(50),
    overall_rating_of_hospital_baseline_rate VARCHAR(50),
    overall_rating_of_hospital_performance_rate VARCHAR(50),
    overall_rating_of_hospital_achievement_points VARCHAR(50),
    overall_rating_of_hospital_improvement_points VARCHAR(50),
    overall_rating_of_hospital_dimension_score VARCHAR(50),
    hcahps_base_score VARCHAR(50),
    hcahps_consistency_score VARCHAR(50)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = "," , "quoteChar" = '"' , "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hvbp_hcahps';

DROP TABLE hospital_compare.discover_hvbp_hcahps;

CREATE TABLE hospital_compare.discover_hvbp_hcahps AS
SELECT
    provider_number,
    hospital_name,
    
    CASE
        WHEN hcahps_base_score IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(hcahps_base_score AS INT)
    END AS hcahps_base_score,
    
    CASE
        WHEN hcahps_consistency_score IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(hcahps_consistency_score AS INT)
    END AS hcahps_consistency_score
    
FROM hospital_compare.land_hvbp_hcahps;