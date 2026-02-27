-- step-2 

{{ 

    config ( 

        materialized='incremental', 

        incremental_strategy='append', 

         

        on_schema_change='append_new_columns' 

    ) 

}} 

 

-- on_schema_change='fail'  

-- it fails because I've update the schema in snowflake 

 

-- step-1 

with orders as ( 

    select * from {{ ref('stg_jaffle_shop_orders') }} 

), 

 

payments as ( 

    select * from {{ ref('stg_stripe_payments') }} 

), 

 

order_payments as ( 

    select  

        order_id, 

        sum(case when status = 'success' then amount end) as amount 

 

    from payments 

    group by 1 

), 

 

final as ( 

    select  

        o.order_id, 

        o.customer_id, 

        o.order_date, 

        coalesce (op.amount, 0) as amount 

 

    from orders o 

    left join order_payments op 

) 

 

select * from final 

 

-- step-2 

{% if is_incremental() %} 

where 

order_date >= (select max(order_date) from {{this}} ) 

{% endif %} 