USE hospital_compare;

DESCRIBE hospital_compare.discover_complications_hospital;

provider_id     string  NULL
hospital_name   string  NULL
measure_id      string  NULL
measure_name    string  NULL
compared_to_national    string  NULL
denominator     string  NULL
score   float   NULL
lower_estimate  float   NULL
higher_estimate float   NULL
footnote        string  NULL
measure_start_date      bigint  NULL
measure_end_date        bigint  NULL







SELECT * FROM hospital_compare.discover_complications_hospital LIMIT 2;





--can't use score, seems to overlap
SELECT compared_to_national, min(score) AS min_score, max(score) AS max_score
FROM hospital_compare.discover_complications_hospital 
GROUP BY compared_to_national
ORDER BY compared_to_national;


Better than the National Rate           0.03    105.62
No Different than the National Rate     0.03    186.27
Not Available                           NULL    NULL
Number of Cases Too Small               NULL    NULL
Worse than the National Rate            0.39    212.16
Time taken: 7.261 seconds, Fetched 5 row(s)



--best hospitals = those that did well on the complications survey, first ten entries
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








spark-sql> describe hospital_compare.discover_complications_state;
state                       string  NULL
measure_id                  string  NULL
measure_name                string  NULL
number_of_hospitals_worse   int     NULL
number_of_hospitals_same    int     NULL
number_of_hospitals_better  int     NULL
number_of_hospitals_too_few int     NULL
footnote                    string  NULL
measure_start_date          bigint  NULL
measure_end_date            bigint  NULL





--best states = those that did well in the complications survey
WITH step1 AS (
    --gets relevant raw data from complications survey
    SELECT 
        state, 
        SUM(number_of_hospitals_worse) AS number_of_hospitals_worse, 
        SUM(number_of_hospitals_same) AS number_of_hospitals_same,
        SUM(number_of_hospitals_better) AS number_of_hospitals_better
    FROM hospital_compare.discover_complications_state
    WHERE footnote IS NULL
    GROUP BY state
), step2 AS (
    --assigns a scoring based on the counts
    SELECT
        state,
        number_of_hospitals_better * 1 AS better_score,
        number_of_hospitals_worse + number_of_hospitals_same + number_of_hospitals_better AS number_of_hospitals
    FROM step1
), step3 AS (
    --aggregates the scores, normalized by the number of hospitals
    SELECT
        state, 
        better_score / number_of_hospitals AS aggregate_score
    FROM step2
)
SELECT *
FROM step3
ORDER BY aggregate_score DESC, state ASC
LIMIT 10;


