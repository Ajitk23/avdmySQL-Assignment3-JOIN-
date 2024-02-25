CREATE DATABASE avd;
USE avd;

CREATE TABLE departments(
    department_id int Primary key,
    department_name varchar(20)
);

CREATE TABLE employee(
    employee_id INT primary key,
    name varchar(30),
    department_id int,
    salary DECIMAL(10, 2)

);

#Inserting data into both the tables

INSERT INTO departments VALUES (1, 'IT'), (2, 'HR'), (3, 'Marketing');

INSERT INTO employee values (1, 'Rajat', 1, 60000.00),
(2, 'Hari', 1, 65000.00),
(3, 'Kiran', 2, 55000.00),
(4, 'Ram', 2, 60000.00),
(5, 'Sundar', 3, 70000.00),
(6, 'Soumya', 3, 68000.00),
(7, 'Suman', 3, 65000.00);

SELECT * FROM departments;

SELECT * FROM employee;


#1.	Write a query to display employees who is getting minimum salary than the other employees working in same departments.

SELECT e1.*
FROM employee e1
JOIN employee e2 ON e1.department_id = e2.department_id AND e1.salary < e2.salary
GROUP BY e1.employee_id;


#2.	Write a query to display employee who joined first as compare to other employee in each department.
ALTER TABLE employee ADD COLUMN doj DATE;
UPDATE employee
SET doj = CASE employee_id
    WHEN 1 THEN '2022-01-10'
    WHEN 2 THEN '2022-02-15' 
    WHEN 3 THEN '2022-03-20'
    WHEN 4 THEN '2022-04-25'
    WHEN 5 THEN '2022-05-30'
    WHEN 6 THEN '2022-06-05'
    WHEN 7 THEN '2022-07-10'
    END;
SELECT * FROM employee;

SELECT e1.*, d.department_name
FROM employee e1
JOIN departments d ON e1.department_id = d.department_id
LEFT JOIN employee e2 ON e1.department_id = e2.department_id AND e1.doj > e2.doj
WHERE e2.employee_id IS NULL;

#3. Write a SQL query to retrieve the names of employees along with their department names. If one employee has 
#no department a then displayed as "No Department".

#lets add one employee without department_id

INSERT INTO employee (employee_id, name, salary, doj) values (8, 'Guru', '50000', '2019-8-24')

SELECT e.name AS employee_name, COALESCE(d.department_name, 'No Department') AS department_name
FROM employee e
LEFT JOIN departments d ON e.department_id = d.department_id;


#4.	Write a query to find the total salary expenditure for each department?

SELECT d.department_id, d.department_name, sum(e.salary) AS total_expenditure
FROM departments d 
LEFT JOIN employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;


#5.	Write a query to identify departments where the average salary is higher than the company-wide average salary?
SELECT d.department_id, d.department_name
FROM departments d
JOIN employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) > (SELECT AVG(SALARY) FROM employee);