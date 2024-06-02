		-- Solution of Assignment Day 4 -- 
		--             DQL
/*
1.	Display (Using Union Function)
	a. The name and the gender of the dependence that's gender is Female and depending on Female Employee.
	b. And the male dependence that depends on Male Employee.
*/
select d.Dependent_name, d.sex
from Dependent d
JOin Employee e on e.SSN = d.ESSN and e.Sex = 'F' and d.sex = 'F'
union all
select d.Dependent_name, d.sex
from Dependent d
JOin Employee e on e.SSN = d.ESSN and e.Sex = 'M' and d.sex = 'M'

--2. For each project, list the project name and the total hours per week (for all employees) spent on that project.
select Pname, sum(Hours)
from Project join Works_for on Pnumber = pno
group by Pname

--3. Display the data of the department which has the smallest employee ID over all employees' ID.
select *
from Departments
where Dnum = (
    select Dno from Employee
    where SSN = (select min(SSN) from Employee)
)

--4.For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select min(Salary) as Min_Salary, max(Salary) as Max_Salary, avg(Salary) as Average
from Departments Join Employee ON Dno = Dnum 
group by Dname

--5.List the last name of all managers who have no dependents.
select Lname from Employee join Departments on SSN = MGRSSN 
LEFT JOIN Dependent on SSN = ESSN and ESSN is null

-- another solution (Subquery)
select Lname from Employee 
where SSN = (
	select MGRSSN from Departments 
	where MGRSSN not in ( select ESSN from Dependent)
)

/* 6.For each department .. if its average salary is less than the average salary of all employees ..
 display its number, name and number of its employees. */

 select Dnum, Dname, count(SSN) as[No. of Employees]
 from Departments JOIN Employee on Dnum = Dno 
 group by Dnum, Dname 
 having avg(Salary) < (select avg (Salary) from Employee)
 

 /*
 7.	Retrieve a list of employees and the projects they are working on ordered by
 department and within each department, ordered alphabetically by last name, first name.
 */
 select e.*, p.*
 from Employee e
 join Departments d on e.dno = d.Dnum
 join Project p on d.Dnum = p.Dnum
 order by d.Dnum, e.Fname, e.Lname

 --8.Try to get the max 2 salaries using subquery

select Salary from Employee
where Salary in (Select top 2 Salary from Employee order by Salary desc)

--9.Get the full name of employees that is similar to any dependent name
select Fname + ' ' + Lname as [Full Name]
from Employee 
join Dependent on Fname + ' ' + Lname = Dependent_name

--10.Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 
Update Employee
set Salary *= 1.30
where Dno in (
	select d.Dnum from Departments d 
	join Project p on p.Dnum = d.Dnum and Pname = 'Al Rabwah'
)

/*
11.Display the employee number and name 
if at least one of them have dependents (use exists keyword) self-study. 
*/
select SSN, Fname from Employee
where Exists(select ESSN from Dependent where ESSN = SSN)

---- DML ----
/* 1. In the department table insert new department called "DEPT IT" , 
with id 100, employee with SSN = 112233 as a manager for this department. 
The start date for this manager is '1-11-2006' */

insert into Departments
values ('DEPT IT', 100, 112233, 1-11-2006)

/*2. Do what is required if you know that: Mrs.Noha Mohamed(SSN=968574)
moved to be the manager of the new department (id = 100), 
and they give you(your SSN =102672) her position (Dept. 20 manager) */

--a.First try to update her record in the department table
update Departments
Set MGRSSN = 968574
where MGRSSN = 112233

--b.Update your record to be department 20 manager.
update Employee
set Dno = 20
where SSN = 102672

/* c.Update the data of employee number = 102660 to be in your teamwork 
     (he will be supervised by you) (your SSN =102672) */
update Employee
set Dno = (
	select Dnum from Departments where MGRSSN = 102672
),
Superssn = 102672
where SSN = 102660

/*
3.Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) 
so try to delete his data from your database in case you know that you will be temporarily in his position.
Hint:(Check if Mr. Kamel has dependents, works as a department manager, 
supervises any employees or works in any projects and handle these cases).
*/

update Departments
set MGRSSN = 102672
where MGRSSN = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

update Works_for 
set ESSn = 102672
where ESSn = 223344

delete from Employee
where SSN = 223344