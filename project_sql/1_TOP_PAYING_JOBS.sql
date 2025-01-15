SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_namea
    FROM
    job_postings_fact
LEFT JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
where job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere' and 
      salary_year_avg is not null
order BY
    salary_year_avg DESC
limit 10;