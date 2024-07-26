SELECT m.id, m.title, m.release_date, m.duration_minutes, m.description, row_to_json(f.*) AS poster, row_to_json(
        cast(
            row (
                d.id, d.first_name, d.last_name
            ) AS director_json
        )
    ) AS director
FROM
    movies AS m
    JOIN directors AS d ON m.director_id = d.id
    JOIN files AS f ON m.poster_file_id = f.id
    JOIN movie_genres AS mg ON m.id = mg.movie_id
    JOIN genres AS g ON mg.genre_id = g.id
WHERE
    m.country_id = 1
    AND DATE_PART('year', m.release_date) >= 2022
    AND m.duration_minutes > 135
    AND g.name IN ('Action', 'Drama');

GROUP BY m.id