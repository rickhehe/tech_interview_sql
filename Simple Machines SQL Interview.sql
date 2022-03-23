-- Simple Machines SQL Interview
-- https://gist.github.com/lukeknxt/4b6f32445bf50f900cfbfb2cac1accc5
-- Thanks to @lukeknxt

-- Make sure you talk to yourself WHEN coding.
-- Explain the your approach to solve the problem.

-- Q1
SELECT order_id
  FROM order
 WHERE user_id = 123;

-- Q2
SELECT order_id
  FROM order
 WHERE datepart(year, date) = 2022 and datepart(mONth, date) = 5;

-- Q3
SELECT user_id
       , COUNT(*) COUNT
       , RANK() OVER(ORDER BY COUNT(*) DESC) rank
  FROM order
 GROUP BY user_id;

-- Q4
WITH x AS (COUNT, amount)
SELECT COUNT(*) COUNT
       , p.price * o.quantity amount
 FROM order o
      JOIN order_item t
           ON o.order_id = t.order_id
      JOIN product p
           ON t.product_id = product.product_id     
GROUP BY o.user_id
)

SELECT COUNT
  FROM x
 WHERE amount > 1000;

-- Q5
SELECT top 5
       name
  FROM order_item t
       JOIN product p
            ON t.product_id = p.product_id
 ORDER BY COUNT(*) DESC;

-- Q6
WITH x AS (
SELECT COUNT(*)
 FROM user u
      JOIN order o
           ON u.user_id = o.user_id
      JOIN order_item t
           ON o.order_id = t.order_id
 GROUP BY u.user_id
)

SELECT top 5
       COUNT
  FROM x
 ORDER BY COUNT

UNION ALL

SELECT top 5
       COUNT
  FROM x
 ORDER BY COUNT DESC;

-- Q7

SELECT CASE WHEN age < 30 THEN 'YOUNG'
            WHEN age < 65 THEN 'MIDDLE_AGED'
            ELSE 'ELDERLY'
        END age_group
       , COUNT(*) COUNT
  FROM user u
       JOIN order o
            ON u.user_id = o.user_id
 GROUP BY CASE WHEN age < 30 THEN 'YOUNG'
               WHEN age < 65 THEN 'MIDDLE_AGED'
               ELSE 'ELDERLY'
           END;
