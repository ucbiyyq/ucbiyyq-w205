CREATE SCHEMA IF NOT EXISTS hospital_compare;

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

