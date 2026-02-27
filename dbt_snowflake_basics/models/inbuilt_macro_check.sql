select  

    {{ dbt_utils.generate_surrogate_key(['id']) }} as surr_key 

from {{ source('jaffle_shop', 'custom_macro_check') }} 

 
