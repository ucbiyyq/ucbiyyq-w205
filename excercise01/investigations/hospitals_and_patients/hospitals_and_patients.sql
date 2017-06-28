USE hospital_compare;

WITH step1 AS (
    --gets relevant raw data from the hvbp survey
    SELECT 
        provider_number,
        hospital_name,
        hcahps_base_score
    FROM hospital_compare.discover_hvbp_hcahps
    WHERE hcahps_base_score IS NOT NULL
)
SELECT provider_number, hospital_name, hcahps_base_score
FROM step1
ORDER BY hcahps_base_score DESC, provider_number ASC
LIMIT 10;


--finds the average, aggregate, and variability of the aggregate score
SELECT 
    MIN(hcahps_base_score) AS min_hcahps_base_score,
    AVG(hcahps_base_score) AS avg_hcahps_base_score,
    MAX(hcahps_base_score) AS max_hcahps_base_score,
    MAX(hcahps_base_score) - MIN(hcahps_base_score) AS rng_hcahps_base_score
FROM hospital_compare.discover_hvbp_hcahps;