with nations as (
    select
        *
    from
        {{ ref('stg__nations') }}
),
regions as (
    select
        *
    from
        {{ ref('stg__regions') }}
),
final as (
    select
        nations.region_key,
        nations.nation_key,
        regions.name as continent,
        nations.name as country
    from
        nations
    inner join regions
        on nations.region_key = regions.region_key
)
select
    *
from
    final
