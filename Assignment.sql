-- Write a query to fetch all columns for all columns
use hr;
select * from employees;

-- Fetch the unique product from the orders table.
select distinct first_name from employees;

select e.first_name, d.department_name from employees e inner join 
departments d on e.department_id = d.department_id
where d.department_name = "sales";

select concat(first_name," ",last_name) as Name, salary as Income from employees;

select first_name, salary as highest_paid from employees
order by highest_paid desc limit 2;

select e.first_name, d.department_name, e.salary from employees e inner join 
departments d on e.department_id = d.department_id
where d.department_name = "sales" and e.salary > 12000;

use ecommerceinvdb;

select product_id, name, price from products where price between 20 and 100;

select name from products where name in ("Laptop Backpack","Wireless headphones");
select name from ecommerceinvdb.products where name = "Laptop Backpack" or name = "Wireless Headphones";


use hr;

select first_name from employees where first_name like "j%";

select first_name from employees where first_name like "%son%";

select 
salary,
case 
when salary > 10000 then "High"
else "NA"
end as salary_level
from employees;

use hr;

select salary,
case when salary > 10000 then "High"
else "NA"
end as salary_level
from employees;

use ecommerceinvdb;

select order_date,
coalesce(ifnull(order_date,"Pending")) as Order_details
from orders;

select 
coalesce(nullif(order_id,customer_id),"Same") as order_details
from orders;

use hr;

select concat(first_name," ",last_name) as Fullname,salary,
salary * 110 / 100 as New_Salary
from employees;

select e.first_name, e.last_name, d.department_name,e.salary from employees e
inner join departments d on e.department_id = d.department_id
where d.department_name = "Sales" or d.department_name = "Marketing"
group by e.first_name, e.last_name, d.department_name, e.salary having e.salary > 10000;

select * from employees where first_name like "a%" and salary between 10000 and 20000;

use ecommerceinvdb;

select p.product_id, p.name, count(o.quantity) as quantity_sold from products p
inner join order_items o on p.product_id = o.product_id
group by p.product_id, p.name order by quantity_sold desc;

use hr;

select count(*) as salary_greater_than_12k from employees where salary > 12000;



