{{ config(materialized='table',schema='gold') }}

with source_data as (

--    SELECT DATE_PART('day', paid_date_key) AS day_of_month,
--        '$' || SUM(paid_amount) AS total_paid_amount
-- 	FROM {{ ref('fact_claims') }}
-- 	GROUP BY DATE_PART('day', paid_date_key)
-- 	ORDER BY day_of_month
	SELECT DATE_PART('day', t1.paid_date_key) AS day_of_month,
	SUM(t1.paid_amount) AS total_paid_amount
	FROM {{ref('fact_claims')}} AS t1
	JOIN {{ref('dim_date')}} AS t2
	ON t1.paid_date_key = t2.date_key
	GROUP BY DATE_PART('day', t1.paid_date_key)
	ORDER BY day_of_month
	
)

select *
from source_data

