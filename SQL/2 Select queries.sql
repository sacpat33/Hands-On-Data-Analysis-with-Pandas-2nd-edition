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
select * from sql_exc.cars where status in ('WAITING', 'WORKING');

-- equivaleny Querry 
select * from sql_exc.cars where (status = 'WAITING' or status = 'WORKING');

-- i.e. value IN ( <value list> ) is a shorthand for disjunction (logical OR)

-- Section 6.13: Get aggregated result for row groups
-- Sample quuerry (Not to run)
select category, count(*) as item_count 
from item
group by category;

-- Example Query 
select DepartmentId, avg(Salary) as SalaryAVG
from sql_exc.employees 
group by DepartmentId;

-- Example Query with additions 
select e.DepartmentId, d.Name as DeptName, avg(e.Salary) as SalaryAVG
from sql_exc.employees e
join sql_exc.department d
on e.DepartmentId = d.Id
group by DepartmentId;

-- There WHERE clause can also be used with GROUP BY, but WHERE filters out records before any grouping is done:
-- sample query (not to run)
select department, AVG(income)
from employees
where departement <> 'Accounts'
group by department;

-- If you need to filter the results after the grouping has been done, e.g, to see only departments whose average
-- income is larger than 1000, you need to use the HAVING clause
-- sample query (not to run)
select department, AVG(income)
from employees
where departement <> 'Accounts'
group by department
having AVG(income) > 1000;

-- Example Query (to run)
select DepartmentId, avg(Salary) as SalaryAVG
from sql_exc.employees 
where ManagerId is not null
group by DepartmentId
having SalaryAVG > 500;

-- Section 6.14: Selection with sorted Results
-- Sample query (to run)
select * from sql_exc.employees order by LName;
select * from sql_exc.employees order by LName desc;
select * from sql_exc.employees order by LName asc;

-- multi coloumn sorting 
select * from sql_exc.employees order by LName asc, FName asc;
-- sorting by using the coloumn number 

select Id, FName, LName, PhoneNumber from sql_exc.employees order by 3 desc;

-- You may also embed a CASE statement in the ORDER BY clause (sorting at top)
select Id, FName, LName, PhoneNumber from sql_exc.employees order by case when LName = 'Smith' then 0 else 1 end asc;

-- Section 6.15: Selecting with null
select FName from sql_exc.employees where ManagerId is null;

-- Section 6.16: Select distinct (unique values only)
select distinct Status from sql_exc.cars;
select distinct ContinentCode from sql_exc.countries;

-- Section 6.17: Select rows from multiple tables
-- This is called cross product in SQL it is same as cross product in sets
SELECT *
FROM
table1,
table2;

SELECT
table1.column1,
table1.column2,
table2.column1
FROM
table1,
table2;

/* This is called cross product in SQL it is same as cross product in sets
These statements return the selected columns from multiple tables in one query.
There is no specific relationship between the columns returned from each table. */

select * from sql_exc.employees, sql_exc.department