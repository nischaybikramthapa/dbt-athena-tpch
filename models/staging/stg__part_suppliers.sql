with source as (
    select
        *
    from {{ source('tpch_raw', 'part_suppliers') }}
)
select
    partkey as part_key,
    suppkey as supplier_key,
    availqty as available_quantity,
    supplycost as supply_cost,
    comment
from
    source






