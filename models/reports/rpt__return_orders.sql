with fact_table as (
    select
        *
    from
        {{ ref("fct__line_orders") }}
),
customers as (
    select
        *
    from
        {{ ref("dim__customers") }}
),
parts as (
    select
        *
    from
        {{ ref("dim__parts") }}
),
final as (
    select
        fact_table.*,
        customers.customer_name,
        customers.customer_address,
        customers.customer_country,
        customers.customer_continent,
        customers.customer_account_balance,
        customers.customer_market_segment,
        parts.part_name,
        parts.part_manufacturer_name,
        parts.part_brand,
        parts.part_type,
        parts.part_size
    from
        fact_table
        inner join customers
        on fact_table.order_customer_key = customers.customer_key
        inner join parts
        on fact_table.part_key = parts.part_key
    where
        return_flag = 'R'
)
select
    *
from
    final
