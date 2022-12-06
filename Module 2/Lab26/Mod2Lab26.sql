use employees_mod;

DELIMITER $$
CREATE PROCEDURE emp()
BEGIN
SELECT * FROM t_employees
LIMIT 1000;
END$$

CALL emp();

# 2. Create a procedure that will provide the average salary of all employees

DELIMITER $$
CREATE PROCEDURE avg_sal()
BEGIN
SELECT ROUND(AVG(salary), 2) AS "Rounded Avg." FROM t_salaries;
END$$

CALL avg_sal();

# 3. Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.

DELIMITER $$
CREATE PROCEDURE emp_info(IN first_name VARCHAR(30), IN last_name VARCHAR(30))
BEGIN
	SELECT 
		emp_no
	FROM 
		t_employees emp
	WHERE 
		emp.first_name = first_name 
    AND 
		emp.last_name = last_name;
END $$
DELIMITER ;

# 4. Call the procedures

CALL emp_info('Mary', 'Sluis');

# 5. Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.
# Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

DELIMITER $$
CREATE FUNCTION emp_info (first_name VARCHAR (30), last_name VARCHAR (30))
RETURNS DECIMAL (10,2) 

DETERMINISTIC 

BEGIN
	DECLARE v_max_from_date DATE;
	DECLARE v_salary DECIMAL(10,2);

SELECT max(from_date) INTO v_max_from_date 
FROM t_employees emp 
JOIN t_salaries sal
ON sal.emp_no=emp.emp_no

WHERE emp.first_name = first_name and emp.last_name = last_name;
SELECT sal.salary INTO v_salary
FROM t_employees emp
JOIN t_salaries sal
ON sal.emp_no=emp.emp_no
WHERE emp.first_name=first_name AND emp.last_name=last_name AND sal.from_date = v_max_from_date;
RETURN v_salary; 
END$$ 
DELIMITER ;

SELECT emp_info('Mary', 'Sluis');

# 6. Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)

DELIMITER $$
CREATE TRIGGER trig_hire_date 
BEFORE INSERT ON t_employees
FOR EACH ROW 
BEGIN 
	IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') 
		THEN    
			SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');    
	END IF; 
END $$ 
DELIMITER ;
  
INSERT
	t_employees
VALUES
	('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01'); 
SELECT 
	* 
FROM 
	t_employees
ORDER BY
	emp_no DESC;

# 7. Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.

CREATE INDEX i_hire_date ON t_employees(hire_date);
ALTER TABLE t_employees DROP INDEX i_hire_date;

# 8. Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
# Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.

SELECT * FROM t_salaries
WHERE salary > '89000';

CREATE INDEX i_salary ON t_salaries(salary);

ALTER TABLE t_salaries DROP INDEX i_salary;

# 9. Use Case statement and obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee. 

SELECT
    e.emp_no,
	e.first_name,
	e.last_name,
	CASE
    	WHEN dm.emp_no IS NOT NULL THEN 'Manager'
    	ELSE 'Employee'
	END AS is_manager
FROM
	t_employees e
    	LEFT JOIN
	t_dept_manager dm ON dm.emp_no = e.emp_no
WHERE
	e.emp_no > 109990;


# 10. Extract a dataset containing the following information about the managers: employee number, first name, and last name. Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, and another one saying whether this salary raise was higher than $30,000 or NOT.

SELECT
    dm.emp_no,
	e.first_name,
	e.last_name,
	MAX(s.salary) - MIN(s.salary) AS salary_difference,
	CASE
    	WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
    	ELSE 'Salary was NOT raised by more then $30,000'
	END AS salary_raise
FROM
	t_dept_manager dm
    	JOIN
	t_employees e ON e.emp_no = dm.emp_no
    	JOIN
	t_salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

# 11. Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t. Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. *

SELECT
    e.emp_no,
	e.first_name,
	e.last_name,
	CASE
    	WHEN MAX(de.to_date) >= SYSDATE() THEN 'Is still employed'
    	ELSE 'Not an employee anymore'
	END AS current_employee
FROM
	t_employees e
    	JOIN
	t_dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;