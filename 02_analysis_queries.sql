-- HR Analytics Dashboard - Analytical Queries
-- Author: Abdullah Alahidy

USE hr_db;

-- 1. Employee Count by Department & Status
SELECT 
    d.dept_name,
    COUNT(CASE WHEN e.status = 'Active' THEN 1 END) AS active_count,
    COUNT(CASE WHEN e.status = 'Resigned' THEN 1 END) AS resigned_count,
    COUNT(CASE WHEN e.status = 'Terminated' THEN 1 END) AS terminated_count,
    COUNT(*) AS total_count
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY total_count DESC;

-- 2. Average Salary by Department & Education
SELECT 
    d.dept_name,
    e.education,
    COUNT(*) AS num_employees,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    ROUND(MIN(e.salary), 2) AS min_salary,
    ROUND(MAX(e.salary), 2) AS max_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name, e.education
ORDER BY d.dept_name, avg_salary DESC;

-- 3. Performance & Attendance by Department
SELECT 
    d.dept_name,
    ROUND(AVG(p.performance_score), 2) AS avg_performance,
    ROUND(AVG(a.days_absent), 2) AS avg_absent,
    ROUND(AVG(a.overtime_hours), 2) AS avg_overtime,
    ROUND(AVG(p.training_hours), 2) AS avg_training
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN attendance a ON e.emp_id = a.emp_id
JOIN performance p ON e.emp_id = p.emp_id
GROUP BY d.dept_name
ORDER BY avg_performance DESC;

-- 4. Turnover Rate Analysis
SELECT 
    d.dept_name,
    COUNT(*) AS total_count,
    COUNT(CASE WHEN e.status IN ('Resigned', 'Terminated') THEN 1 END) AS leavers_count,
    ROUND(COUNT(CASE WHEN e.status IN ('Resigned', 'Terminated') THEN 1 END) * 100.0 / COUNT(*), 2) AS turnover_rate
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY turnover_rate DESC;

-- 5. Top 10 Promoted Employees
SELECT 
    e.emp_name,
    d.dept_name,
    e.job_title,
    COUNT(CASE WHEN p.promotion = 'Yes' THEN 1 END) AS promotions_count,
    ROUND(AVG(p.performance_score), 2) AS avg_performance
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN performance p ON e.emp_id = p.emp_id
GROUP BY e.emp_name, d.dept_name, e.job_title
HAVING promotions_count > 0
ORDER BY promotions_count DESC, avg_performance DESC
LIMIT 10;

-- 6. Average Years of Service by Department
SELECT 
    d.dept_name,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE())), 2) AS avg_years_of_service,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    COUNT(*) AS num_employees
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_years_of_service DESC;
