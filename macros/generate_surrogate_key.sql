{% macro generate_surrogate_key(field_list) %}
    {%- set fields = [] -%}
    {%- for field in field_list -%}
        {% do fields.append(
            "coalesce(cast(" ~ field ~ " as varchar ""), '')"
        ) %}
        {%- if not loop.last %}
            {%- do fields.append("'-'") -%}
        {%- endif -%}
    {%- endfor -%}

    to_hex(md5(to_utf8( {{ concat(fields)}})))
    
{% endmacro %}