{% macro month_key(date_column) %}
    date_trunc('month', {{ date_column }})
{% endmacro %}
