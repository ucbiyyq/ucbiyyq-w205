CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.discover_readmissions_deaths_state;

CREATE TABLE hospital_compare.discover_readmissions_deaths_state AS
SELECT
    state,
    measure_id,
    measure_name,
    
    CASE
        WHEN number_of_hospitals_worse IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(number_of_hospitals_worse AS INT)
    END AS number_of_hospitals_worse,
    
    CASE
        WHEN number_of_hospitals_same IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(number_of_hospitals_same AS INT)
    END AS number_of_hospitals_same,
    
    CASE
        WHEN number_of_hospitals_better IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(number_of_hospitals_better AS INT)
    END AS number_of_hospitals_better,
    
    CASE
        WHEN number_of_hospitals_too_few IN ('Not Available', 'Not Applicable') THEN NULL
        ELSE CAST(number_of_hospitals_too_few AS INT)
    END AS number_of_hospitals_too_few,
    
    CASE
        WHEN footnote = '' THEN NULL
        ELSE footnote
    END AS footnote,
    
    UNIX_TIMESTAMP(measure_start_date, 'MM/dd/yyyy') AS measure_start_date,
    UNIX_TIMESTAMP(measure_end_date, 'MM/dd/yyyy') AS measure_end_date

FROM hospital_compare.land_readmissions_deaths_state;

