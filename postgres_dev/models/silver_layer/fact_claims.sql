{{ config(materialized='table',schema='silver') }}

with source_data as (

    select member_id AS member_key,
    diagnosis_1 AS diagnosis_1_key,
    diagnosis_2 AS diagnosis_2_key,
    diagnosis_3 AS diagnosis_3_key,
    claimed_date AS claimed_date_key,
    enrolled_date AS enrolled_date_key,
    paid_date AS paid_date_key,
    claim_id,
    allowed_amount,
    paid_amount
 from {{ ref('cleaned_table_us_healthcare_claims') }}


)

select *
from source_data

