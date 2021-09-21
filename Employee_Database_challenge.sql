--DELIVERABLE 1

-- Getting ee info for retirement eligible people
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
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

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT count(ut.title), ut.title
INTO retiring_titles
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
INTO mentorship_eligibility
FROM employees as E
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	      AND (de.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

--ADDITIONAL QUERIES
-- Current ees with gender added
SELECT DISTINCT ON (e.emp_no)e.emp_no, 
e.first_name,
e.last_name,
e.birth_date,
e.gender,
de.from_date,
de.to_date,
t.title
--INTO New_Current_Emp
FROM employees as E
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE  (de.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Summary of current employee by title and gender
SELECT count(emp_no), title
FROM new_current_emp
GROUP BY title 
ORDER BY title,  count(emp_no) DESC

-- Retiring Emps with gender added all data
SELECT e.emp_no, e.first_name, e.last_name, e.gender, t.title, t.from_date, t.to_date
INTO retirement_titles_genders
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

-- Retiring EEs with gender and title unique values
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title, gender
INTO unique_titles_genders
FROM retirement_titles_genders
ORDER BY emp_no, to_date DESC;

--Summary of retiring EES with gender and title
SELECT count(emp_no), title, gender
FROM unique_titles_genders
GROUP BY title, gender
ORDER BY title, gender, count(emp_no) DESC

--Summary of current ees count by gender
SELECT count(emp_no), gender
FROM new_current_emp
GROUP by gender

-- Summary of retiring ees counts by gender
SELECT count(emp_no), gender
FROM unique_titles_genders
GROUP BY gender

-- Summary of retiring ees counts by title
SELECT count(emp_no), title
FROM unique_titles_genders
GROUP BY title
ORDER BY count(emp_no) DESC
