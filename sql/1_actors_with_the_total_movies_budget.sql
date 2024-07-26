SELECT p.id, p.first_name, p.last_name, SUM(m.budget) AS total_budget
FROM
    persons AS p
    JOIN movie_persons AS mp ON p.id = mp.person_id
    JOIN movies AS m ON mp.movie_id = m.id
GROUP BY
    p.id