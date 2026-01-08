SELECT *
FROM {{ ref('mart_cinema_profitability') }}
WHERE revenue < 0
   OR rental_cost < 0
   OR tickets_sold < 0
