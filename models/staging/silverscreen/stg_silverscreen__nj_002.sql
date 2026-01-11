with 

source as (

    select * from {{ source('silverscreen', 'nj_002') }}

),

renamed as (    --Transaction data for location NJ_002, aggregated by month.

    select
        {{ month_key('date') }} as transaction_month,
        --DATE_TRUNC(month,date) AS transaction_month,
        movie_id,
        ticket_amount,
        total_earned AS revenue,
        'NJ_002' AS location_id

    from source
)
    select * from renamed