with suppliers as (

    select * from {{ ref('stg__suppliers') }}

),
demographics as (
    select * from {{ ref("int__demographics") }}
),
final as (

    select 
        suppliers.supplier_key,
        suppliers.name as supplier_name,
        suppliers.address as supplier_address,
        demographics.nation_key as supplier_nation_key,
        demographics.country as supplier_country,
        demographics.region_key as supplier_region_key,
        demographics.continent as supplier_continent,
        suppliers.phone as supplier_phone_number,
        suppliers.account_balance as supplier_account_balance
    from
        suppliers
        join
        demographics
            on suppliers.nation_key = demographics.nation_key
    order by 
    suppliers.supplier_key
)
select * from final
