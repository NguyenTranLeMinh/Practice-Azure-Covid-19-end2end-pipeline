CREATE SCHEMA covid
GO
CREATE TABLE covid.cases_deaths (
    country                 VARCHAR(100),
    country_code_2_digit    VARCHAR(2),
    country_code_3_digit    VARCHAR(3),
    population              BIGINT,
    cases_count             BIGINT,
    deaths_count            BIGINT,
    [reported date]         DATE,
    source                  VARCHAR(1000)
);
GO
CREATE TABLE covid.hospital_admissions_daily
(
    country                     VARCHAR(100),
    country_code_2_digit        VARCHAR(2),
    country_code_3_digit        VARCHAR(3),
    population                  BIGINT,
    reported_date               DATE,
    hospital_occupancy_count    BIGINT,
    icu_occupancy_count         BIGINT,
    source                      VARCHAR(1000)
)
GO

CREATE TABLE covid.testing
(
    country                     VARCHAR(100),
    country_code_2_digit        VARCHAR(2),
    country_code_3_digit        VARCHAR(3),
    year_week                   VARCHAR(8),
    week_start_date             DATE,
    week_end_date               DATE,
    new_cases                   BIGINT,
    tests_done                  BIGINT,
    population                  BIGINT,
    testing_data_source         VARCHAR(1000)
)
GO
