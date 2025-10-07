SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

-- Casting job_posted_date to date type

SELECT
job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS date
FROM job_postings_fact;



-- Timezone conversion from UTC to EST

SELECT
job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 5;

-- Extracting date parts: year, month, day


SELECT
job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
EXTRACT(MONTH FROM job_posted_date) AS date_month,
EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 5;


SELECT
COUNT(job_id) as job_posted_count,
EXTRACT(MONTH from job_posted_date) AS month
FROM
job_postings_fact
WHERE
job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_posted_count DESC;


-- Create Tables from Other Tables
-- Create three tables
-- Jan 2023 jobs, feb 2023 jobs, Mar 2023 jobs

--January
CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH from job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT *
from march_jobs


-- Case Expression

SELECT
COUNT(job_id) AS number_of_jobs,
Case
when job_location = 'Anywhere' THEN 'Remote'
when job_location = 'New York, NY' then 'Local'
else 'Onsite'
End as location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category

-- label new column as follows:
-- - 'Anywhere' as remote,
-- -New york jobs as local,
-- Otherwise Onsite.

-- Subqueries And Common table Expressions(CTEs) - used for simplifying complex queries


SELECT *
FROM (
    --Subquery starts here
    SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH from job_posted_date) = 1 
) AS january_jobs
--subquery ends here

--CTEs

WITH february_jobs AS (
    --cte def starts here
      SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH from job_posted_date) = 2
) --cte def ends here

SELECT *
FROM february_jobs


-- Companies offering jobs that don't have requirement for degree

SELECT
company_id,
name AS company_name
FROM company_dim

WHERE company_id IN (
SELECT
company_id

FROM
job_postings_fact

WHERE
job_no_degree_mention = true
)

ORDER BY company_id



/*
Find the companies that have the most job openings.
Get the total number of job postings per company id(job_posting_fact)
Return the job number of jobs with the company name(company_dim)

*/
WITH company_job_count AS (
    SELECT
        company_id,
        job_title_short,
        COUNT(*) AS job_count
    FROM 
        job_postings_fact
    GROUP BY 
        company_id, job_title_short
)

SELECT *
FROM company_job_count
ORDER BY job_title_short ASC;



-----------------------

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)
-- JOIN

SELECT company_dim.name AS company_name,
company_job_count.total_jobs

FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id

ORDER BY total_jobs DESC

/*

Find the count of the number of remote jobs posting per skill
Display the top 5 skills by their demand in romote jobs
Include skill ID, name and count of postings requiring the skill
*/


WITH remote_job_skills AS (

--Inner Join

SELECT
skill_id,
COUNT(*) AS skill_count

FROM
skills_job_dim AS skills_to_job

INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id

WHERE 
job_postings.job_work_from_home = True AND
job_postings.job_title_short = 'Data Analyst'

GROUP BY skill_id
)

SELECT 
skills.skill_id,
skills AS skill_name,
skill_count

FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id

ORDER BY skill_count DESC
LIMIT 5;



-- Unions Operator

-- Union- combines results from two or more statements

-- They need to have the same amount of columns and the data type must match

SELECT 
job_title_short,
company_id,
job_location

FROM
january_jobs


UNION

SELECT 
job_title_short,
company_id,
job_location

FROM
february_jobs


UNION

SELECT 
job_title_short,
company_id,
job_location

FROM
march_jobs


-- UNION ALL
-- RETURNS duplicates as well


SELECT 
job_title_short,
company_id,
job_location

FROM
january_jobs


UNION ALL

SELECT 
job_title_short,
company_id,
job_location

FROM
february_jobs


UNION ALL

SELECT 
job_title_short,
company_id,
job_location

FROM
march_jobs


--Find job postings from the Q1 that have a salary greater than $70k 
-- - combine job posting tables from thr first quarter of 2023(Jan- Mar)

-- Get job postings with an average yearly salary > 70,000

SELECT 
job_title_short,
job_location,
job_via,
job_posted_date::DATE,
salary_year_avg
FROM
(
SELECT *
FROM
january_jobs
UNION ALL
SELECT *
FROM
february_jobs
UNION ALL
SELECT *
FROM
march_jobs

) AS quarter_one_job_postings

WHERE salary_year_avg > 70000 AND
job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC


































