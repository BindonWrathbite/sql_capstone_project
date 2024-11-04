SELECT
    query1.job_id AS job_id,
    query1.job_title AS job_title,
    query1.salary_year_avg AS average_annual_salary,
    skills_dim.skills
FROM
    query1
    INNER JOIN skills_job_dim
    ON query1.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg
