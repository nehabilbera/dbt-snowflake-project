{% snapshot sample_snap2 %} 

    {{ 

        config( 

            target_schema= 'stripe', 

            unique_key='id', 

            strategy='check', 

            check_cols=['name'] 

        ) 

    }} 

 

    select * from stripe.sample_tab 

{% endsnapshot %} 