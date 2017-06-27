CREATE SCHEMA IF NOT EXISTS hospital_compare;

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


