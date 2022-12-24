with orders as (
    select
        *
    from
        {{ ref("stg__orders") }}
),
lineitem as (
    select
        *
    from
        {{ ref("stg__lineitem") }}
),
part_supplier as (
    select
        *
    from
        {{ ref("stg__part_suppliers") }}
)
select
    {{ generate_surrogate_key(['lineitem.order_key', 'lineitem.line_number']) }} as order_item_key,
    orders.order_key,
    orders.customer_key as order_customer_key,
    lineitem.part_key,
    lineitem.supplier_key,
    lineitem.line_number,
    orders.order_date,
    lineitem.commit_date,
    lineitem.ship_date,
    lineitem.receipt_date,
    orders.order_priority,
    orders.ship_priority,
    lineitem.return_flag,
    lineitem.line_status,
    lineitem.quantity,
    lineitem.extended_price as marked_price,
    round(lineitem.discount * 100, 2) as discount_percentage,
    round(lineitem.tax * 100, 2) as tax_percentage,
    {{ get_amount(
        marked_price = 'lineitem.extended_price',
        percent = 'discount'
    ) }} as discounted_price,
    {{ get_amount(
        marked_price = 'lineitem.extended_price',
        percent = 'tax'
    ) }} as tax_amount,
    {{ calculate_selling_price(
        marked_price = 'lineitem.extended_price',
        discount = 'lineitem.discount',
        tax = 'lineitem.tax'
    ) }} as selling_price,
    orders.total_price as order_total_price,
    part_supplier.supply_cost as cost_price,
    part_supplier.available_quantity as available_quantity,
    lineitem.ship_mode
from
    orders
    inner join lineitem
    on orders.order_key = lineitem.order_key
    inner join part_supplier
    on lineitem.part_key = part_supplier.part_key
    and lineitem.supplier_key = part_supplier.supplier_key
order by
    orders.order_date
