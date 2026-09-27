-- HR Analytics Dashboard - Database Schema
-- Author: Abdullah Alahidy
-- Date: 2026

USE hr_db;

-- جدول الأقسام
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    dept_manager VARCHAR(100),
    location VARCHAR(50)
) ENGINE=InnoDB;

-- جدول الموظفين
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT,
    gender VARCHAR(10),
    birth_date DATE,
    hire_date DATE,
    job_title VARCHAR(100),
    salary DECIMAL(10,2),
    education VARCHAR(50),
    marital_status VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;

-- جدول الحضور والغياب
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    month_date DATE,
    days_present INT,
    days_absent INT,
    overtime_hours INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
) ENGINE=InnoDB;

-- جدول الأداء والتقييمات
CREATE TABLE performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    review_date DATE,
    performance_score INT,
    training_hours INT,
    promotion VARCHAR(10),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
) ENGINE=InnoDB;
