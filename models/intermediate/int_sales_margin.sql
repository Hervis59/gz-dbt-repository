WITH sales_join AS (
SELECT *
FROM {{ref("stg_raw__sales")}} AS sales
INNER JOIN {{ref("stg_raw__product")}} AS product
    ON sales.pdt_id=product.pdt_id
GROUP BY all
),
purchase_cost_2 AS (
SELECT
    date_date,
    orders_id,
    ROUND(SUM(revenue),2) AS revenue,
    SUM(quantity) AS quantity,
    ROUND(SUM(quantity*purchase_price),2) AS purchase_cost
FROM sales_join
GROUP BY all
)
SELECT *,
    ROUND(SUM(revenue-purchase_cost),2) AS margin
FROM purchase_cost_2
GROUP BY all
