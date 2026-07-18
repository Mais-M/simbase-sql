-- =========================================================
-- SimBase: Analytical SQL Queries
-- =========================================================


-- 1. Complete profile of every Sim
SELECT
    s.sim_id,
    s.first_name,
    s.last_name,
    s.age_stage,
    h.household_name,
    a.aspiration_name
FROM sims AS s
JOIN households AS h
    ON s.household_id = h.household_id
LEFT JOIN aspirations AS a
    ON s.aspiration_id = a.aspiration_id
ORDER BY s.last_name, s.first_name;


-- 2. The most socially connected Sims
WITH relationship_network AS (
    SELECT
        sim_id_1 AS sim_id,
        sim_id_2 AS connected_sim_id
    FROM relationships
    WHERE is_active = TRUE

    UNION ALL

    SELECT
        sim_id_2 AS sim_id,
        sim_id_1 AS connected_sim_id
    FROM relationships
    WHERE is_active = TRUE
)
SELECT
    s.sim_id,
    s.first_name,
    s.last_name,
    COUNT(DISTINCT rn.connected_sim_id) AS number_of_connections
FROM sims AS s
LEFT JOIN relationship_network AS rn
    ON s.sim_id = rn.sim_id
GROUP BY
    s.sim_id,
    s.first_name,
    s.last_name
ORDER BY
    number_of_connections DESC,
    s.last_name;


-- 3. Career progression using the LAG window function
SELECT
    s.first_name,
    s.last_name,
    c.career_name,
    ch.career_level,
    ch.salary,
    ch.start_date,
    LAG(ch.career_level) OVER (
        PARTITION BY ch.sim_id, ch.career_id
        ORDER BY ch.start_date
    ) AS previous_career_level,
    ch.career_level
        - LAG(ch.career_level) OVER (
            PARTITION BY ch.sim_id, ch.career_id
            ORDER BY ch.start_date
        ) AS level_change
FROM career_history AS ch
JOIN sims AS s
    ON ch.sim_id = s.sim_id
JOIN careers AS c
    ON ch.career_id = c.career_id
ORDER BY
    s.last_name,
    s.first_name,
    ch.start_date;


-- 4. Current salary ranking within each career
SELECT
    s.first_name,
    s.last_name,
    c.career_name,
    ch.career_level,
    ch.salary,
    DENSE_RANK() OVER (
        PARTITION BY c.career_id
        ORDER BY ch.salary DESC
    ) AS salary_rank
FROM career_history AS ch
JOIN sims AS s
    ON ch.sim_id = s.sim_id
JOIN careers AS c
    ON ch.career_id = c.career_id
WHERE ch.end_date IS NULL
ORDER BY
    c.career_name,
    salary_rank;


-- 5. Current residence and property value of each household
SELECT
    h.household_name,
    n.neighborhood_name,
    hs.address,
    hs.lot_name,
    hs.property_value,
    hr.move_in_date
FROM household_residences AS hr
JOIN households AS h
    ON hr.household_id = h.household_id
JOIN houses AS hs
    ON hr.house_id = hs.house_id
JOIN neighborhoods AS n
    ON hs.neighborhood_id = n.neighborhood_id
WHERE hr.move_out_date IS NULL
ORDER BY hs.property_value DESC;


-- 6. Sims with the fewest social connections
WITH relationship_network AS (
    SELECT sim_id_1 AS sim_id
    FROM relationships
    WHERE is_active = TRUE

    UNION ALL

    SELECT sim_id_2 AS sim_id
    FROM relationships
    WHERE is_active = TRUE
)
SELECT
    s.sim_id,
    s.first_name,
    s.last_name,
    COUNT(rn.sim_id) AS number_of_connections,
    CASE
        WHEN COUNT(rn.sim_id) = 0 THEN 'High isolation risk'
        WHEN COUNT(rn.sim_id) = 1 THEN 'Moderate isolation risk'
        ELSE 'Connected'
    END AS social_status
FROM sims AS s
LEFT JOIN relationship_network AS rn
    ON s.sim_id = rn.sim_id
GROUP BY
    s.sim_id,
    s.first_name,
    s.last_name
ORDER BY
    number_of_connections,
    s.last_name;


-- 7. Average relationship scores by relationship type
SELECT
    relationship_type,
    COUNT(*) AS total_relationships,
    ROUND(AVG(daily_score), 2) AS average_daily_score,
    ROUND(AVG(lifetime_score), 2) AS average_lifetime_score
FROM relationships
WHERE is_active = TRUE
GROUP BY relationship_type
ORDER BY average_lifetime_score DESC;


-- 8. Sims earning more than the average salary in their career
SELECT
    s.first_name,
    s.last_name,
    c.career_name,
    ch.salary
FROM career_history AS ch
JOIN sims AS s
    ON ch.sim_id = s.sim_id
JOIN careers AS c
    ON ch.career_id = c.career_id
WHERE ch.end_date IS NULL
  AND ch.salary > (
      SELECT AVG(ch2.salary)
      FROM career_history AS ch2
      WHERE ch2.career_id = ch.career_id
        AND ch2.end_date IS NULL
  )
ORDER BY ch.salary DESC;