with source as (
    select
        *
    from {{ source('tpch_raw', 'suppliers') }}
)
select
    suppkey as supplier_key,
    name,
    address,
    nationkey as nation_key,
    cast (replace(phone, '-') as bigint) as phone,
    acctbal as account_balance,
    comment
from
    source
