--What are the most in-demand skills for data analysts in the United kingdom?
-- Join job posting to inner join table similar to query 2
-- focus on all the job postings
-- Why? Retrieves the top 5 skills with the highest demand in the job market,


-------------------------------------------------------------

--top demanded DA skills in the UK

SELECT 
skills,
COUNT(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact
INNER JOIN  skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_location = 'United Kingdom' AND job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC

LIMIT 5


--Top demanded skills in the world

SELECT 
skills,
COUNT(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact
INNER JOIN  skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
AND job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC

LIMIT 5




