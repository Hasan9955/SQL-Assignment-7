-- Active: 1729528085669@@127.0.0.1@5432@university_db

-- Create 'students' table.
CREATE Table students
(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(50)
);

-- Create 'courses' table.
CREATE Table courses
(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL
);


-- Create 'enrollment' table.
CREATE Table enrollment
(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES "students"(student_id),
    course_id INTEGER REFERENCES "courses"(course_id)
);


-- Insert data into students table.
INSERT INTO students(student_name, age, email, frontend_mark, backend_mark) VALUES
('Sameer', 21, 'sammeer@example.com', 48, 60),
('Zoya', 23, 'zoya@example.com', 52, 58),
('Nabil', 22, 'nabil@example.com', 37, 46),
('Rafi', 24, 'rafi@example.com', 41, 40),
('Sophia', 22, 'sophia@example.com', 50, 52),
('Hasan', 23, 'hasan@gmail.com', 43, 39)

SELECT * FROM students;

-- Insert data into courses table.
INSERT INTO courses(course_name, credits) VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

SELECT * FROM courses;


-- Insert data into enrollment table.
INSERT INTO enrollment(student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);

SELECT * FROM enrollment;



------------------------ SQL Queries --------------------------

-- Query 1: 
-- Insert data into students table.
INSERT INTO students(student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Abdullah', 25, 'abdullah@gmail.com', 55, 70, NULL);


-- Query 2: 
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT student_name FROM courses as c 
JOIN "enrollment" as e ON c.course_id = e.course_id
JOIN "students" as  s on e.student_id = s.student_id
WHERE course_name = 'Next.js';


-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
set status = 'Awarded'
WHERE student_id = (
    SELECT student_id FROM students ORDER BY (frontend_mark + backend_mark) DESC LIMIT 1
);


-- Query 4:
-- Delete all courses that have no students enrolled.
DELETE FROM courses WHERE course_id  In(
    SELECT course_id FROM courses LEFT JOIN enrollment USING(course_id) WHERE enrollment.course_id IS NULL
);



-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students LIMIT 2 OFFSET 2


-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(*) as students_enrolled FROM courses JOIN enrollment USING(course_id) GROUP BY course_name;


-- Query 7:
-- Calculate and display the average age of all students.
SELECT round(avg(age), 2) as average_age FROM students;



-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name FROM students WHERE email LIKE '%example.com%'



