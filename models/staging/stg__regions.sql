with source as (
    select
        *
    from {{ source('tpch_raw', 'regions') }}
)
select
    *
from
    source
