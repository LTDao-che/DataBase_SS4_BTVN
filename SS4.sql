CREATE DATABASE BTVN;
USE BTVN;

CREATE TABLE Student (
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(200) NOT NULL,
dob DATE,
student_email VARCHAR(200) NOT NULL UNIQUE
);
CREATE TABLE Teacher (
teacher_id INT PRIMARY KEY AUTO_INCREMENT,
teacher_name VARCHAR(200) NOT NULL,
teacher_email VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    description TEXT,
    num_sessions INT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);


CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    UNIQUE(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Score (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    midterm_score DECIMAL(4,2) CHECK (midterm_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    -- Mỗi sinh viên chỉ có một kết quả cho mỗi khóa học
    UNIQUE(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);




INSERT INTO Instructor (full_name, email) VALUES 
('Nguyen Van A', 'anv@university.edu.vn'),
('Tran Thi B', 'btt@university.edu.vn'),
('Le Van C', 'clv@university.edu.vn'),
('Pham Minh D', 'dpm@university.edu.vn'),
('Hoang Anh E', 'eha@university.edu.vn');


INSERT INTO Student (full_name, dob, email) VALUES 
('Nguyen Van Hung', '2004-05-15', 'hungnv@student.com'),
('Le Thi Mai', '2004-08-20', 'mailt@student.com'),
('Tran Trung Kien', '2003-12-01', 'kientt@student.com'),
('Pham Thu Ha', '2004-02-10', 'hapt@student.com'),
('Vu Hoang Nam', '2004-11-30', 'namvh@student.com');

INSERT INTO Course (course_name, description, num_sessions, instructor_id) VALUES 
('C Programming', 'Basic C language', 15, 1),
('Web Development', 'HTML, CSS, JS', 20, 2),
('Database System', 'SQL and Design', 12, 1),
('Data Structure', 'Algorithms and structures', 18, 3),
('Cloud Computing', 'AWS and Azure', 10, 4);


INSERT INTO Enrollment (student_id, course_id, enrollment_date) VALUES 
(1, 1, '2026-01-10'),
(1, 2, '2026-01-11'),
(2, 1, '2026-01-10'),
(3, 3, '2026-01-15'),
(4, 5, '2026-01-20');


INSERT INTO Score (student_id, course_id, midterm_score, final_score) VALUES 
(1, 1, 8.5, 9.0),
(1, 2, 7.0, 8.5),
(2, 1, 6.5, 7.5),
(3, 3, 9.0, 9.5),
(4, 5, 5.5, 6.0);




UPDATE Student SET email = 'hung_new@student.com' WHERE student_id = 1;


UPDATE Course SET description = 'Fullstack Web Development' WHERE course_id = 2;


UPDATE Score SET final_score = 10.0 WHERE student_id = 1 AND course_id = 1;



DELETE FROM Enrollment WHERE student_id = 4 AND course_id = 5;

DELETE FROM Score WHERE student_id = 4 AND course_id = 5;



SELECT * FROM Student;

SELECT * FROM Instructor;

SELECT c.course_name, i.full_name AS instructor_name 
FROM Course c 
JOIN Instructor i ON c.instructor_id = i.instructor_id;

SELECT s.full_name, c.course_name, e.enrollment_date 
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_id = c.course_id;

SELECT s.full_name, c.course_name, midterm_score, final_score 
FROM Score sc
JOIN Student s ON sc.student_id = s.student_id
JOIN Course c ON sc.course_id = c.course_id;