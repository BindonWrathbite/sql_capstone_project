SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE
    job_schedule_type ILIKE '%full%'
    AND job_work_from_home IS TRUE
GROUP BY
    job_id
ORDER BY
    salary_year_avg DESC
LIMIT 10