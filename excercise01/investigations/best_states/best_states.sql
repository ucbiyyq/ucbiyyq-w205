USE hospital_compare;

--best states = those that did well in the complications survey
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
        state, 
        better_score / number_of_hospitals AS aggregate_score
    FROM step3
)
--finds the first ten entries by the aggregate score
SELECT state, aggregate_score
FROM step4
ORDER BY aggregate_score DESC, state ASC
LIMIT 10;
