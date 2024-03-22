{{ config(materialized='table',schema='gold') }}
WITH cte AS(
SELECT member_key,
		CASE WHEN diagnosis_1_key is not null AND diagnosis_2_key is not null AND diagnosis_3_key is not null THEN 3
			WHEN diagnosis_1_key is not null AND diagnosis_2_key is not null AND diagnosis_3_key is null THEN 2
			WHEN diagnosis_1_key is not null AND diagnosis_2_key is null AND diagnosis_3_key is not null THEN 2
			WHEN diagnosis_1_key is null AND diagnosis_2_key is not null AND diagnosis_3_key is not null THEN 2
			WHEN diagnosis_1_key is not null AND diagnosis_2_key is null AND diagnosis_3_key is null THEN 1
			WHEN diagnosis_1_key is null AND diagnosis_2_key is not null AND diagnosis_3_key is null THEN 1
			WHEN diagnosis_1_key is null AND diagnosis_2_key is null AND diagnosis_3_key is not null THEN 1
			ELSE null
			END AS diagnosis_count_member
FROM {{ ref('fact_claims') }}
),
newcte AS(
SELECT t1.member_key,t2.name,t2.address,t2.gender,t2.email,t1.diagnosis_count_member FROM cte AS t1
JOIN {{ ref('dim_member') }} AS t2
ON t1.member_key = t2.member_key
	)
SELECT name,address,email,gender,diagnosis_count_member FROM newcte
ORDER BY diagnosis_count_member DESC