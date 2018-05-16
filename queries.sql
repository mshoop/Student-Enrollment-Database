-- 1.a.
SELECT Student.sName
FROM Student, Enroll
WHERE Enroll.courseNo='CptS421' AND Enroll.sID=Student.sID
ORDER BY sName

-- 1.b.
SELECT Prereq.preCourseNo, Student.sname
FROM Student, Enroll, Prereq
WHERE Student.sID=Enroll.sID AND Prereq.preCourseNo=Enroll.courseNo AND Prereq.courseNo='CptS423'

-- 2. 
SELECT Course.courseno, COUNT(sid) as enrollCount
FROM Course LEFT OUTER JOIN Enroll ON Course.courseno = Enroll.courseno
WHERE classroom = 'Sloan7'
GROUP BY Course.courseno
HAVING COUNT(sid) < 3
ORDER BY Course.courseno

-- 3. 
SELECT courseno, AVG(Enroll.grade) AS avggrade
FROM Enroll
WHERE courseNo IN
    (SELECT enroll.courseno
    FROM enroll
    WHERE enroll.sid IN
        (SELECT sid
        FROM Student
        WHERE Student.major='CHE'))
GROUP BY Enroll.courseNo
ORDER BY courseno;

-- 4. 
SELECT sName, major, E1.grade
FROM Student S, Enroll E1
WHERE S.sID= E1.sID AND E1.courseNo='CptS223'
AND E1.grade <
    (SELECT MIN(E2.grade)
    FROM Enroll E2
    WHERE E2.courseNo<>'CptS223' AND E2.sID=E1.sID);

-- 5. 
SELECT sName
FROM student S1, enroll E1
WHERE E1.courseNo='CptS421' AND S1.sID = E1.sID AND
    NOT EXISTS (
        SELECT E2.sID
        FROM prereq, enroll E2
        WHERE prereq.courseNo='CptS421' AND E2.courseNo = prereq.preCourseNo AND E1.sID = E2.sID);

-- 6. 
SELECT distinct courseno
FROM Trackrequirements T1
WHERE major = 'CptS' AND
NOT EXISTS
    (SELECT *
    FROM Trackrequirements T2
    WHERE T2.major='CptS' AND T2.trackcode NOT IN
        (SELECT trackcode
        FROM Trackrequirements T3
        WHERE T3.major='CptS' AND T1.courseno = T3.courseno))

-- 7.
SELECT distinct Student.sname, Student.major, Student.trackcode
FROM Student, Enroll
WHERE Student.sid = Enroll.sid AND (major = 'CptS' OR major = 'EE') 
AND courseno 
NOT IN (SELECT courseno
        FROM Trackrequirements
        WHERE Student.major = Trackrequirements.major)
-- 8. 
SELECT major, MAX(avgGrade)
FROM (
    SELECT major,Student.sid, AVG(grade) as avgGrade 
    FROM Student, Enroll 
    WHERE Student.sid = Enroll.sid 
    GROUP BY (major,Student.sid) 
    ) as Temp
GROUP BY major;

-- 9. 
SELECT sName, E1.grade AS grade223 , E2.grade AS grade451
FROM student, enroll E1, enroll E2
WHERE E1.courseNo='CptS223' AND E2.courseNo='CptS451' AND E1.sID= E2.sID AND E2.grade > E1.grade AND student.sID = E1.sID;

-- 10.
SELECT sname,major
FROM student
WHERE sid not in ( SELECT sid
                   FROM enroll
                   WHERE grade > 3.0)
GROUP BY sname,major;
-- Alternative solution:
/*SELECT sname, major
FROM Student,
((SELECT sid FROM student)
EXCEPT
(SELECT sid from enroll WHERE grade > 3.0)) as TEMP
WHERE TEMP.sid=student.sid
GROUP BY sname,major;*/