/* Section 6.1: Using the wildcard character to select all columns
in a query */

-- Simple select statement
use sql_exc;
select * from employees;
select * from department;

-- Dot notation

select 
	employees.* , 
	department.Name 
from 
	employees
join
	department
on
	department.Id = employees.DepartmentId;

-- Section 6.2: SELECT Using Column Aliases
select
FName as "Full Name",
LName as "Last Name"
from 
employees;

-- Section 6.3: Select Individual Columns
select 
	PhoneNumber,
    Email,
    PreferredContact
from
	customers;
    
--  Sample querry (no to run)
select
	customers.PhoneNumber,
    customers.Email,
    customers.PreferredContact,
    orders.Id as OrderId
from
	customers
left join
	orders
on
	orders.CustomerId = customers.Id;

-- Equivalent Query of above (not to run)
select
	c.PhoneNumber,
    c.Email,
    c.PreferredContact,
    o.Id as OrderId
from
	customers as c
left join
	orders as o
on
	o.CustomerId = c.Id;
    
-- Section 6.4: Selecting specified number of records
-- Sample Query (Not to run)
select 
	Id, ProductName, UnitPrice, Package
from
	Product
order by 
	UnitPrice desc
limit 10;

-- Section 6.5: Selecting with Condition
-- The basic syntax of SELECT with WHERE clause 
-- The [condition] can be any SQL expression, specified using comparison or logical operators like >, <, =, <>, >=, <=,
-- LIKE, NOT, IN, BETWEEN etc.
/* 
SELECT column1, column2, columnN
FROM table_name
WHERE [condition];
*/

select cars.* from sql_exc.cars where cars.Status = 'READY';

-- Section 6.6: Selecting with CASE
-- Sample case (not to run)
select case when col1 < 50 then 'under' else 'over' end threshold
from TableName;

-- chained versin of above as follows
select 
	case when col1 < 50 then 'under'
		 when col1 > 50 and col1 < 100 then 'between'
         else 'over'
	end threshold
from TableName;
--  Test case
select 
	case when TotalCost <= 100 then 'small'
		 when TotalCost > 100 and TotalCost < 500 then 'medium'
         else 'large'
    end threshold,
    TotalCost
from sql_exc.cars;

--  Test case (run), an example of CASE inside another CASE statement
select
	case when TotalCost <= 100 then 'small'
        else
			case when TotalCost >100 and TotalCost < 500 then 'medium'
				else 'large'
			end 
	end threshold,
    TotalCost
from sql_exc.cars;

-- Section 6.8: Selecting with table alias
select e.FName, e.LName from sql_exc.employees e;

-- Not to run (sample querry)
select e.FName, e.LName, m.FName as MangerFirstName
from employees e
	join managers m on e.ManagerId = m.Id;

-- Natural Join example ()
-- create database extra_examples;
create table extra_examples.department (
	DEPT_NAME VARCHAR(20),
    MANAGER_NAME VARCHAR(255)
);

CREATE TABLE extra_examples.employee (
    EMP_ID FLOAT,
    EMP_NAME VARCHAR(20),
    DEPT_NAME VARCHAR(255)
);

INSERT INTO extra_examples.department (DEPT_NAME, MANAGER_NAME)
VALUES
    ('IT', 'ROHAN'),
    ('SALES', 'RAHUL'),
    ('HR', 'TANMAY'),
    ('FINANCE', 'ASHISH'),
    ('MARKETING', 'SAMAY');

INSERT INTO extra_examples.employee (EMP_ID, EMP_NAME, DEPT_NAME)
VALUES
    (1, 'SUMIT', 'HR'),
    (2, 'JOEL', 'IT'),
    (3, 'BISWA', 'MARKETING'),
    (4, 'VAIBHAV', 'IT'),
    (5, 'SAGAR', 'SALES');

select * from extra_examples.employee natural join extra_examples.department;

-- Section 6.9: Selecting with more than 1 condition

select FName, LName from sql_exc.employees where Salary >= 600 and DepartmentId = 2;

select FName, LName from sql_exc.employees where Salary >= 600 or DepartmentId = 2;

select FName, LName from sql_exc.employees where (Salary <= 600 and DepartmentId = 1)
												 or (Salary >= 600 and DepartmentId = 2);


-- Section 6.11: Selecting with Aggregate functions
-- AVG()
select avg(Salary) as SalaryAVG from sql_exc.employees;
-- with where clause
select avg(Salary) as SalaryAVG from sql_exc.employees where DepartmentId = 1;
-- with groupby clause 
select DepartmentId, avg(Salary) as SalarySVG from sql_exc.employees group by DepartmentId;
-- min
select DepartmentId, min(Salary) as SalaryMIN from sql_exc.employees group by DepartmentId;
-- max
select DepartmentId, max(Salary) as SalaryMAX from sql_exc.employees group by DepartmentId;
-- Count
select DepartmentId, count(Salary) as SalaryCount from sql_exc.employees group by DepartmentId;
-- with is not null
select DepartmentId, count(Salary) as SalaryCount from sql_exc.employees where ManagerId is not null group by DepartmentId;
-- distinct 
select count(distinct DepartmentId) from sql_exc.employees;
-- sum
select sum(Salary) from sql_exc.employees;
-- Section 6.12: Select with condition of multiple values from column