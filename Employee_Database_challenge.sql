--DELIVERABLE 1

-- Getting ee info for retirement eligible people
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
--INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

-- Use Dictinct with Orderby to remove duplicate rows
-- Drilling down to ee info with current title (eliminating duplicate titles held over the years)
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

--INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT count(ut.title), ut.title
--INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY count(ut.title) DESC

--DELIVERABLE 2
-- Current ees that are mentorship eligible
SELECT DISTINCT ON (e.emp_no)e.emp_no, 
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
--INTO mentorship_eligibility
FROM employees as E
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	      AND (de.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT count(emp_no),
title
FROM mentorship_eligibility
GROUP BY title

--ADDITIONAL QUERIES
SELECT ut.emp_no, ut.first_name, ut.last_name, ut.title, s.salary,
CASE WHEN s.salary>=40000 and s.salary<60000 then '40000-59999'
WHEN s.salary>=60000 and s.salary<80000 then '60000-79999'
WHEN s.salary>=80000 and s.salary<100000 then '80000-99999'
WHEN s.salary>=100000 and s.salary<120000 then  '100000-119999' 
ELSE '120000+' END AS Salary_bin
INTO Retiring_Salary_Bins
FROM unique_titles as ut
INNER JOIN salaries as s
ON ut.emp_no = s.emp_no
GROUP BY ut.emp_no, ut.first_name, ut.last_name, ut.title, s.salary

SELECT count(emp_no), Salary_bin
FROM Retiring_Salary_Bins

SELECT ut.emp_no, ut.first_name, ut.last_name, ut.title, e.gender
INTO retirement_titles_genders
FROM unique_titles as ut
INNER JOIN employees as e
ON ut.emp_no = e.emp_no
ORDER BY emp_no

SELECT count(emp_no), gender
FROM retirement_titles_genders
GROUP BY gender

