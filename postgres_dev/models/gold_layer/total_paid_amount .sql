{{ config(materialized='table',schema='gold') }}

with source_data as (

    SELECT '$' || SUM(paid_amount) AS total_paid_amount
	FROM {{ ref('fact_claims') }}

)

select *
from source_data

