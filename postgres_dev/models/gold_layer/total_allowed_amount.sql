{{ config(materialized='table',schema='gold') }}

with source_data as (

    SELECT '$' || SUM(allowed_amount) AS total_allowed_amount
	FROM {{ ref('fact_claims') }}

)

select *
from source_data

