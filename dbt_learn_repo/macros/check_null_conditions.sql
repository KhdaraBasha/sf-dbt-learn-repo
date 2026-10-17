{% macro check_null_conditions(columns) -%}
    {% set null_conditions = [] %}
    {% for column in columns %}
        {% do null_conditions.append(adapter.quote(column) ~ ' IS NULL') %}
    {% endfor %}
    {{ null_conditions | join(' OR ') }}
{% endmacro %}