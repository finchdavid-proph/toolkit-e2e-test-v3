{{
  config({    
    "materialized": "ephemeral"
  })
}}

WITH sq_customer AS (

  SELECT * 
  
  FROM {{ source('corebridge_source', 'Customers') }}

)
,

sq_orders AS (

  SELECT * 
  
  FROM {{ source('corebridge_source', 'Orders') }}

)
,

by_customer_id AS (

  SELECT *
  
  FROM sq_customer AS in0
  INNER JOIN sq_orders AS in1
     ON customer_id = customer_id

)
,

cleanup AS (

  SELECT 
    order_id AS order_id,
    customer_id AS customer_id,
    amount AS amount,
    100 AS account_length_days
  
  FROM by_customer_id AS in0

)
,

sum_amounts AS (

  SELECT 
    customer_id,
    COUNT(order_id) AS orders,
    SUM(amount) AS amounts,
    ANY_VALUE(account_length_days) AS account_length_days
  
  FROM cleanup AS in0
  
  GROUP BY customer_id

)


SELECT *


FROM sum_amounts
