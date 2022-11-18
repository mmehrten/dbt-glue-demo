{{ config(    materialized='incremental',
    incremental_strategy='merge', unique_key='id') }}
with source_data as (
    select 1 as id,
    "b" AS anothercol
)
select *
from source_data