with fact_table as (
    select * from {{ ref("fct__line_orders") }} 
),

date_dim as (
    select * from {{ref("dim__date") }}
),
orders_with_dates as (
    select 
        fact_table.*,
        date_dim.year
    from fact_table
    inner join date_dim
    on fact_table.order_date = date_dim.date 
),
final as (
    select
        year,
        return_flag,
        line_status,
        sum(quantity) as total_quantity,
        sum(marked_price) as total_marked_price,
        sum(discounted_price) as total_discount,
        sum(tax_amount) as total_tax,
        avg(quantity) as avg_quantity,
        avg(marked_price) as avg_marked_price,
        avg(discounted_price) as avg_discount,
        count(*) as total_orders
    from
        orders_with_dates
    group by
        year,
        return_flag,
        line_status
)
select
    *
from
    final
