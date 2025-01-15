with top_paying_jobs as (
SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name as company_namea
    FROM
    job_postings_fact
LEFT JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
where job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere' and 
      salary_year_avg is not null
order BY
    salary_year_avg DESC
limit 10
)

select 
 top_paying_jobs.*,
 skills
from top_paying_jobs
INNER JOIN skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
order by salary_year_avg DESC