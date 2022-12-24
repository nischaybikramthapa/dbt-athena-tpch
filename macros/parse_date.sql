{% macro parse_date(
        column_name,
        format = '%Y-%m-%d'
    ) %}
    case
        when {{ column_name }} like '%-%-%' then date_parse(
            {{ column_name }},
            '{{ format }}'
        )
        else NULL
    end
{% endmacro %}
