CREATE DATABASE employee;

USE employee;
show databases;

# DROP DATABASE employee;

# DROP TABLE employee_table;

CREATE TABLE employee_table(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(30),
emp_age VARCHAR(5),
salary INT,
city VARCHAR(20),
dob  DATE);

show tables;
select * from employee.employee_new;

SELECT * FROM employee.employee_table;

SELECT * FROM employee_table;

DELETE FROM employee_table;

INSERT INTO employee_table(emp_name, emp_age,salary,city,dob) 
			VALUES('peter', 36,66000,'Lagos','2000-11-10'),
            ('paul', 26,77000,'PH','1998-01-10'),
            ('dakson', 20,32000,'London','2005-11-10'),
            ('Doe', 30,60000,'Chicago','2000-11-10'),
            ('Dalinton', 26,77000,'PH','1998-01-10'),
            ('Mathew', 20,32000,'London','2005-11-10'),
            ('Ridwan', 30,60000,'Chicago','2000-11-10'),
            ('Alex', 26,77000,'PH','1998-01-10'),
            ('Jack', 20,32000,'London','2005-11-10'),
            ('Lovet', 30,60000,'Chicago','2000-11-10'),
            ('King', 36,50000,'Lagos','2000-11-10');
            
# Like operator
SELECT * FROM employee_table WHERE emp_name LIKE 'p%';

# LOOKING FOR JUST ONE LETTER BEFORE OR AFTER P
SELECT * FROM employee_table WHERE emp_name LIKE 'p_'; 
 
-- WORDS THAT ENDS WITH K
SELECT * FROM employee_table WHERE emp_name LIKE '%k';
-- WORDS THAT HAS E IN BETWEEN
SELECT * FROM employee_table WHERE emp_name LIKE '%e%';

SELECT * FROM employee_table WHERE emp_name LIKE '%er%';

-- FOUR UNDERSCORES MEANS IT WILL GIVE WORDS WITH FOUR LETTERS
SELECT * FROM employee_table WHERE emp_name LIKE '____';

SELECT * FROM employee_table where emp_name LIKE '___k';
SELECT * FROM employee_table where emp_name LIKE 'd__';
SELECT * FROM employee_table where emp_name LIKE '____%';
SELECT * FROM employee_table where emp_name LIKE 'p___%';

# ORDER BY
SELECT * FROM employee_table ORDER BY salary;
SELECT salary FROM employee_table ORDER BY salary;
SELECT salary FROM employee_table ORDER BY salary ASC;
SELECT * FROM employee_table ORDER BY salary DESC;

SELECT * FROM employee_table ORDER BY emp_name;
SELECT emp_name FROM employee_table ORDER BY emp_name;
SELECT emp_name FROM employee_table ORDER BY emp_name ASC;
SELECT * FROM employee_table ORDER BY emp_name DESC;

SELECT * FROM employee_table ORDER BY emp_age;
SELECT emp_age FROM employee_table ORDER BY emp_age;
SELECT emp_age FROM employee_table ORDER BY emp_age ASC;
SELECT * FROM employee_table ORDER BY emp_age DESC;

-- CLASS EXCERCISE
SELECT emp_name AS first_name, salary, city FROM employee_table ORDER BY city, first_name DESC;
SELECT emp_name AS first_name, salary, city FROM employee_table ORDER BY city, salary, first_name DESC;

SELECT * FROM employee_table;

-- SUM FUNCTION
SELECT sum(salary) FROM employee_table;
SELECT sum(salary) AS Total_salary FROM employee_table;
SELECT sum(salary) FROM employee_table where city="Lagos";

-- AVERAGE
SELECT avg(salary) FROM employee_table;
SELECT avg(salary) FROM employee_table where city="Lagos";

-- COUNT
SELECT count(city) FROM employee_table;
SELECT COUNT(*) FROM employee_table;
SELECT COUNT(*) FROM employee_table WHERE city='Lagos';
SELECT COUNT(*) FROM employee_table WHERE city='London';
SELECT COUNT(*) AS London_employees FROM employee_table WHERE city='London';

-- COUNT DISTINCT
SELECT COUNT(DISTINCT city) FROM employee_table;
SELECT DISTINCT city FROM employee_table;

-- MIN AND MAX
SELECT MIN(salary) FROM employee_table;
SELECT MAX(salary) FROM employee_table;

-- GROUP BY
SELECT count(id), city FROM employee_table GROUP BY city;
SELECT AVG(salary), city FROM employee_table GROUP BY city;

SELECT emp_age, city, count(city) FROM employee_table GROUP BY emp_age, city;

SELECT dob, city, COUNT(id) AS no_of_employee,
MAX(salary) AS max_salary,
MIN(salary) AS min_salary,
AVG(salary) AS avg_salary
FROM employee_table GROUP BY dob, city;

SELECT city, COUNT(*), AVG(salary) AS Average_salary
FROM employee_table
WHERE (salary) > 50000
GROUP BY city;

-- HAVING (PERFORMED AFTER AGGREGATION "GROUP BY")
SELECT city, COUNT(*), AVG(salary) AS Average_salary
FROM employee_table
GROUP BY city
HAVING AVG(salary) > 60000;

SELECT city, COUNT(*), AVG(salary) AS Average_salary
FROM employee_table
WHERE salary > 50000
GROUP BY city
HAVING AVG(salary) > 60000;

-- LIMIT AND OFFSET
SELECT * FROM employee_table LIMIT 5;
SELECT * FROM employee_table LIMIT 5 OFFSET 10;

INSERT INTO employee_table(emp_name, emp_age,salary,city,dob) 
VALUES('peter', 23, null, null, null),
('patrick', 27, 32000, null, '2000-10-01'),
('paul', 33, 77000, 'london', '2000-10-01'),
('john', null, null, null, null),
('paresh', 20, 60000, 'lagos', '2000-11-10');

SELECT COUNT(*) FROM employee_table;
SELECT COUNT(id) FROM employee_table;
SELECT COUNT(emp_age) FROM employee_table;
SELECT COUNT(DISTINCT emp_name) FROM employee_table;
SELECT DISTINCT emp_name, salary FROM employee_table;

-- OFFSET WORKS WHEN YOU DONT WANT TO SEE THE SPECIFIC NUMBER INDICATED
SELECT DISTINCT emp_name, salary FROM employee_table 
ORDER BY salary DESC LIMIT 5 OFFSET 3;

-- LIMIT 3,5 MEANS OFFSET BY 3 AND LIMIT TO 5 (NO OF LIMIT B4 NO OF OFFSET)
SELECT DISTINCT emp_name, salary FROM employee_table 
ORDER BY salary DESC LIMIT 3, 5;

SELECT emp_age, SUM(salary) AS total_salary,
COUNT(DISTINCT city) AS 'Num of Cities',
MIN(dob) AS youngest_employee, 
GROUP_CONCAT(city) AS cities,
GROUP_CONCAT(dob) AS DOBs 
FROM employee_table GROUP BY emp_age ORDER BY emp_age;

-- Case Statements
SELECT *, CASE WHEN salary = 50000 OR salary = 60000 THEN 'you are eligible'
WHEN salary > 70000 THEN 'this is greater than 70'
ELSE 'this is something else'
END AS salary_info 
FROM employee_table
ORDER BY salary DESC;

SELECT emp_name, salary,
CASE
	WHEN salary = 50000 OR salary=60000 THEN 'you are eligible'
    WHEN salary > 70000 THEN 'this is greater than 70'
    ELSE 'this is something else'
END AS salary_info
FROM employee_table
ORDER BY salary DESC;

SELECT *,
CASE 
	WHEN emp_age BETWEEN 20 AND 29 THEN '20 - 29'
	WHEN emp_age BETWEEN 30 AND 39 THEN '30 - 39'
ELSE 'Not applicable'
END AS 'age group'
FROM employee_table
ORDER BY emp_age DESC;

-- Subqueries
SELECT AVG(salary) FROM employee_table
WHERE city = 'lagos';

SELECT * FROM employee_table
WHERE salary > (SELECT AVG(salary) FROM employee_table
WHERE city = 'lagos');

SELECT * FROM employee_table
WHERE salary > (SELECT AVG(salary) FROM employee_table
WHERE city = 'lagos')
AND salary > (SELECT AVG(salary) FROM employee_table
WHERE city = 'chicago');

SELECT id FROM employee_table
WHERE CITY = 'lagos';

SELECT * FROM employee_table
WHERE id IN (SELECT id FROM employee_table
WHERE CITY = 'lagos');

SELECT * FROM employee_table 
WHERE CITY = 'LAGOS';

USE employee;

SELECT emp_name, emp_age, salary, city,
(SELECT AVG(emp_age) FROM employee_table e2 WHERE e2.city = e1.city) AS Avg_city_age,
(SELECT AVG(salary)  FROM employee_table e3 WHERE e3.city = e1.city) AS avg_city_salary 
FROM employee_table e1
WHERE 
emp_age > 20 AND (SELECT AVG(salary) FROM employee_table e3 WHERE e3.city = e1.city)> 50000;
;
