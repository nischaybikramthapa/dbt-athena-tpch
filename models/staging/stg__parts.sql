with source as (
    select
        *
    from {{ source('tpch_raw', 'parts') }}
)
select
    partkey as part_key,
    name,
    mfgr as manufacturer,
    brand,
    type,
    size,
    container,
    retailprice as retail_price,
    comment
from
    source
