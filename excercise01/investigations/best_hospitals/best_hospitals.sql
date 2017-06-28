USE hospital_compare;

--hospitals that did well on the complications survey, first ten entries
WITH step1 AS (
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
), step2 AS (
    --counts the number of better, same, and worse survey items
    SELECT 
        provider_id, hospital_name, 
        SUM(better_vs_national) AS better_vs_national_count, 
        SUM(same_vs_national) AS same_vs_national_count, 
        SUM(worse_vs_national) AS worse_vs_national_count
    FROM step1
    GROUP BY provider_id, hospital_name
), step3 AS (
    --assigns a scoring based on the counts
    SELECT 
        provider_id, hospital_name, 
        better_vs_national_count * 1 AS better_score,
        better_vs_national_count + same_vs_national_count + worse_vs_national_count AS survey_items_count
    FROM step2
), step4 AS (
    --aggregates the scores, normalized by the number of survey items
    SELECT
        provider_id, hospital_name, better_score, 
        (better_score) / survey_items_count AS aggregate_score
    FROM step3
)
--finds the top ten entries by the aggregate score
SELECT provider_id, hospital_name, aggregate_score
FROM step4
ORDER BY aggregate_score DESC, provider_id ASC
LIMIT 10;
