{% snapshot sample_snap %} 

    {{ 

        config( 

            target_schema= 'stripe', 

            unique_key='id', 

            strategy='timestamp', 

            updated_at='update_at_time' 

        ) 

    }} 

 

    select * from stripe.sample_table 

{% endsnapshot %} 
