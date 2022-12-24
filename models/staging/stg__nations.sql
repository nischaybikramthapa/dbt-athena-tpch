with source as (
    select
        *
    from {{ source('tpch_raw', 'nations') }}
)
select
    nationkey as nation_key,
    name,
    regionkey as region_key,
    comment
from
    source
