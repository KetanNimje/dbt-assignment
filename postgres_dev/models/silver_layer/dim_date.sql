{{ config(materialized='table',schema='silver') }}

with source_data AS (
    SELECT * 
    FROM {{ ref('cleaned_table_us_healthcare_claims') }}
),
dates AS (
    SELECT
        DISTINCT DATE(date) as date_key,
        EXTRACT(DAY FROM date) as day,
        EXTRACT(MONTH FROM date) as month,
        EXTRACT(YEAR FROM date) as year,
        EXTRACT(QUARTER FROM date) as quarter,
        EXTRACT(DOW FROM date) as day_of_week,
        EXTRACT(DOY FROM date) as day_of_year,
        EXTRACT(WEEK FROM date) as week_of_year,
        CASE WHEN EXTRACT(ISODOW FROM date) IN (6, 7) THEN 1 ELSE 0 END as is_weekend
    FROM (
        SELECT enrolled_date as date FROM source_data 
        UNION
        SELECT claimed_date as date FROM source_data 
        UNION
        SELECT paid_date as date FROM source_data 
        UNION
        SELECT created_date as date FROM source_data 
    ) AS all_dates
    ORDER BY date_key
)

SELECT * 
FROM dates
