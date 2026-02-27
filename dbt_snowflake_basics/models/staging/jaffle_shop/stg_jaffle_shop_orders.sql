select  

        id as order_id, 

        user_id as customer_id, 

        order_date, 

        status, 

        _etl_loaded_at 

 

        -- from raw.jaffle_shop.orders 

         

        -- using source (source_name, table_name) 

        from {{ source('jaffle_shop', 'orders') }} 

 
