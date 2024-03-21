{{ config(materialized='table',schema='silver') }}

with source_data as (

    select full_code AS diagnosis_key,
    category_code,
    diagnosis_code,
    abbreviated_description,
    full_description,
    category_title
 from {{  ref('cleaned_table_icd_codes') }}


)

select *
from source_data

