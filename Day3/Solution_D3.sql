-- Assignmet day 3
------------------:

--Display the Department id, name and id and the name of its manager.
SELECT 
    d.Dnum,
    d.Dname,
    d.MGRSSN,
    e.Fname + ' ' + e.Lname AS [Manager Name]
FROM
    Departments d, Employee e
where d.MGRSSN = e.SSN;

--Display the name of the departments and the name of the projects under its control.
select 
	Dname,
	Pname
from 
	Departments d
Join
	Project p
on 
	d.Dnum = p.Dnum

--Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select 
	d.*,
	e.Fname + ' ' +e.Lname as [Employee]
from 
	Dependent d
join 
	Employee e
on d.ESSN = e.SSN

-- Display the Id, name and location of the projects in Cairo or Alex city.
select 
	Pnumber,
	Pname,
	Plocation
FROM 
	Project
where
	City IN ('Cairo', 'Alex')

--Display the Projects full data of the projects with a name starts with "a" letter.
select * 
from 
	Project 
where 
	Pname like 'a%'  -- where Pname = 'a%' is wrong

--display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select 
	Fname + ' ' + Lname as [Name]
from 
	Employee
Join
	Departments
on 
	Dnum = 30 
AND 
	Salary between 1000 and 2000

-- Retrieve the names of all employees in department 10 
-- who works more than or equal 10 hours per week on "AL Rabwah" project.
SELECT 
    e.Fname + ' ' + e.Lname AS [Name]
FROM
    Employee e
JOIN
    Works_for w ON e.SSN = w.ESSN
JOIN
    Project p ON p.Pnumber = w.Pno
WHERE
    p.Dnum = 10
    AND p.Pname = 'AL Rabwah'
    AND w.Hours >= 10;

--Find the names of the employees who directly supervised with Kamel Mohamed.
select 
	e.Fname + ' ' + e.Lname AS Employee, s.Fname + ' ' + s.Lname AS supervisor
From
	Employee e
JOIN
	Employee s ON e.Superssn = s.SSN
where
	s.Fname = 'Kamel' AND s.Lname = 'Mohamed'

/*
Retrieve the names of all employees and the names of the projects 
they are working on, sorted by the project name.
*/
SELECT 
    e.Fname + ' ' + e.Lname AS Employee,
    p.Pname AS Project
FROM
    Employee e
JOIN
    Works_for w ON e.SSN = w.ESSN
JOIN
    Project p ON p.Pnumber = w.Pno
ORDER BY
    p.Pname

/*
For each project located in Cairo City, find the project number, 
the controlling department name ,the department manager last name,
address and birthdate.
*/
SELECT
	p.Pnumber,
	d.Dname,
	e.Lname,
	e.Address,
	e.Bdate
FROM Project p
JOIN
	Departments d ON d.Dnum = p.Dnum
JOIN
	Employee e ON e.SSN = d.MGRSSN
WHERE
	p.City = 'Cairo'

-- Display All Data of the mangers
SELECT
	e.*
FROM Employee e
JOIN
	Departments d ON e.SSN = d.MGRSSN

/*
Display All Employees data and the data of their dependents 
even if they have no dependents 
*/
SELECT 
	e.*,
	d.*
FROM 
	Employee e
LEFT JOIN
	Dependent d
ON
	e.SSN = d.ESSN


----- Part2 | DML -----
/*
1.	Insert your personal data to the employee table as a new employee 
in departmentnumber 30, SSN = 102672, Superssn = 112233, salary=3000.
*/
insert into Employee
Values('Youssef', 'Sherif', 102672, 17/10/2003, 'Cairo', 'M', 3000, 112233, 30)

/*
Insert another employee with personal data your friend as new employeein department
number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.
*/

insert into Employee
Values('Mohsen', 'Mohamed', 102660, 1/1/2003, 'Cairo', 'M', NULL, NULL, 30)

--Upgrade your salary by 20 % of its last value.
update Employee
	set Salary = Salary * 1.2
where SSN = 102672
