CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.discover_measure_dates;

CREATE TABLE hospital_compare.discover_measure_dates AS
SELECT
    measure_id,
    measure_name,
    UNIX_TIMESTAMP(measure_start_date, 'MM/dd/yyyy') AS measure_start_date,
    measure_start_quarter,
    UNIX_TIMESTAMP(measure_end_date, 'MM/dd/yyyy') AS measure_end_date,
    measure_end_quarter
FROM hospital_compare.land_measure_dates;

