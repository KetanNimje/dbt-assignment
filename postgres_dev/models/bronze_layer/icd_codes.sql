{{ config(materialized='table',schema='bronze') }}

with source_data as (

    select * from {{ source('Bootcamp_task','ICD_Codes') }}


)

select *
from source_data

