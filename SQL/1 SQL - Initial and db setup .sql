-- use sql_exc; 
select cast(123 as decimal(5,2));
select cast(12345.12 as decimal(10,5));
select cast(PI() as float8);
select cast('ABC' as char(10)); -- character defination
select cast(12345 as binary(1));
select cast('ABCDEFGHIJKLMNOPQRSTUVWXYZ' as char(12))

/* Example Databases and Tables */
-- Section 5.1: Auto Shop Database
CREATE TABLE Department(
Id INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(25) NOT NULL,
PRIMARY KEY(Id)
)

SELECT * FROM sql_exc.department;
 
INSERT INTO sql_exc.department
VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Tech')


CREATE TABLE Employees (
Id INT NOT NULL AUTO_INCREMENT,
FName VARCHAR(35) NOT NULL,
LName VARCHAR(35) NOT NULL,
PhoneNumber VARCHAR(11),
ManagerId INT,
DepartmentId INT NOT NULL,
Salary INT NOT NULL,
HireDate DATETIME NOT NULL,
PRIMARY KEY(Id),
FOREIGN KEY (ManagerId) REFERENCES Employees(Id),
FOREIGN KEY (DepartmentId) REFERENCES sql_exc.department(Id)
);

select * from sql_exc.employees

INSERT INTO sql_exc.employees
/* (Id, FName, LName, PhoneNumber, [ManagerId], [DepartmentId], [Salary], [HireDate]) */
VALUES
(1, 'James', 'Smith', 1234567890, NULL, 1, 1000, '2002-01-01'),
(2, 'John', 'Johnson', 2468101214, '1', 1, 400, '2005-03-23'),
(3, 'Michael', 'Williams', 1357911131, '1', 2, 600, '2009-05-12'),
(4, 'Johnathon', 'Smith', 1212121212, '2', 1, 500, '2016-07-24')
;

use sql_exc;
CREATE TABLE Customers (
Id INT NOT NULL AUTO_INCREMENT,
FName VARCHAR(35) NOT NULL,
LName VARCHAR(35) NOT NULL,
Email varchar(100) NOT NULL,
PhoneNumber VARCHAR(11),
PreferredContact VARCHAR(5) NOT NULL,
PRIMARY KEY(Id)
);

INSERT INTO Customers
VALUES
(1, 'William', 'Jones', 'william.jones@example.com', '3347927472', 'PHONE'),
(2, 'David', 'Miller', 'dmiller@example.net', '2137921892', 'EMAIL'),
(3, 'Richard', 'Davis', 'richard0123@example.com', NULL, 'EMAIL');

select * from sql_exc.customers;

use sql_exc;
CREATE TABLE Cars (
Id INT NOT NULL AUTO_INCREMENT,
CustomerId INT NOT NULL,
EmployeeId INT NOT NULL,
Model varchar(50) NOT NULL,
Status varchar(25) NOT NULL,
TotalCost INT NOT NULL,
PRIMARY KEY(Id),
FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
FOREIGN KEY (EmployeeId) REFERENCES Employees(Id)
);
INSERT INTO Cars
VALUES
('1', '1', '2', 'Ford F-150', 'READY', '230'),
('2', '1', '2', 'Ford F-150', 'READY', '200'),
('3', '2', '1', 'Ford Mustang', 'WAITING', '100'),
('4', '3', '3', 'Toyota Prius', 'WORKING', '1254')
;
select * from sql_exc.cars;

/* Library Database */

use sql_exc;
CREATE TABLE Authors (
    Id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(70) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    PRIMARY KEY(Id)
);

CREATE TABLE Books (
    Id INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(50) NOT NULL,
    PRIMARY KEY(Id)
);

CREATE TABLE BooksAuthors (
    AuthorId INT NOT NULL,
    BookId  INT NOT NULL,
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id),
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);

INSERT INTO Authors
    (Name, Country)
VALUES
    ('J.D. Salinger', 'USA'),
    ('F. Scott. Fitzgerald', 'USA'),
    ('Jane Austen', 'UK'),
    ('Scott Hanselman', 'USA'),
    ('Jason N. Gaylord', 'USA'),
    ('Pranav Rastogi', 'India'),
    ('Todd Miranda', 'USA'),
    ('Christian Wenz', 'USA')
;

INSERT INTO Books
    (Id, Title)
VALUES
    (1, 'The Catcher in the Rye'),
    (2, 'Nine Stories'),
    (3, 'Franny and Zooey'),
    (4, 'The Great Gatsby'),
    (5, 'Tender id the Night'),
    (6, 'Pride and Prejudice'),
    (7, 'Professional ASP.NET 4.5 in C# and VB')
;

INSERT INTO BooksAuthors
    (BookId, AuthorId)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 3),
    (7, 4),
    (7, 5),
    (7, 6),
    (7, 7),
    (7, 8)
;

select * from Authors;

select * from Books;

select * from BooksAuthors;

select
ba.AuthorID,
a.Name as AuthorName,
ba.BookID,
b.Title as BookTitle
from booksauthors as ba 
inner join authors as a on a.Id = ba.AuthorId
inner join books as b on b.Id = ba.BookId;



SELECT
  ba.AuthorId,
  a.Name AuthorName,
  ba.BookId,
  b.Title BookTitle
FROM BooksAuthors ba
  INNER JOIN Authors a ON a.id = ba.authorid
  INNER JOIN Books b ON b.id = ba.bookid
;

-- schema Countries table 
CREATE TABLE Countries (
    Id INT NOT NULL AUTO_INCREMENT,
    ISO VARCHAR(2) NOT NULL,
    ISO3 VARCHAR(3) NOT NULL,
    ISONumeric INT NOT NULL,
    CountryName VARCHAR(64) NOT NULL,
    Capital VARCHAR(64) NOT NULL,
    ContinentCode VARCHAR(2) NOT NULL,
    CurrencyCode VARCHAR(3) NOT NULL,
    PRIMARY KEY(Id)
)
;

-- data 
INSERT INTO Countries
    (ISO, ISO3, ISONumeric, CountryName, Capital, ContinentCode, CurrencyCode)
VALUES
    ('AU', 'AUS', 36, 'Australia', 'Canberra', 'OC', 'AUD'),
    ('DE', 'DEU', 276, 'Germany', 'Berlin', 'EU', 'EUR'),
    ('IN', 'IND', 356, 'India', 'New Delhi', 'AS', 'INR'),
    ('LA', 'LAO', 418, 'Laos', 'Vientiane', 'AS', 'LAK'),
    ('US', 'USA', 840, 'United States', 'Washington', 'NA', 'USD'),
    ('ZW', 'ZWE', 716, 'Zimbabwe', 'Harare', 'AF', 'ZWL')
;
use sql_exc;
select * from countries;