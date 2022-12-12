{% macro calculate_selling_price(
        marked_price,
        discount,
        tax
    ) %}
    round(
            {{ marked_price }} - ({{ get_amount(marked_price, discount) }}) + (
                (
                    {{ marked_price }} - ({{get_amount(marked_price, discount)}})
                ) * {{ tax }}
            ),
            2
        )
{% endmacro %}
