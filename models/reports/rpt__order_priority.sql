with fact_table as (
    select * from {{ ref("fct__line_orders") }}
),
date_dim as (
    select * from {{ ref("dim__date") }}
),
orders_with_dates as (
    select fact_table.*,
    date_dim.date,
    date_dim.year,
    date_dim.quarter
    from fact_table
    inner join date_dim
    on fact_table.order_date = date_dim.date

),
final as (
select  year,
        order_priority,
        count(*) total_orders,
        sum(selling_price) as total_sales 
from orders_with_dates
group by year, order_priority
order by year
)
select * from final



/*
tpch-dbt demo
 - kimball method
 - some reporting table
real-time streaming
Newsletter automation - Work on this architecture

*/