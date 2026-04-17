CREATE DATABASE OnlineLearning;

USE OnlineLearning;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    description TEXT,
    sessions INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enroll_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Score (
    student_id INT,
    course_id INT,
    midterm_score DECIMAL(4,2),
    final_score DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    CHECK (midterm_score BETWEEN 0 AND 10),
    CHECK (final_score BETWEEN 0 AND 10)
);