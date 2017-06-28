USE hospital_compare;

--hospital variability = hospitals with the highest better-than and worse-than scores
DROP TABLE hospital_compare.discover_hospital_variability;

CREATE TABLE hospital_compare.discover_hospital_variability AS
WITH step1a AS (
    --gets relevant raw data from complications survey
    SELECT 
        provider_id,
        hospital_name, 
        measure_id,
        measure_name,
        CASE
            WHEN compared_to_national = 'Better than the National Rate' THEN 1
            ELSE 0
        END AS better_vs_national,
        CASE
            WHEN compared_to_national = 'No Different than the National Rate' THEN 1
            ELSE 0
        END AS same_vs_national,
        CASE
            WHEN compared_to_national = 'Worse than the National Rate' THEN 1
            ELSE 0
        END AS worse_vs_national
    FROM hospital_compare.discover_complications_hospital
    WHERE compared_to_national IN ('Better than the National Rate', 'No Different than the National Rate', 'Worse than the National Rate')
), step1b AS (
    --gets relevant raw data from readmissions and deaths survey
    SELECT
        provider_id,
        hospital_name, 
        measure_id,
        measure_name,
        CASE
            WHEN compared_to_national = 'Better than the National Rate' THEN 1
            ELSE 0
        END AS better_vs_national,
        CASE
            WHEN compared_to_national = 'No Different than the National Rate' THEN 1
            ELSE 0
        END AS same_vs_national,
        CASE
            WHEN compared_to_national = 'Worse than the National Rate' THEN 1
            ELSE 0
        END AS worse_vs_national
    FROM hospital_compare.discover_readmissions_deaths_hospital
    WHERE compared_to_national IN ('Better than the National Rate', 'No Different than the National Rate', 'Worse than the National Rate')
), step1c AS (
    --unions the relevant raw data
    SELECT * FROM step1a
    UNION ALL
    SELECT * FROM step1b
), step2 AS (
    --aggregates the counts
    SELECT 
        provider_id, hospital_name, 
        SUM(better_vs_national) AS better_vs_national_count, 
        SUM(same_vs_national) AS same_vs_national_count, 
        SUM(worse_vs_national) AS worse_vs_national_count
    FROM step1c
    GROUP BY provider_id, hospital_name
), step3 AS (
    --assigns a scoring based on the counts
    SELECT 
        provider_id, hospital_name, 
        better_vs_national_count * 1 AS better_score,
        worse_vs_national_count * 1 AS worse_score,
        better_vs_national_count + same_vs_national_count + worse_vs_national_count AS survey_items_count
    FROM step2
), step4 AS (
    --normalizes the score
    SELECT
        provider_id, hospital_name, better_score, worse_score, survey_items_count,
        (better_score + worse_score) / survey_items_count AS aggregate_score
    FROM step3
)
SELECT provider_id, hospital_name, better_score, worse_score, survey_items_count, aggregate_score
FROM step4;


--finds the first ten entries by the aggregate score
SELECT provider_id, hospital_name, better_score, worse_score, survey_items_count, aggregate_score
FROM hospital_compare.discover_hospital_variability
ORDER BY aggregate_score DESC, provider_id ASC
LIMIT 10;


--finds the average, aggregate, and variability of the aggregate score
SELECT 
    MIN(aggregate_score) AS min_aggregate_score,
    AVG(aggregate_score) AS avg_aggregate_score,
    MAX(aggregate_score) AS max_aggregate_score,
    MAX(aggregate_score) - MIN(aggregate_score) AS rng_aggregate_score
FROM hospital_compare.discover_hospital_variability;