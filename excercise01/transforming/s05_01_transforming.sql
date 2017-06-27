CREATE SCHEMA IF NOT EXISTS hospital_compare;

DROP TABLE hospital_compare.discover_hospitals;

CREATE TABLE hospital_compare.discover_hospitals AS
SELECT
    provider_id,
    hospital_name,
    state
FROM hospital_compare.land_hospitals;

