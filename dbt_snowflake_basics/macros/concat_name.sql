    {% macro concat_name(first_name, last_name) %}
        concat({{first_name}}, ' ', {{last_name}})
    {% endmacro %}
