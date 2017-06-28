USE hospital_compare;

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
