 --Union of all locations NJ_001, NJ_002, and NJ_003 into a single model.
 SELECT *          --All data is standardized with columns: transaction_month, movie_id, ticket_amount, revenue, location_id.
  FROM {{ ref('stg_silverscreen__nj_001') }}
UNION ALL 

SELECT *
  FROM {{ ref('stg_silverscreen__nj_002') }}
UNION ALL

SELECT *
  FROM {{ ref('stg_silverscreen__nj_003') }}