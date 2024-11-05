WITH in_demand_skills AS ( --Query3 being adapted
    SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM
    job_postings_fact
    INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
ORDER BY
    demand_count DESC
),

top_paying_skills AS (  --Query4 being adapted
    SELECT
        skills_dim.skill_id,
        skills_dim.skills AS skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS salary_avg
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE -- Looking for remote jobs
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        salary_avg DESC
)

--Main query to find most in-demand and top-paying skills.
SELECT
    in_demand_skills.skills,
    in_demand_skills.demand_count,
    top_paying_skills.salary_avg
FROM
    in_demand_skills
    INNER JOIN top_paying_skills
    ON in_demand_skills.skill_id = top_paying_skills.skill_id
ORDER BY
    demand_count DESC,
    salary_avg DESC
LIMIT 10