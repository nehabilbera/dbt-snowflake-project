select  

    id, 

    {{ concat_name('first_name', 'last_name') }} as full_name 

from {{ source('jaffle_shop', 'customers') }} 
