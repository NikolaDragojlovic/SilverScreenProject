SELECT  m.movie_id,
        m.month,
        m.location_id,
        m.movie_title,
        m.genre,
        m.studio,
        m.rental_cost,
        l.ticket_amount AS tickets_sold,
        l.revenue
  FROM {{ ref('int_movie_costs') }} AS m
  LEFT JOIN {{ ref('int_union_locations_revenue') }} AS l
    ON m.movie_id = l.movie_id
    AND m.location_id = l.location_id
    AND m.month = l.transaction_month
    
