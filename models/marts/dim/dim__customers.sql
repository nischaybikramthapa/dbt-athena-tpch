with customers as (
    select
        *
    from
        {{ ref('stg__customers') }}
),
demographics as (
    select * from {{ ref("int__demographics")}}
),
final as (
    select
        customers.customer_key,
        customers.name as customer_name,
        customers.address as customer_address,
        demographics.region_key as customer_region_key,
        demographics.nation_key as customer_nation_key,
        demographics.country as customer_country,
        demographics.continent as customer_continent,
        customers.phone as customer_phone_number,
        customers.account_balance as customer_account_balance,
        customers.market_segment as customer_market_segment
    from
        customers
        left join demographics
        on customers.nation_key = demographics.nation_key
    order by
    customers.customer_key
)
select * from final

