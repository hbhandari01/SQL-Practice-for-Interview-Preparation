# LESSON 2 PRACTICE

create database if not exists practice1;

use practice1;

# Create a table named as "Students" and "Teachers"
create table students (id int primary key, fullname varchar(50), age int, course varchar(50));
create table teachers (id int primary key, fullname varchar(50), age int, subject varchar(50));

# Inserting data into the students table

insert into students (id, fullname, age, course) values
(1,"Kanha",26,"DSA"),
(2,"Rahul",28,"DS");

select * from students;

show tables;

# Creating a database named as practice_store

create database if not exists practice_store;

use practice_store;

create table products (id int, product_name varchar(50), price int, size varchar(50));

drop table products;

# LESSON 3 PRACTICE

use practice1;

# Creating a view to see the student details

create view student_details as
select fullname, course 
from students;

select * from student_details;

# Adding a column named as roll no to the student table

alter table students add column roll_no int;
select * from students;

# Adding a column named as father name and then dropping it

alter table students add column father_name varchar(50);
alter table students drop column father_name;

# Renaming the column roll_no to "Roll_no"

alter table students rename column roll_no to Roll_no;

# Modifying the column character lenth of fullname to 100

alter table students modify column fullname varchar(100);

describe students;

alter table students rename column fullname to Full_name;

create view student_details_id_course as
select id, course from students;

# LESSON 4 PRACTICE

alter table students rename column Full_name to fullname;
alter table students rename column Roll_no to roll_no;

use practice1;
select * from students;
truncate table students;
insert into students (id,fullname,age,course,roll_no) values
(2,"Ravi",27,"Data Science",23);

# Creating a customers table in practice_store database

use practice_store;

create table customers (customer_id int, customer_name varchar(50), address varchar(50));

insert into customers (customer_id,customer_name,address) values
(10,"Akhil","Rohini"),
(11,"Ankit","Amar Colony");

select * from customers;

insert into customers (customer_id, customer_name, address) values
(13,"Dhruv","R.K.Puram");

alter table customers add primary key (customer_id);
# Creating a Foreign Key 

set sql_safe_updates = 0;
create table orders (order_id int primary key, product_id varchar(50), order_date datetime, Customer_id int,
foreign key (Customer_id) references customers(customer_id));

insert into orders (order_id, product_id, order_date, Customer_id) values
(100,"Nike Dunks","2025-08-12",10);

insert into orders (order_id, product_id, order_date, Customer_id) values
(150,'Nike Airforce','2025-08-12: 12:10:05',11);

insert into orders (order_id, product_id, order_date, Customer_id) values 
(170,'Nike Jordan','2025-11-05: 12:11:06',13);

select * from orders;

delete from orders where Customer_id = 11;

# Unique key

create table users (user_id int primary key, fullname varchar(50), email varchar(50) unique);

insert into users (user_id,fullname,email) values
(1,"Himanshu","Hb@gmail.com"),
(2,"Shashank","Hb@gmail.com");

# LESSON 5 & 6 PRACTICE

# Constrains - used to specify the rules for the data in the table.

use practice1;

select * from students;

insert into students (id, fullname, age, course, roll_no) values
(3,"Himanshu",28,"ML", 27);

update students set fullname = "Dhruv" where roll_no = 23;
update students set age = 29 where fullname = "Dhruv";
insert into students (id,fullname,age,course,roll_no) value
(5,"Kartik",29,"IT",38);
insert into students (id,fullname,age,course,roll_no) value
(7,"Akash",31,"HR",39);

delete from students where id = 5;

# LESSON 7 & 8 PRACTICE

-- SELECT STATEMENT

use ecommercedb;

select * from customers;

select distinct first_name from customers;

select first_name n, last_name l from customers;

select * from customers order by first_name desc;

select * from products;

select product_id, price from products order by price desc limit 5;

select * from products limit 7,4;

# LESSON 10 PRACTICE

-- Case statement: similar to that of the if-else statement in python

use hr;

select salary, case 
    when salary > 18000 then "Very High"
    when salary > 12000 then "Moderate"
    else "Low"
    end
from employees;

alter table employees drop column level;
alter table employees add column level varchar(50);

set sql_safe_updates = 0;

update employees 
set level = (case 
when salary > 18000 then "High"
when salary > 12000 then "Medium"
else "Low"
end);

select * from employees; 

# Coalesce: Returns the first non-value from a list of expressions.

select salary,
coalesce(manager_id,"No Manager") as reporting_manager 
from employees;


select salary,
case 
when manager_id is null then "Manager is not assigned"
else manager_id
end as reporting_manager
from employees;

select first_name,
coalesce(commission_pct,"No commission") as commission_info
from employees;


-- Nullif: if two expression are equal, otherwise it returns the first expression

select first_name,
coalesce(nullif(commission_pct,0), "New Employee") as commmission_pct
from employees;

# LESSON 13 PRACTICE

-- Union

select first_name from employees union select department_name from departments;

select first_name from employees union all select department_name from departments;

-- This query will give one output as apple
select "apple" as fruit 
union
select "apple" as fruit;

-- This query will give two output as apple
select "apple" as fruit
union all
select "apple" as fruit;

# LESSON 14 PRACTICE

-- Aggregate Functions:

select sum(salary) as total_salary from employees ;

select d.department_name, sum(e.salary) as dept_salary
from departments d join employees e on 
d.department_id = e.department_id 
group by d.department_name order by dept_salary desc;

select count(*) from employees where salary > 12000;

-- Group Concat

select group_concat (salary) from employees where salary > 12000;

select count(*) from employees where hire_date > "1991-05-21";

select count(*) from employees where hire_date between "1987-06-17" and "1991-05-21";

# LESSON 17 PRACTICE

use modelcarsdb;

select email from employees;

-- Extract domain from email
select substring_index(email, "@", -1) as domain from employees;

-- Mask part of a phone number for privacy

select concat(left("9876543210",3),"*****", right("9876543210",2)) as masked_phone from employees;

select concat(left("Himanshu",3),"****", right("Himanshu",2)) as masked_name from employees;

-- Extract first name from full name of employees

select customername from customers;

select substring_index(customername," ", 1) as first_name from customers;

# LESSON 18 PRACTICE

-- Get customers who spent more than the average order values

select customername from customers where creditlimit > (select avg(creditlimit) from customers);

-- Find orders with same productcode and quantity as order #10101

select * from orderdetails
where (productcode,quantityordered) in (select productcode, quantityordered from customers where ordernumber = 10101);


-- Correlated Subquery

-- Find the employees who have their salaries greater than the average salaries

use hr;

select e1.first_name, e1.salary, d.department_name
from employees e1 join departments d on 
e1.department_id = d.department_id
where e1.salary > (select avg(e2.salary) from employees e2 where e1.department_id = e2.department_id);

-- Find employees who have the highest salary in their department

select e.first_name, d.department_name, e.salary from employees e 
join departments d on e.department_id = d.department_id
where e.salary = (select max(salary) from employees where e.department_id = d.department_id);

-- Department wise Max salary

select d.department_name, max(e.salary) as max_salary 
from employees e join departments d 
on e.department_id = d.department_id
group by d.department_name 
order by max_salary desc;

-- Nested Subquery

select e.first_name, (select max(salary) from employees) as max_salary from employees e;


