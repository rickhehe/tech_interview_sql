-- Simple Machines SQL Interview
-- https://gist.github.com/lukeknxt/4b6f32445bf50f900cfbfb2cac1accc5
-- Thanks to @lukeknxt

-- Make sure you talk to yourself when coding.
-- Explain the your approach to solve the problem.

-- Q1
select order_id
  from order
 where user_id = 123

-- Q2
select order_id
  from order
 where datepart(year, date) = 2022 and datepart(month, date) = 5

-- Q3
select user_id
       , count(*) count
       , rank() over(order by count(*) desc) rank
  from order
 group by user_id

-- Q4
with x as (count, amount)
select count(*) count
       , p.price * o.quantity amount
 from order o
      join order_item t
           on o.order_id = t.order_id
      join product p
           on t.product_id = product.product_id     
group by o.user_id
)

select count
  from x
 where amount > 1000

-- Q5
select top 5
       name
  from order_item t
       join product p
            on t.product_id = p.product_id
 order by count(*) desc

-- Q6
with x as (
select count(*)
 from user u
      join order o
           on u.user_id = o.user_id
      join order_item t
           on o.order_id = t.order_id
 group by u.user_id
)

select top 5
       count
  from x
 order by count

union all

select top 5
       count
  from x
 order by count desc

-- Q7

select case when age < 30 then 'YOUNG'
            when age < 65 then 'MIDDLE_AGED'
            else 'ELDERLY'
        end age_group
       , count(*) count
  from user u
       join order o
            on u.user_id = o.user_id
 group by case when age < 30 then 'YOUNG'
               when age < 65 then 'MIDDLE_AGED'
               else 'ELDERLY'
           end
