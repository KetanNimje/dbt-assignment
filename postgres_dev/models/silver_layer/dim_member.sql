{{ config(materialized='table',schema='silver') }}

with source_data as (

    select member_id AS member_key,
    name,
    address,
    email,
    gender
 	from {{ ref('cleaned_table_us_healthcare_claims') }}


)

select *
from source_data

