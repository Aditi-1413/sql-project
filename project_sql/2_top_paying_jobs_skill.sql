/*
This query identifies the top 10 highest-paying Data Analyst jobs that are location-independent, and then retrieves the associated skills for those jobs. It uses a Common Table Expression (CTE) named `top_paying_jobs` to first select the relevant job details, and then joins this CTE with the `skills_job_dim` and `skills_dim` tables to get the skills required for these top-paying positions. The final results are ordered by average yearly salary in descending order.
*/
WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
left JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short='Data Analyst' AND job_location='Anywhere' AND salary_year_avg IS NOT NULL 
ORDER BY salary_year_avg DESC
LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
order by salary_year_avg desc;
-- Most In-Demand Skills
-- SQL — appeared 8 times
-- Python — appeared 7 times
-- Tableau — appeared 6 times
-- R — appeared 4 times
-- Snowflake — appeared 3 times
-- Highest Paying Skills

-- Some specialized tools were associated with the highest salaries:

-- Jupyter
-- PySpark
-- Databricks
-- PowerPoint
-- Hadoop

-- These skills appeared in very high-paying roles, especially cloud/data engineering focused analyst positions.

-- What This Means
-- SQL + Python + Tableau form the core skill stack for high-paying data analyst roles.
-- Cloud and big data tools like Databricks, Snowflake, PySpark, Hadoop are becoming premium skills.
-- Traditional analytics skills are no longer enough for top salaries — companies value analysts who can work with large-scale data systems.