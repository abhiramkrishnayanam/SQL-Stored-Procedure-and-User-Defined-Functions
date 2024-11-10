/*Consider the Worker table with following fields:
 Worker_Id INT FirstName CHAR(25), LastName CHAR(25), Salary INT(15), JoiningDate DATETIME, Department CHAR(25)) 
 1. Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the 
 table and then invokes the procedure call. 
 2. Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY.
 It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter.
 Then make the procedure call. 
 3. Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. It should update the 
 department of the worker with the given ID. Then make a procedure call. 
 4. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. 
 It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. 
 Make procedure call. 
 5. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary.
 It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter and call the procedure.*/
 use practice;
 CREATE TABLE Workers_info (
    Worker_Id INT,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT,
    JoiningDate DATE,
    Department CHAR(25)
);
drop table workers_info;
INSERT INTO Workers_info (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department) VALUES
(1, 'John', 'Doe', 50000, '2022-01-10', 'HR'),
(2, 'Jane', 'Smith', 60000, '2021-03-15', 'Finance'),
(3, 'Robert', 'Brown', 55000, '2020-07-20', 'IT'),
(4, 'Emily', 'Davis', 70000, '2019-05-25', 'Sales'),
(5, 'Michael', 'Wilson', 62000, '2023-02-11', 'Marketing'),
(6, 'Linda', 'Garcia', 58000, '2020-10-01', 'HR'),
(7, 'James', 'Martinez', 75000, '2018-12-30', 'Finance'),
(8, 'Barbara', 'Hernandez', 52000, '2021-06-21', 'Sales'),
(9, 'David', 'Lopez', 65000, '2019-09-19', 'IT'),
(10, 'Susan', 'Gonzalez', 67000, '2022-11-05', 'Marketing');

select * from workers_info;

/*1. Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the 
 table and then invokes the procedure call.*/
 delimiter $$
 create procedure Procedure_IN( IN WorkerId int,IN F_Name varchar(10),IN L_Name varchar(10)
 ,IN salary int, IN joiningDate Date,IN department varchar(10))
 begin 
INSERT INTO Workers_info (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department) VALUES
(WorkerId ,F_Name, L_Name,salary,joiningDate ,department );
end $$
delimiter ;
CALL Procedure_IN(11, 'Tom', 'Smith', 80000, '2024-09-22', 'HR');

 /*2. Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY.
 It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter.
 Then make the procedure call. */
DELIMITER $$

CREATE PROCEDURE GetSalaryByWorkerId(
    INOUT p_Worker_Id INT,
    OUT p_Salary INT)
BEGIN
    SELECT worker_ID,Salary INTO P_worker_Id,p_Salary
    FROM Workers_info
    WHERE Worker_Id = p_Worker_Id;
END $$

DELIMITER ;
drop procedure GetsalarybyworkerID;
set @workerid=7;
set @salary =0;
CALL GetSalaryByWorkerId(@workerid,@salary);
SELECT @workerid AS ID, @salary AS Salary;
 

 /*3. Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. It should update the 
 department of the worker with the given ID. Then make a procedure call. */
 delimiter $$
 CREATE PROCEDURE UPDATE_DEPT(IN WORKERID INT, IN DEPT VARCHAR(10))
 BEGIN 
 UPDATE workers_info SET DEPARTMENT = DEPT WHERE WORKER_ID = WORKERID;
 END $$
 DELIMITER ;
 
 SET @NEWDEPT = 'Finance';
 SET SQL_SAFE_UPDATES =0;
 CALL UPDATE_DEPT(1,@NEWDEPT);
 SELECT * FROM workers_info;
 
 /*4. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. 
 It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. Make procedure call. */
 DELIMITER $$
 CREATE PROCEDURE COUNTOFWORKERS(IN DEPT VARCHAR(10),OUT P_WORKERCOUNT INT)
 BEGIN 
 SELECT COUNT(WORKER_ID) INTO P_WORKERCOUNT 
 FROM WORKERS_INFO 
 WHERE DEPARTMENT = DEPT;
 END $$
 DELIMITER ;

 SET @COUNT = 0;
 CALL COUNTOFWORKERS('HR',@COUNT);
 SELECT @count AS WorkerCount;
 
/* 5. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary.
 It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter and call the procedure.*/
 DELIMITER $$
 CREATE PROCEDURE AVG_SALARY(IN DEPT VARCHAR(10), OUT AVERAGE INT)
 BEGIN 
 SELECT AVG(SALARY) INTO AVERAGE FROM workers_info GROUP BY DEPARTMENT HAVING DEPARTMENT = DEPT;
 END $$
 DELIMITER ;
 SET @AVERAGE = 0;
 CALL AVG_SALARY('FINANCE', @AVERAGE);
 SELECT @AVERAGE AS AVERAGE_SALARY;