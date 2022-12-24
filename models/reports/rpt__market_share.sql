with fact_table as (
    select
        *
    from
        {{ ref("fct__line_orders") }}
),
date_dim as (
    select
        *
    from
        {{ ref("dim__date") }}
),
suppliers as (
    select
        *
    from
        {{ ref("dim__suppliers") }}
),
order_with_dates_and_supp as (
    select
        fact_table.*,
        date_dim.year,
        suppliers.*
    from
        fact_table
        inner join date_dim
        on fact_table.order_date = date_dim.date
        inner join suppliers
        on fact_table.supplier_key = suppliers.supplier_key
),
volume_per_country_year_part as (
    select
        supplier_country,
        year,
        part_key,
        sum(selling_price) as total_volume
    from
        order_with_dates_and_supp
    group by
        supplier_country,
        year,
        part_key
),
volume_per_year_part as (
    select
        year,
        part_key,
        sum(selling_price) as total_part_volume
    from
        order_with_dates_and_supp
    group by
        year,
        part_key
),
final as (
    select
        volume_per_year_part.year,
        volume_per_year_part.part_key,
        supplier_country,
        total_volume,
        total_part_volume,
        (
            total_volume / total_part_volume
        ) * 100 as total_market_share
    from
        volume_per_year_part
        inner join volume_per_country_year_part
        on volume_per_year_part.part_key = volume_per_country_year_part.part_key
        and volume_per_year_part.year = volume_per_country_year_part.year
)
select
    *
from
    final
