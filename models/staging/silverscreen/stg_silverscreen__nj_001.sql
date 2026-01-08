with 

source as (

    select * from {{ source('silverscreen', 'nj_001') }}

),

renamed as (     --Transaction data for location NJ_001, aggregated by month.

    select
        DATE_TRUNC(month,timestamp) :: DATE AS transaction_month,
        movie_id,
        ticket_amount,
        transaction_total AS revenue,
        'NJ_001' AS location_id


    from source

)

select * from renamed