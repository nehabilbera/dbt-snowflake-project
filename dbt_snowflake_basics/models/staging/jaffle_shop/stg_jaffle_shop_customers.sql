select  

        id as customer_id, 

        first_name, 

        last_name 

 

        -- from RAW.JAFFLE_SHOP.CUSTOMERS 

 

        -- using source(source_name, table_name) 

        from {{ source('jaffle_shop', 'customers') }} 

 

 

-- other way to create model quickly 

-- dbt run-operation generate_base_model --args '{"source_name": "jaffle_shop", "table_name": "customers"}' 

 