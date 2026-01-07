select
    location_id,
    transaction_month,
    movie_id,
    sum(ticket_amount) as ticket_amount,
    sum(revenue) as revenue
from {{ ref("stg_union_locations") }}
group by 1, 2, 3
