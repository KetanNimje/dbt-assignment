{{ config(materialized='table',schema='bronze') }}

with source_data as (

    select claim_id,
    member_id,
    name,
    address,
    email,
    gender,
    date_of_birth,
    diagnosis_1,
    diagnosis_2,
    diagnosis_3,
    CAST(allowed_amount AS VARCHAR) AS allowed_amount,
    CAST(paid_amount AS VARCHAR) AS paid_amount,
    enrolled_date,
    claimed_date,
    paid_date,
    created_date
    from {{ source('Bootcamp_task','US_Healthcare_Claims') }}

)

select *
from source_data

