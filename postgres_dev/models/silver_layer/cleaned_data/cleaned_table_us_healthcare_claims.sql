{{ config(materialized='table',schema='silver') }}

with source_data as (

    select claim_id,
	member_id,
	name,
	address,
	email,
	CASE WHEN gender NOT IN ('Male','Female') THEN 'Others'
	ELSE gender
	END AS gender,
	date(date_of_birth) AS date_of_birth,
	COALESCE(diagnosis_1, diagnosis_2, diagnosis_3) AS diagnosis_1,
    	CASE 
        WHEN diagnosis_1 IS NOT NULL THEN COALESCE(diagnosis_2, diagnosis_3)
    	END AS diagnosis_2,
    	CASE 
        WHEN diagnosis_1 IS NOT NULL AND diagnosis_2 IS NOT NULL THEN diagnosis_3
    	END AS diagnosis_3,
	CAST(REPLACE(TRIM('$' FROM allowed_amount),',','') AS numeric) AS allowed_amount,
	CAST(REPLACE(TRIM('$' FROM paid_amount),',','') AS numeric) AS paid_amount,
	date(enrolled_date) AS enrolled_date,
	date(claimed_date) AS claimed_date,
	date(paid_date) AS paid_date,
	date(created_date) AS created_date
 	FROM {{ ref('us_healthcare_claims') }}

)

select * from source_data

