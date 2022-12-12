with series as (
    select
        x as id,
        date_add('day', x, date '{{var("start_date")}}') as dt
    from
        unnest(sequence(1,date_diff('day', date '{{var("start_date")}}', date '{{var("end_date")}}'), 1 )) t(x)
),
base as (
    select
        id,
        dt as date,
        year(dt) as year,
        quarter(dt) as quarter,
        cast(date_format(dt, '%m') as integer) as month,
        date_format(dt,'%M') as month_name,
        day(dt) as day,
        date_format(dt,'%W') as day_of_week_name,
        week(dt) as week_num,
        date_trunc('week', dt) as week_begin_date,
        date_trunc('week',dt) + interval '6' day as week_end_date,
        date_trunc('month', dt) as first_day_of_month,
        date_trunc('month', dt + interval '1' month) - interval '1' day as last_day_of_month,
        date_trunc('quarter', dt) as first_day_of_quarter,
        date_trunc('quarter', dt + interval '3' month) - interval '1' day as last_day_of_quarter,
        date_format(dt,'%Y-01-01') as first_day_of_year,
        date_format(dt,'%Y-12-31') as last_day_of_year,
        if(day_of_week(dt) <= 5, 1, 0) as is_weekday,
        date_trunc('day', current_date) as created_dt,
        date_trunc('day', current_date) as updated_dt,
        'N' as delete_flag,
        'Y' as current_flag,
        'Generated' as source
    from
        series
)
select
    *
from
    base
