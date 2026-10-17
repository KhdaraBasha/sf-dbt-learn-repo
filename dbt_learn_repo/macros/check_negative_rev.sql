{% macro check_negative_rev(table_name, revenue_columns=['claim_amount']) %}
	select
		*,
		{% for column in revenue_columns %}
			case
				when {{ adapter.quote(column) }} <= 0 then 'FAIL'
                else 'PASS'
			end as {{ adapter.quote(column ~ '_negative_or_zero_flag') }}{% if not loop.last %},{% endif %}
		{% endfor %}
	from {{ table_name }}
{% endmacro %}
