with 

source as (

    select * from {{ source('silverscreen', 'invoices') }}

),

renamed as (

   /*select
       {{ dbt_utils.generate_surrogate_key(['movie_id', 'month','location_id','release_date']) }} AS id,
        movie_id,
        invoice_id,
        month,
        location_id,
        studio,
        release_date,
        weekly_price,
        total_invoice_sum AS rental_cost
    FROM source
   
)*/
SELECT
    movie_id,
    location_id,
    month,
    MAX(total_invoice_sum) AS rental_cost,
    COUNT(DISTINCT invoice_id) AS invoice_count
FROM source
GROUP BY
    movie_id,
    location_id,
    month


)

select * from renamed
-- WHERE id IN (SELECT id FROM renamed GROUP BY ID HAVING COUNT(*) = 1)