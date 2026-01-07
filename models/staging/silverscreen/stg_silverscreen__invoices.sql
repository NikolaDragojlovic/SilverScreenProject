with 

source as (

    select * from {{ source('silverscreen', 'invoices') }}

),

renamed as (

    select
        movie_id,
        invoice_id,
        month,
        location_id,
        studio,
        release_date,
        weekly_price,
        total_invoice_sum

    from source

)

select * from renamed