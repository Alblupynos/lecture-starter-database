SELECT
    d.id,
    CONCAT(d.first_name, d.last_name) AS director_name,
    AVG(m.budget) AS average_budget
FROM directors AS d
    LEFT JOIN movies AS m ON d.id = m.director_id
GROUP BY
    d.id