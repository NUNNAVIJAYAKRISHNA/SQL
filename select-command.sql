-- INSERTING SAMPLE DATA INTO TABLE
insert into
    students
values (2, 'Krishna', 21, 'CSE'),
    (3, 'Uday', 21, 'CSE'),
    (4, 'Kiran', 22, 'CSE'),
    (5, 'Azad', 21, 'CSE');
-- show all rows of the table
SELECT * FROM students;
-- select only names
select std_name from students;
-- adding marks to the table
ALTER TABLE students ADD marks INT;
-- updating each record
UPDATE students set marks = 84 where id = 5;

-- selecting only marks from the table
select marks from students;

-- adding city column to the table
ALTER TABLE students add city VARCHAR(20);
-- update each row with a value in city column
UPDATE students set city = 'VSKP' WHERE id = 5;

-- selecting name and city
SELECT std_name, city FROM students;
-- selecting id, name and department
SELECT id, std_name, department FROM students;

-- SELECTING MARKS IN THE RANGE OF 70 AND 90, INCLUSIVE

UPDATE students set marks = 90 where id = 5;

SELECT * from students where marks between 70 and 90;

-- select students from cse or ece

select * from students where department in ('CSE', 'ECE');

-- select students where the city names start with letter P
SELECT * FROM students WHERE city LIKE 'P%';

-- Explaination - % defines that after P, any character sequence is accepted.

-- select names that end with a
SELECT * FROM students WHERE std_name LIKE '%a';

-- select names that exactly middle is a

SELECT * FROM students WHERE std_name LIKE '_%a%_';

-- SELECT STUDENTS WHOSE MARKS ARE ABOVE 80 AND IS CSE DEPT

select * from students where marks > 80 and department = 'CSE';

-- SELECT STUDENTS WHOSE MARKS ARE ABOVE 90 OR IS CSE DEPT

select * from students where marks > 90 OR department = 'CSE';

-- SELECT STUDENTS not CSE DEPT

SELECT * FROM students WHERE department != 'CSE';

SELECT * FROM students WHERE department <> 'CSE';

-- <> stands for not equals to as well

-- AGGREGATE FUNCTIONS

-- counting number of student entries

SELECT COUNT(*) FROM students;

-- sum of all marks obtained by all students

SELECT SUM(marks) FROM students;

-- select average marks from students

SELECT AVG(marks) FROM students;

-- select maximum marks from students

SELECT MAX(marks) FROM students;

-- select minimum marks from students

SELECT MIN(marks) FROM students;

-- group students by department

SELECT department, COUNT(id) -- group by department with count of each students list
FROM students
GROUP BY
    department;

SELECT department, AVG(marks) -- group by department with average marks of each department
FROM students
GROUP BY
    department;

SELECT department, MAX(marks) -- group by department with max marks of each department
FROM students
GROUP BY
    department;

SELECT department, AVG(marks) AS average
FROM students
GROUP BY
    department
HAVING
    average > 75;

-- alias

SELECT std_name as stname, marks AS stmarks FROM students;

UPDATE students SET marks = 90 WHERE id = 1;

SELECT * FROM students;

-- deleting a record

DELETE FROM students WHERE id = 5;

SELECT * FROM students;

ALTER TABLE students ADD email VARCHAR(100);

ALTER TABLE students MODIFY std_name VARCHAR(100);

-- dropping column

ALTER TABLE students DROP email;

SELECT * FROM students;

-- create another table department

CREATE TABLE dept (
    dept_id INT,
    dept_name VARCHAR(5),
    dept_hod VARCHAR(50)
);

INSERT INTO
    dept
VALUES (1, 'CSE', 'Y RAMESH'),
    (2, 'CSD', 'B V RAMANAIAH'),
    (3, 'MECH', 'M V RAMANA'),
    (4, 'IT', 'YVSS SRIKANTH'),
    (5, 'CIV', 'BVR');

-- SELECT TABLE1-COLS FROM TABLE 1
-- INNER JOIN TABLE 2
-- ON TABLE1.COL == TABLE2.COL

SELECT *
FROM students
    INNER JOIN dept ON students.department = dept.dept_name;

-- giving alias to table and joining

SELECT s.std_name, s.department, d.dept_hod
FROM students s
    INNER JOIN dept d ON s.department = d.dept_name;

SELECT s.std_name, s.department, d.dept_hod
FROM students s
    LEFT JOIN dept d ON s.department = d.dept_name;

SELECT s.std_name, s.department, d.dept_hod, d.dept_name
FROM students s
    RIGHT JOIN dept d ON s.department = d.dept_name;

SELECT a.std_name as student1, b.std_name as student2
FROM students a JOIN students b 
WHERE a.id > b.id;

SELECT *
FROM students
WHERE marks > (SELECT AVG(marks) FROM students);

SELECT *
FROM students
WHERE
    marks = (
        SELECT MAX(marks)
        FROM students
    );

-- CREATING VIEW 

CREATE VIEW cse_students AS SELECT id, std_name, marks 
FROM students WHERE department = 'CSE';

SELECT * FROM cse_students;

SELECT UPPER(std_name) FROM students;

SELECT LOWER(std_name) FROM students;

SELECT CONCAT(std_name, ' - ',  department) FROM students;


ALTER TABLE students
MODIFY marks DECIMAL;

ALTER TABLE students DROP cgpa;
ALTER TABLE students
ADD cgpa DECIMAL(3, 2);

UPDATE students
SET cgpa = marks/10;

SELECT * FROM students;

-- mod, floor, ceil pending

SELECT CURRENT_DATE();

SELECT CURRENT_TIME();

SELECT CURRENT_TIMESTAMP();

SELECT YEAR(CURRENT_DATE());

SELECT MONTH(CURRENT_DATE());

SELECT DAYOFWEEK(CURRENT_DATE());

SELECT DAYNAME(CURRENT_DATE());

SELECT std_name, marks,
CASE 
    WHEN marks >= 90 THEN 'Excellent' 
    WHEN marks >= 80 THEN 'Very Good'
    WHEN marks >= 70 THEN 'Good'
    WHEN marks >= 50 THEN 'Average'
    ELSE 'Fail'
END AS grade 
FROM students;

SELECT *,
ROW_NUMBER() OVER (
    ORDER BY marks DESC
) as row_num,
RANK() OVER ( ORDER BY marks DESC ) as std_rank
FROM students;

SELECT *, DENSE_RANK() OVER (
        ORDER BY marks DESC
    ) as std_rank
FROM students; -- solves repeated scores problem

SELECT *, LAG(marks) OVER (ORDER BY marks) as lag_col FROM students;

SELECT *, LEAD(marks) OVER ( ORDER BY marks ) as lead_col FROM students;

