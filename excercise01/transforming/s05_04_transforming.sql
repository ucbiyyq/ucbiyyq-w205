CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.discover_hcahps_hospital;

CREATE TABLE hospital_compare.discover_hcahps_hospital AS
SELECT
    provider_id,
    hospital_name,
    hcahps_measure_id,
    hcahps_question,
    hcahps_answer_description,

    CASE
        WHEN patient_survey_star_rating IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(patient_survey_star_rating AS INT)
    END AS patient_survey_star_rating,

    CASE
        WHEN patient_survey_star_rating_footnote = '' THEN NULL
        ELSE patient_survey_star_rating_footnote
    END AS patient_survey_star_rating_footnote,

    CASE
        WHEN hcahps_answer_percent IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(hcahps_answer_percent AS INT)
    END AS hcahps_answer_percent,

    CASE
        WHEN hcahps_answer_percent_footnote = '' THEN NULL
        ELSE hcahps_answer_percent_footnote
    END AS hcahps_answer_percent_footnote,

    CASE
        WHEN hcahps_linear_mean_value IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(hcahps_linear_mean_value AS INT)
    END AS hcahps_linear_mean_value,

    CASE
        WHEN number_of_completed_surveys IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(number_of_completed_surveys AS INT)
    END AS number_of_completed_surveys,

    CASE
        WHEN number_of_completed_surveys_footnote = '' THEN NULL
        ELSE number_of_completed_surveys_footnote
    END AS number_of_completed_surveys_footnote,

    CASE
        WHEN survey_response_rate_percent IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(survey_response_rate_percent AS INT)
    END AS survey_response_rate_percent,

    CASE
        WHEN survey_response_rate_percent_footnote = '' THEN NULL
        ELSE survey_response_rate_percent_footnote
    END AS survey_response_rate_percent_footnote,

    UNIX_TIMESTAMP(measure_start_date, 'MM/dd/yyyy') AS measure_start_date,
    UNIX_TIMESTAMP(measure_end_date, 'MM/dd/yyyy') AS measure_end_date
FROM hospital_compare.land_hcahps_hospital;

