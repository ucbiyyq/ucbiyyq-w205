USE hospital_compare;

--best states = those who had more hospitals who did well in the complications and readmissions & deaths surveys
DROP TABLE hospital_compare.discover_best_states;

CREATE TABLE hospital_compare.discover_best_states AS
WITH step1a AS (
    --gets relevant raw data from complications survey
    SELECT 
        state, 
        number_of_hospitals_worse, 
        number_of_hospitals_same,
        number_of_hospitals_better
    FROM hospital_compare.discover_complications_state
    WHERE footnote IS NULL
), step1b AS (
    --gets relevant raw data from readmissions and deaths survey
    SELECT 
        state, 
        number_of_hospitals_worse, 
        number_of_hospitals_same,
        number_of_hospitals_better
    FROM hospital_compare.discover_readmissions_deaths_state
    WHERE footnote IS NULL
), step1c AS (
    --unions the relevant raw data
    SELECT * FROM step1a
    UNION ALL
    SELECT * FROM step1b
), step2 AS (
    --aggregates the counts
    SELECT 
        state, 
        SUM(number_of_hospitals_worse) AS number_of_hospitals_worse, 
        SUM(number_of_hospitals_same) AS number_of_hospitals_same,
        SUM(number_of_hospitals_better) AS number_of_hospitals_better
    FROM step1c
    GROUP BY state
), step3 AS (
    --assigns a scoring based on the counts
    SELECT
        state,
        number_of_hospitals_better * 1 AS better_score,
        number_of_hospitals_worse + number_of_hospitals_same + number_of_hospitals_better AS number_of_hospitals
    FROM step2
), step4 AS (
    --normalizes the score
    SELECT
        state, better_score, number_of_hospitals,
        better_score / number_of_hospitals AS aggregate_score
    FROM step3
)
SELECT state, better_score, number_of_hospitals, aggregate_score
FROM step4;


--finds the first ten entries by the aggregate score
SELECT state, better_score, number_of_hospitals, aggregate_score
FROM hospital_compare.discover_best_states
ORDER BY aggregate_score DESC, state ASC
LIMIT 10;


--finds the average, aggregate, and variability of the aggregate score
SELECT 
    MIN(aggregate_score) AS min_aggregate_score,
    AVG(aggregate_score) AS avg_aggregate_score,
    MAX(aggregate_score) AS max_aggregate_score,
    MAX(aggregate_score) - MIN(aggregate_score) AS rng_aggregate_score
FROM hospital_compare.discover_best_states;