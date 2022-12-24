with parts as (

    select * from {{ ref('stg__parts') }}

),
final as (

    select 
        parts.part_key,
        parts.name as part_name,
        parts.manufacturer as part_manufacturer_name,
        parts.brand as part_brand,
        parts.type as part_type,
        parts.size as part_size,
        parts.container as part_container,
        parts.retail_price as part_retail_price
    from
        parts
)
select 
    *
from
    final
order by
    part_key

