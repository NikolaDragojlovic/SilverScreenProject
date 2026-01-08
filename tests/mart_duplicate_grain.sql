SELECT
  movie_id,
  location_id,
  month,
  COUNT(*) AS row_count
FROM {{ ref('mart_cinema_profitability') }}
GROUP BY 1, 2, 3
HAVING row_count > 1
