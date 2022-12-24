with source as(
    select
        *
    from
        {{ source(
            'tpch_raw',
            'orders'
        ) }}
)
select
    orderkey as order_key,
    custkey as customer_key,
    orderstatus as order_status,
    totalprice as total_price,
    {{ parse_date(column_name = 'orderdate') }} as order_date,
    "order-priority" as order_priority,
    clerk,
    "ship-priority" as ship_priority,
    comment
from
    source
