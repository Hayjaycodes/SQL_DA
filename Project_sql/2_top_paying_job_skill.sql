/*
Question: What skills are required for the top-paying data analyst jobs in the UK?

- Use the top 10 highest paying Data Analyst jobs from 1st query
- Add the specific skills required for these roles
-Why ? It provides a detailed look at which high paying demand certain skills


*/


WITH top_paying_jobs AS(
SELECT 
job_id,
job_title,
salary_year_avg,
name AS company_name

FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE job_title_short = 'Data Analyst' AND
job_location = 'United Kingdom' AND
--( remove nulls).
salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
)


SELECT top_paying_jobs.*,
skills
FROM top_paying_jobs
INNER JOIN  skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY salary_year_avg DESC
LIMIT 10


-- Python — 5/10 postings
-- Excel — 4/10
-- SQL, Tableau — 3/10 each
-- Jupyter, SAS — 2/10 each
-- Power BI, Looker, Go, Git — 1/10 each
-- Quick insights

-- Core stack = Python + SQL + Excel. These three appear across most roles—make them rock-solid.

-- BI diversity matters. Tableau shows slightly more than Power BI here, but both appear; being tool-flexible helps.

-- Not just analysis—engineering habits. Mentions of Git and Go suggest some teams value version control and light engineering chops.

-- Notebooks & stats tools. Jupyter and SAS point to workflows spanning exploratory analysis and more formal/stat tooling.