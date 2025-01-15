 

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