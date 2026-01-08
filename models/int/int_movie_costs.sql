select  -- Intermediate model that represents monthly movie rental costs aggregated at movie and month grain.
    i.movie_id,
    i.month,
    i.location_id,
    m.studio,
    i.rental_cost,
    m.movie_title,
    genre

from {{ ref("stg_silverscreen__invoices") }} as i 
left join {{ ref("stg_silverscreen__movie_catalog") }} as m
on i.movie_id = m.movie_id
         
         
         
        