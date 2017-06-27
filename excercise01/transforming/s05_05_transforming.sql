CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.discover_readmissions_deaths_hospital;

CREATE TABLE hospital_compare.discover_readmissions_deaths_hospital AS
SELECT
    provider_id,
    hospital_name,
    measure_id,
    measure_name,
    compared_to_national,

    CASE
        WHEN denominator IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(denominator AS INT)
    END AS denominator,

    CASE
        WHEN score IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(score AS FLOAT)
    END AS score,

    CASE
        WHEN lower_estimate IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(lower_estimate AS FLOAT)
    END AS lower_estimate,

    CASE
        WHEN higher_estimate IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(higher_estimate AS FLOAT)
    END AS higher_estimate,

    CASE
        WHEN footnote = '' THEN NULL
        ELSE footnote
    END AS footnote,

    UNIX_TIMESTAMP(measure_start_date, 'MM/dd/yyyy') AS measure_start_date,
    UNIX_TIMESTAMP(measure_end_date, 'MM/dd/yyyy') AS measure_end_date
FROM hospital_compare.land_readmissions_deaths_hospital;

