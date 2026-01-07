select
    i.movie_id,
    month,
    location_id,
    i.studio,
    total_invoice_sum AS rental_cost,
    movie_title,
    coalesce(genre, 'UNKNOWN') as genre

from {{ ref("stg_silverscreen__invoices") }} as i
left join {{ ref("stg_silverscreen__movie_catalog") }} as m on i.movie_id = m.movie_id
