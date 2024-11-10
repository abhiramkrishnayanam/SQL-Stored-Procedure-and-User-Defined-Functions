/*Consider the Country table and Persons table that you created earlier and perform the following:
1. Add a new column called DOB in Persons table with data type as Date. 
2. Write a user-defined function to calculate age using DOB. 
3. Write a select query to fetch the Age of all persons using the function that has been created. 
4. Find the length of each country name in the Country table. 
5. Extract the first three characters of each country's name in the Country table. 
6. Convert all country names to uppercase and lowercase in the Country table.*/

#1. Add a new column called DOB in Persons table with data type as Date. 
use practice;
select * from persons;
alter table persons 
add DOB date;
-- Update DOB values for specific persons
-- Updating DOB values for 16 entries in the Persons table
UPDATE Persons SET DOB = '1980-01-15' WHERE ID = 1;
UPDATE Persons SET DOB = '1991-02-20' WHERE ID = 2;
UPDATE Persons SET DOB = '1985-03-25' WHERE ID = 3;
UPDATE Persons SET DOB = '1978-04-10' WHERE ID  = 4;
UPDATE Persons SET DOB = '1992-05-05' WHERE ID = 5;
UPDATE Persons SET DOB = '1989-06-12' WHERE ID = 6;
UPDATE Persons SET DOB = '1984-07-18' WHERE ID = 7;
UPDATE Persons SET DOB = '1990-08-22' WHERE ID = 8;
UPDATE Persons SET DOB = '1986-09-11' WHERE ID = 9;
UPDATE Persons SET DOB = '1983-10-27' WHERE ID = 10;
UPDATE Persons SET DOB = '1995-11-30' WHERE ID = 11;
UPDATE Persons SET DOB = '1993-12-17' WHERE ID = 12;
UPDATE Persons SET DOB = '1987-01-29' WHERE ID = 13;
UPDATE Persons SET DOB = '1988-02-13' WHERE ID = 14;
UPDATE Persons SET DOB = '1994-03-06' WHERE ID = 15;
UPDATE Persons SET DOB = '1996-04-21' WHERE ID = 16;

-- Continue updating more persons as needed

desc persons;

#2. Write a user-defined function to calculate age using DOB.
delimiter $$
create function cal_age(dob date)
RETURNS int
DETERMINISTIC 
 begin 
	declare age int;
	set age = floor(datediff(curdate(),dob )/365.25);
	return age;
 end$$
 delimiter ;


 
 
#3. Write a select query to fetch the Age of all persons using the function that has been created. 
select Fname,cal_age(dob) as Age from persons;

#4. Find the length of each country name in the Country table. 
select length(country_name) as length_of_countryname from country_info;

#5. Extract the first three characters of each country's name in the Country table. 
select left(country_name,3) as first_three_letters from country_info;
 
#6. Convert all country names to uppercase and lowercase in the Country table.
select upper(country_name)  from country_info;
select lower(country_name)  from country_info;