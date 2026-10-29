/* ==========================================================================
   lab5e_starter.sql
   CIS 4720 Database Management and SQL
   In Class Lab 5e

   WHAT THIS FILE IS
   Lab 5d finished, plus a numbered heading for every step of Lab 5e waiting
   to be filled in. Starting from this file means it does not matter how
   Lab 5d went. Everyone begins from the same place.

   WHAT IT ALREADY BUILDS
     1. The schema cis_students_db
     2. students, five rows, with a surrogate key that fills itself in
     3. test_scores, ten rows, linked by a foreign key
     4. The student_scores view
     5. The calculate_gpa function, and every gpa filled in

   BEFORE YOU RUN IT
   Connect SQLTools to information_schema first, the same as Lab 5d. The
   first two statements in this file create cis_students_db and switch you
   into it. Step 2 of the lab walks through it.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.
   The function near the bottom is a single statement from CREATE FUNCTION
   down to END, so select the whole block and run the selection.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. The comments are graded.
   ========================================================================== */


CREATE DATABASE IF NOT EXISTS cis_students_db;
USE cis_students_db;


-- ======================================================================
-- FROM LAB 5D. The two tables and their data.
-- ======================================================================

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name  VARCHAR(40) NOT NULL,
    gpa        FLOAT(4,2)
);

INSERT INTO students VALUES (NULL,'Jenna','Wilson',NULL);
INSERT INTO students VALUES (NULL,'Robert','Reese',NULL);
INSERT INTO students VALUES (NULL,'Maria Elena','Jimenez',NULL);
INSERT INTO students VALUES (NULL,'Inder','Singh',NULL);
INSERT INTO students (first_name,last_name) VALUES ('Rita','Nunez');
INSERT INTO students (first_name,last_name) VALUES ('James','Toor');

-- James was student 6. Deleting him is why the counter now says 7.
DELETE FROM students WHERE first_name = 'James' AND last_name = 'Toor';

CREATE TABLE test_scores (
    test_score_id INT AUTO_INCREMENT PRIMARY KEY,
    test_name     VARCHAR(20) NOT NULL,
    student_id    INT NOT NULL,
    score         FLOAT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO test_scores VALUES (null,"quiz1",1,90),(null,"quiz1",2,85),(null,"quiz1",3,95),
 (null,"quiz2",1,80),(null,"quiz2",2,72),(null,"quiz2",3,88),(null,"quiz2",4,91),
 (null,"quiz3",2,95),(null,"quiz3",3,94),(null,"quiz3",4,74);


-- ======================================================================
-- FROM LAB 5D. The view.
-- ======================================================================

CREATE VIEW student_scores AS
SELECT s.student_id,
       CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       t.test_name,
       t.score
FROM students s
LEFT OUTER JOIN test_scores t ON s.student_id = t.student_id;


-- ======================================================================
-- FROM LAB 5D. The function. Select this whole block and run the
-- selection, because it is one statement from CREATE down to END.
-- ======================================================================

CREATE FUNCTION calculate_gpa(p_student_id INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_gpa DECIMAL(4,2);

    SELECT ROUND(AVG(score), 2)
    INTO v_gpa
    FROM test_scores
    WHERE student_id = p_student_id
      AND score IS NOT NULL;

    RETURN IFNULL(v_gpa, 0.00);
END;

UPDATE students SET gpa = calculate_gpa(student_id);


-- ======================================================================
-- CHECKS. These only read, so they are safe to run again any time.
-- Expect 85.00, 84.00, 92.33, 82.50 and 0.00.
-- ======================================================================

SELECT * FROM students;
SELECT * FROM student_scores;


-- ######################################################################
-- YOUR LAB 5E WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
--
-- You write the SQL for Steps 5, 6, 7 and 10 yourself. Steps 4, 8 and 9
-- are printed in the handout for you to copy.
-- ######################################################################


-- =================================================================
-- STEP 4. Look at the counters the server is keeping
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 5. Create the attendance table, starting its key at 500
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 6. Add three attendance rows and watch the ids
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 7. DELETE and TRUNCATE on a scrap table
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 8. A BEFORE INSERT trigger that fills in what you left out
--
-- Copy this from the handout. It is one statement from CREATE TRIGGER
-- down to END, so select the whole block and run the selection.
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 9. An AFTER DELETE trigger, the gap Lab 5d left open
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 10. Prove both triggers work
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 11 and 12. Push to GitHub and submit the URL
-- Nothing to write here. Follow the handout.
-- =================================================================
