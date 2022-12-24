with suppliers as (
    select
        *
    from
        {{ ref("dim__suppliers") }}
),
sales_fact as (
    select
        *
    from
        {{ ref("fct__line_orders") }}
),
distinct_supplier_info as (
    select
        distinct suppliers.supplier_region_key,
        sales_fact.part_key,
        sales_fact.supplier_key,
        suppliers.supplier_name,
        suppliers.supplier_phone_number,
        suppliers.supplier_address,
        suppliers.supplier_continent,
        suppliers.supplier_country,
        suppliers.supplier_account_balance,
        sales_fact.cost_price
    from
        sales_fact
        inner join suppliers
        on sales_fact.supplier_key = suppliers.supplier_key
),
parts as (
    select
        *
    from
        {{ ref("dim__parts") }}
),
min_part_cost as (
    select
        supplier_region_key,
        part_key,
        min(cost_price) as min_part_cost_per_region
    from
        distinct_supplier_info
    group by
        supplier_region_key,
        part_key
),
final as (
    select
        min_part_cost.supplier_region_key,
        min_part_cost.part_key,
        parts.part_manufacturer_name,
        parts.part_brand,
        parts.part_type,
        distinct_supplier_info.supplier_key,
        distinct_supplier_info.supplier_name,
        distinct_supplier_info.supplier_address,
        distinct_supplier_info.supplier_phone_number,
        distinct_supplier_info.supplier_continent,
        distinct_supplier_info.supplier_country,
        distinct_supplier_info.supplier_account_balance,
        min_part_cost.min_part_cost_per_region as lowest_cost_price
    from
        distinct_supplier_info
        inner join min_part_cost
        on distinct_supplier_info.supplier_region_key = min_part_cost.supplier_region_key
        and distinct_supplier_info.part_key = min_part_cost.part_key
        and distinct_supplier_info.cost_price = min_part_cost.min_part_cost_per_region
        inner join parts
        on min_part_cost.part_key = parts.part_key
)
select
    *
from
    final
