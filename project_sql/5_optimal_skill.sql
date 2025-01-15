with skills_demand AS
(SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
from 
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' and 
      job_work_from_home = 'true'
    and    salary_year_avg is  NOT NULL

group by skills_dim.skill_id
) ,
average_salary as 
(SELECT
    skills_job_dim.skill_id,
    round(avg(salary_year_avg),0) as avg_salary
from 
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' and 
      salary_year_avg is  NOT NULL
      and job_work_from_home = 'true'
group by skills_job_dim.skill_id
)

SELECT
skills_demand.skill_id,
skills_demand.skills,
skills_demand.demand_count,
average_salary.avg_salary
from skills_demand
INNER JOIN average_salary on average_salary.skill_id = skills_demand.skill_id
where demand_count > 10
ORDER BY avg_salary DESC,
         demand_count desc
limit 25;


--more easier way
select 
skills_dim.skill_id,
skills_dim.skills,
count(skills_job_dim.job_id) as demand_count,
round(avg(salary_year_avg),0) as avg_salary
FROM job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
job_title_short = 'Data Analyst' and 
salary_year_avg is  NOT NULL
and job_work_from_home = 'true'
group BY
skills_dim.skill_id
HAVING
count(skills_job_dim.job_id) > 10
order by
avg_salary DESC,
demand_count desc
limit 25;