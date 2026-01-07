with 

source as (

    select * from {{ source('silverscreen', 'nj_003') }}

),

renamed as (

    select
        DATE_TRUNC(month,timestamp) AS transaction_month,
        details AS movie_id,
        amount AS ticket_amount,
        total_value AS revenue,
        'NJ_003' AS location_id

    from source
   WHERE product_type = 'ticket' 


        

)

select * from renamed