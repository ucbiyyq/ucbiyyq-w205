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


