{{ config(materialized='table',schema='silver') }}

with source_data as (

    SELECT * FROM {{  ref('icd_codes') }}


)

select *
from source_data
