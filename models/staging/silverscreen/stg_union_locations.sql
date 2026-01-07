SELECT *
  FROM {{ ref('stg_silverscreen__nj_001') }}
UNION ALL 

SELECT *
  FROM {{ ref('stg_silverscreen__nj_002') }}
UNION ALL

SELECT *
  FROM {{ ref('stg_silverscreen__nj_003') }}