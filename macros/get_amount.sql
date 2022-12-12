{% macro get_amount(
        marked_price,
        percent
    ) %}
    {{ marked_price }} * {{ percent }}
{% endmacro %}
