SELECT m.id, m.title, COUNT(mp.person_id) AS actors_count
FROM movies AS m
    JOIN movie_persons AS mp ON m.id = mp.movie_id
WHERE
    DATE_PART('year', m.release_date) >= DATE_PART('year', CURRENT_TIMESTAMP) - 5
GROUP BY
    m.id;