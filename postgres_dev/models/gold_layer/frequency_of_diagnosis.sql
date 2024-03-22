{{ config(materialized='table',schema='gold') }}

WITH cte AS(
SELECT t1.member_key,t1.diagnosis_1_key AS diagnosis,t2.category_title,t2.full_description
FROM {{ ref('fact_claims') }} AS t1
LEFT JOIN {{ ref('dim_diagnosis') }} AS t2 ON t1.diagnosis_1_key = t2.diagnosis_key
UNION ALL
SELECT t1.member_key,t1.diagnosis_2_key AS diagnosis,t2.category_title,t2.full_description
FROM  {{ ref('fact_claims') }} AS t1
LEFT JOIN {{ ref('dim_diagnosis') }} AS t2 ON t1.diagnosis_2_key = t2.diagnosis_key
UNION ALL
SELECT t1.member_key,t1.diagnosis_3_key AS diagnosis,t2.category_title,t2.full_description
FROM  {{ ref('fact_claims') }} AS t1
LEFT JOIN {{ ref('dim_diagnosis') }} AS t2 ON t1.diagnosis_3_key = t2.diagnosis_key
),
newCte AS(
	SELECT diagnosis,category_title,COUNT(diagnosis) AS frequency
	FROM cte
	GROUP BY diagnosis,category_title
	ORDER BY frequency DESC
)
SELECT * FROM newCte
