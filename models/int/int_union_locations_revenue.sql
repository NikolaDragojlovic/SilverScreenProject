SELECT   --Intermediate model that aggregates ticket sales and revenue across all cinema locations.  
    movie_id,
    transaction_month,
    location_id,
    sum(ticket_amount) as ticket_amount,
    sum(revenue) as revenue
FROM {{ ref("stg_union_locations") }}

GROUP BY 1, 2, 3
