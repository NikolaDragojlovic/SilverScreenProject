SELECT
  c.movie_id,
  c.month
FROM {{ ref('int_movie_costs') }} c
LEFT JOIN {{ ref('mart_cinema_profitability') }} m
  ON c.movie_id = m.movie_id
 AND c.location_id = m.location_id
 AND c.month = m.month
WHERE m.movie_id IS NULL
