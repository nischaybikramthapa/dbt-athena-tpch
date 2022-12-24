with source as (
    select
        *
    from {{ source('tpch_raw', 'customers') }}
)
select
    custkey as customer_key,
    name,
    address,
    nationkey as nation_key,
    cast (replace(phone, '-') as bigint) as phone,
    acctbal as account_balance,
    mktsegment as market_segment,
    comment
from
    source
