# Student-Enrollment-Database

## CREATE TABLE

### Consider the following tables:

* “courseno” includes a string, like ‘CptS451’.
* The attributes Student.major, Track.major, and TrackRequirements.major contain just the acronym for the major, e.g., ‘CptS’, 'EE', etc.
```sql

CREATE TABLE Course (
courseno VARCHAR(7),
credits INTEGER NOT NULL,
enroll_limit INTEGER,
classroom VARCHAR(10),
PRIMARY KEY(courseNo),
);

CREATE TABLE Tracks (
major VARCHAR(7),
trackcode VARCHAR(10),
title VARCHAR(30),
PRIMARY KEY(major, trackcode)
);

CREATE TABLE Student (
sID CHAR(8),
sName VARCHAR(30),
major VARCHAR(10),
trackcode VARCHAR(10),
PRIMARY KEY(sID),
FOREIGN KEY (major,trackcode) REFERENCES Tracks(major,trackcode)
);

CREATE TABLE Enroll (
courseNo VARCHAR(7),
sID CHAR(8),
grade FLOAT NOT NULL,
PRIMARY KEY (courseNo, sID),
FOREIGN KEY (courseNo) REFERENCES Course(courseNo),
FOREIGN KEY (sID) REFERENCES Student(sID)
);

CREATE TABLE Prereq (
courseNo VARCHAR(7),
preCourseNo VARCHAR(7),
PRIMARY KEY (courseNo, preCourseNo),
FOREIGN KEY (courseNo) REFERENCES Course(courseNo),
FOREIGN KEY (preCourseNo) REFERENCES Course(courseNo)
);

CREATE TABLE TrackRequirements (
major VARCHAR(7),
trackcode VARCHAR(10),
courseNo VARCHAR(7),
PRIMARY KEY (major,trackcode,courseNo),
FOREIGN KEY (major,trackcode) REFERENCES Tracks(major,trackcode),
FOREIGN KEY (courseNo) REFERENCES Course(courseNo)
);
```

## Instructions
1. Install PostgreSQL Server

2. Create a database named student-enrollment-db. (If you are working on PgAdmin, initially open a query window for the “postgres” database; create the database student-enrollment-db, and then open a new query window for the new database)

3. Create the tables course, tracks, student, enroll, prereq, trackrequirements by running the above CREATE TABLE statements. Run them in the given order, otherwise you will get errors due to foreign key definitions.

4. Create the tables course, tracks, student, enroll, prereq, trackrequirements and populate your tables by running the attached .sql script files. You are given 6 script files: course.sql; tracks.sql; student.sql; enroll.sql; prereq.sql; trackReq.sql. Each file contains the CREATE TABLE statement to create the corresponding tables the INSERT statements to insert the sample date. See instructions on how to execute script files on command line. Alternatively, copy and paste the INSERT statements to the PgAdmin query tool. Follow the order course, tracks, student, enroll, prereq, trackrequirements when running insert statements. Otherwise there would be violations for the foreign key constraints.

5. Check if the data is inserted correctly by running a “select * from” on each table. The number of tuples in each table should be same as number of tuples in each INSERT statement in the corresponding file.

## SQL Queries

1. a. Find the sorted names of all the students enrolled in ‘CptS421’; b. Find the students enrolled in (immediate) prerequisites of 'CptS423'; return course numbers and student names.


2. Search for the courses offered in Sloan7 which have enrollment less than 3. Return the courseno and the actual enrollment for each course. Sort the results based on courseno. (Hint: The result should include the courses with 0 enrollment) 


3. Find all courses that chemical engineering (‘CHE’) students take. List the course number and the average grade in those courses.


4. Find students whose ‘CptS223’ grade was lower than all her/his other courses; return their names, majors and ‘CptS223’ grades


5. Find the names of the students who has enrolled in ‘CptS421’ without completing any of the (immediate) prerequisites of ‘CptS421’.

6. Find the CptS courses which are required by all CptS tracks; return distinct courseno’s . (Hint In the ourter query consider each CptS course, and include a subquery which checks whether there are any CptS tracks that is not one of the tracks which include the course in the outer query. If such a track exists, then the course shouldn’t be included in the results.)


7. Find the ‘CptS’ and ‘EE’ students who took courses which are not required by their track. Give the names, majors and trackcodes of those students. Remove duplicates in the result.


8. For each major, return the highest student GPA among the students in that major. (the GPA of a student is equal to the average of his/her grades in the courses he/she enrolled.) Return the major and maximum average GPA. (The major for the first tuple is NULL)


9. Consider the following relational algebra expression. (i) explain what the expression is doing, (ii) write an equivalent SQL query.


10. Consider the following relational algebra expression. (i) explain what the expression is doing, (ii) write an equivalent SQL query. Find all the students who never got a grade above 3.0; list their names and majors (every student should be listed once) (The empty values correspond to NULL)
