USE HR;
SELECT * FROM employees;

-- 1. Write a query to display the name (first name, last name) for those employees who gets more salary than the employee whose ID is 103. --
select first_name,last_name,salary from employees 
where salary > (select max(salary) from employees
where employee_id=103);

-- 2. Write a query to display the name (first_name, last_name), salary,department_id, job_id for those employees who works in the same designation as the employee works whose id is 169. --
select first_name,last_name,salary,department_id,job_id from employees
where job_id=(select job_id from employees where employee_id =169);

-- 3. Write a query to display the name (first_name, last_name), salary,department_id, for those employees who earn such ampount of salary which is the smallest salary of any of the departments. --
select first_name,last_name,salary,department_id from employees
where salary in (select min(salary) from employees
group by department_id);

-- 4. Write a query to display the employee id, employee name (first name and last name) for all employees who earn more than the average salary. --
select employee_id,first_name,last_name from employees
where salary > (select avg(salary) from employees);

-- 5. Write a query to display the employee name(first name and last name), employee id and salary of all employees who report to payam. --
select employee_id,first_name,last_name,salary from employees
where manager_id = (select employee_id from employees
where first_name='payam');

-- 6. Write a query to display the department number, name (first name and last name), job and departmebt name for all employees in the Finance department. --
select * from departments;
select employees.first_name,employees.last_name,employees.job_id,departments.department_id,departments.department_name
from employees join departments on employees.department_id=departments.department_id
and departments.department_name='Finance';

-- 7. Write a query to display all the information of an employee whose salary and reporting person id 3000 and 121 respectively. --
select * from employees where (salary,manager_id) = (select 3000,121);

-- 8. Display all the information of an employee whose id is any of the number 134, 159 and 183. --
select * from employees where employee_id in (134, 159, 183);

-- 9. Write a query to display all the information of the employees whose salary is within the range 1000 and 3000. --
select * from employees where salary between 1000 and 3000;

-- 10. Write a query to display all the information of the employees whose salary is within the range of smallest salary and 2500. --
select * from employees where salary between ( select min(salary) from employees) and 2500;

-- 11. Write a query to display all the informations of the employees who does no work in those departments where some employees works whose manager id within the renge 100 and 200. --
select * from employees
 where department_id not in (select department_id from employees where manager_id between 100 and 200);
 
 -- 12. Write a query to display all the information for those employees whose id any id who earn the second highest salary. --
 select * from employees 
 where employee_id  in
 (select employee_id from employees where salary =(select max(salary) from employees
 where salary <(select max(salary) from employees)));
 
 -- 13. Write a query to display the employee name(first name and last name) and hiredate for all employees in the same department as Clara. Exclude Clara. --
 select first_name,last_name,hire_date from employees 
 where department_id =
 (select department_id from employees where first_name='Clara') and first_name != 'Clara';
 
 -- 14. Write a query to display the employee number and name(first_name and last_name) for al employees who works in a departments with any employee whose name contains a T. --
 select employee_id, first_name, last_name from employees
 where department_id in (select department_id from employees 
 where first_name like '%T%');
 
 -- 15. Write a query to display the employee number, name(first name and last name), and salary for all employees who earn more than average salary and who work in a departments with any employee with a j their name. --
 select employee_id, first_name, last_name ,salary from employees
 where salary >(select avg(salary) from employees) and  department_id in (select department_id from employees  
 where first_name like '%J%');
 
 -- 16. Display the employees name (first name and last name), employee id , and job title fro all employees whose department location is Toronto. --
 select first_name, last_name, employee_id , job_id  from employees
 where department_id =(select department_id from departments
 where location_id= (select location_id from locations 
 where city= 'Toronto'));
 
-- 17. Write a query to display the employee number, name(first name and last name) and job title for all employees whose salary is smaller then salary of those employees whose job title is MK_MAN. --
select employee_id, first_name, last_name, job_id  from employees
where salary < any (select salary from employees
where job_id like 'MK_MAN');

-- 18. Write a query to display the employee number, name(first name and last name) and job title for all employee whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude job title MK_MAN. --
select employee_id ,first_name, last_name, job_id from employees
where salary < any (select salary from employees
where job_id like 'MK_MAN' and job_id <> 'MK_MAN');

-- 19. Write q query to display the employee number, name(first name and last name) and job title for all employee whose salary is more than any salary of those employees whose job totle is PU_MAN. Exclude job title like PU_MAN. --
select employee_id, first_name, last_name, job_id from employees
where salary > all (select salary from employees
where job_id like 'PU_MAN' and job_id <> 'PU_MAN');

-- 20. Write a query to dislay the employee number, name(first name and last name) and job title for all employees whose salary is more than any salary average salary of any department. --
select employee_id ,first_name, last_name, job_id from employees
where salary > all (select avg(salary) from employees 
group by department_id);
 
 -- 21. Write a query to dsplay the employees name(first name and last name) and department for all employees for ant existence of those employees whose salary is more than 3700. --
 select first_name, last_name, department_id from employees
 where exists (select * from employees
 where salary >3700);
 
 -- 22. Write a query to dispaly the employees id, name(first name and last name) and the job id column with a modifed title SALESMAN those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG. --
 select employee_id, first_name, last_name,
 case job_id when 'ST_MAN' then 'SALESMAN'
 when 'IT_PROG' then 'DEVELOPER'
 else job_id 
 end designation, salary from employees;

-- 23. Write a query to display the employee id name (first name and last name), salaryDrawn, AvgComapre (salary- the average salary of all employees) and the salaryStatselect employee_id , first_name last_name, salaryus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees. --
select employee_id, first_name, last_name, salary, 
case when salary >= (select avg(salary) from employees) 
then 'HIFG' else 'LOW' 
end as salarystatus from employees; 

-- 24.  Write a sql query to find all those departments where at least one employee is employed. Return department name. --
select department_name from departments
where department_id in (select distinct(department_id) from employees);

-- 25. write a SQL query to find employees who work in departments located in the United Kingdom. Return first name. --
select employees.first_name from employees
where department_id in (select department_id from departments
where location_id in (select location_id from locations
where country_id in (select country_id from countries
where countries.country_name='United Kingdom')));

-- 26. write a SQL query to find out which employees are earning more than the average salary and who work in any of the IT departments. Return last name. --
select employees.last_name from employees
where department_id = (select department_id from departments
where departments.department_name='IT' and 
salary > (select avg(salary) from employees) );

-- 27.  write a SQL query to find all those employees who earn more than an employee whose last name is 'Ozer'. Sort the result in ascending order by last name. Return first name, last name and salary. --
select first_name,last_name,salary from employees
where salary > (select salary from employees where last_name = 'Ozer')
order by last_name ;

-- 28. write a SQL query find the employees who report to a manager based in the United States. Return first name, last name. --
select employees.first_name, employees.last_name from employees
where manager_id in (select employee_id from employees
where department_id in (select department_id from departments
where location_id in (select location_id from locations
where locations.country_id='US')));

-- 29. write a SQL query to find those employees whose salaries exceed 50% of their department's total salary bill. Return first name, last name. --
select first_name, last_name salary from employees e1 
where salary > (select sum(salary) * 0.5 from employees e2
where e1.department_id = e2.department_id);

-- 30. 
select locations.city from locations
where location_id in (select location_id from departments
where department_id in (select department_id from employees
where employees.employee_id ='134'))
