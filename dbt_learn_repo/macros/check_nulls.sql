{% macro check_nulls(table_name, columns) %}
    {% set null_checks = [] %}

    {% for column in columns %}
        {% do null_checks.append(adapter.quote(column) ~ ' IS NULL') %}
    {% endfor %}

    select
        *,
        CASE 
            WHEN {{ null_checks | join(' OR ') }} THEN 'FAIL'
            ELSE 'PASS'
        END as null_check_status
    from {{ table_name }}
{% endmacro %}