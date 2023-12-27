
-- *  TASK 1 PART 1 SAKILA DB * 

-- Q1 Display all tables available in the database sakila
-- solution

show tables;

-- Q2 Display structure of table “actor”. (4 row) 
-- solution

describe actor;

--  Q3 Display the schema which was used to create table “actor” and view the complete schema using the viewer. (1 row) 
-- solution

<<<<<<< HEAD
 show create table actor;
=======
 show create table  actor;
>>>>>>> 3b5539b3764e97bfe4f823e26a5baa4cdf3bf231
 
 -- Q4 Display the first and last names of all actors from the table actor. (200 rows) 
 -- solution
 
 select first_name , last_name from actor;
 
 -- Q5 Which actors have the last name ‘Johansson’. (3 rows) 
 -- solution
 
 select * from actor 
 where last_name = "JOHANSSON" ;
 
 -- Q6 Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. (200 rows)
 -- solution
 
 select 
 upper(concat(first_name  ," ", last_name)) as "Actor Name"
 from actor ;
 
 
--  Q7 You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information? (1 row) 
-- solution

select actor_id  , first_name , last_name 
from actor 
where first_name = "JOE";
  
-- Q8 Which last names are not repeated? (66 rows) 
-- solution

select last_name from actor 
group by last_name
having  count(last_name)=1 ; 

--  Q9 List the last names of actors, as well as how many actors have that last 
-- solution

select last_name , count(last_name) as count from actor 
group by last_name  ; 


--  Q10 Use JOIN to display the first and last names, as well as the address,
--  of each staff member. Use the tables “staff” and “address”. (2 rows)

SELECT first_name  , last_name , address from staff 
inner join address 
on staff.address_id = address.address_id ; 





--  *TASK 1 PART 1 WORLD DB*



-- Q1 Display all columns and 10 rows from table “city”.(10 rows) 
-- solution 

select * from city
limit 10  ; 

--  Q2 Modify the above query to display from row # 16 to 20 with all columns. (5 rows) 
-- solution 

select * from city
limit 5  offset 15 ; 


-- Q3 How many rows are available in the table city. (1 row)-4079. 
-- solution 

select count(*) as Total_Rows  from city ;

-- Q4 Using city table find out which is the most populated city. 
-- solution 

 select * from city 
 order  by population desc 
 limit 1 ; 
 
 

 
 
 -- Q5 Using city table find out the least populated city. 
 -- solution 
 
select * from city 
 order by population asc
 limit 1 ; 


-- Q6 Display name of all cities where population is between 670000 to 700000. (13 rows) 
-- solution 

select name from city 
where population between 670000 and 700000 ; 

--  Q7 Find out 10 most populated cities and display them in a decreasing order i.e.
--  most populated city to appear first. 
-- solution 

select * from city 
order by population desc
limit 10 ; 

--  Q8 Order the data by city name and get first 10 cities from city table. 
-- solution 

select * from city 
order by name
limit 10  ; 

-- Q9 Display all the districts of USA where population is greater than 3000000, from city table. (6 rows) 
-- solution 

select District from city 
where CountryCode="USA" and  population > 3000000;


 -- 10  Q10 What is the value of name and population in the rows with ID =5, 23, 432 and 2021. Pl.
 -- write a single query to display the same. (4 rows). 
 -- solution 
 
 
select name , population from city 
where id in(5, 23, 432 , 2021) ; 



 
-- *TASK 1 PART 2 SAKILA DB *



-- Q1 Which actor has appeared in the most films?
-- solution

select actor.first_name  , actor.last_name , 
		count(film_actor.actor_id) as Movies_Appeared 
from actor 
inner join film_actor
			on actor.actor_id = film_actor.actor_id
group by film_actor.actor_id
order by Movies_Appeared desc
limit 1 ;

--  Q2 What is the average length of films by category? 
-- solution

select category.name ,
		avg(film.length) as Average 
from film
inner join film_category 
		on film.film_id = film_category.film_id 
inner join  category  
		on film_category.category_id = category.category_id
group by category.category_id ;

--  Q3 Which film categories are long? (5 rows) 
-- solution
 
select category.name , 
		sum(film.length) as Total_length
from category
join film_category 
	on film_category.category_id =  category.category_id
join film 
	on film.film_id = film_category.film_id
group by category.category_id 
limit 5  ; 

--  Q4 How many copies of the film “Hunchback Impossible” exist in the inventory system? (6) 
-- solution

select f.title  ,
		count(i.inventory_id) as Copy_Count 
from film as f
join inventory as i 
	on f.film_id = i.film_id
where f.title = "Hunchback Impossible";


 --  Q5 Using the tables “payment” and “customer” and the JOIN command, list the total paid by each customer.
 -- List the customers alphabetically by last name (599 rows)
 -- solution
 
select 	c.customer_id,
		c.first_name, 
		c.last_name, 
        sum(p.amount) 
from customer as c 
join payment as p on c.customer_id = p.customer_id
group by customer_id
order by c.last_name;
 


-- *TASK 1 PART 2 WORLD DB*

-- Q1 Write a query in SQL to display the code, name, continent and GNP for all the countries
--  whose country name last second word is 'd’, using “country” table. (22 rows) 
-- solution

select Code  , name , continent  , GNP  from  country
where name like "%d_" ; 


 -- Q2 Write a query in SQL to display the code, name, continent and GNP of the 
 -- 2nd and 3rd highest GNP from “country” table. (Japan & Germany) 
 -- solution
 
 select Code  , name , continent  , GNP  from  country
 order by GNP desc 
 limit 2 offset 1 ; 
 


-- *TASK 1 SUBQUERIES*

-- Q1 Write a query to display Employee id and First Name of an employee whose dept_id = 100. 
-- solution 

SELECT 
    employee_id, first_name
FROM
    employees
WHERE
    department_id IN (SELECT 100) ; 
            
            
-- 2 Q2. Write a query to display the dept_id, maximum salary, of all the departments 
-- whose maximum salary is greater than the average salary. (USE: SUB-QUERY)
-- solution 

select departments.department_id  , max(employees.salary)  as Max_salary 
from employees
join departments on employees.DEPARTMENT_ID = departments.DEPARTMENT_ID 
group by departments.DEPARTMENT_ID
having Max_salary  > (select avg(employees.salary) from employees 
						group by departments.DEPARTMENT_ID) ;

-- Q3 Write a query to display department name and, department id of the employees whose salary is less than 35000. 
-- solution 

select d.department_name  , d.department_id , e.first_name  , e.salary 
from departments as d 
inner join  employees as e 
on d.department_id = e.department_id 
where e.salary < 35000 ;






 
 
 
