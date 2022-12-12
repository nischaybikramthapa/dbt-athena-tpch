with source as (
    select
        *
    from {{ source('tpch_raw', 'lineitem') }}
)
select
    orderkey as order_key,       
    partkey  as part_key,
    suppkey  as supplier_key,
    linenumber as line_number,
    quantity,
    extended_price,
    discount,            
    tax,          
    returnflag as return_flag,
    linestatus as line_status,
    {{ parse_date(column_name = 'shipdate') }} as ship_date,
    {{ parse_date(column_name = 'commitdate') }} as commit_date,
    {{ parse_date(column_name = 'receiptdate') }} as receipt_date,
    shipinstruct as ship_instructions,
    shipmode as ship_mode,
    comment
from
    source
