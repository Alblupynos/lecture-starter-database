SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration_minutes,
    m.description,
    row_to_json(f.*) AS poster,
    row_to_json(
        cast(
            row (
                d.id,
                d.first_name,
                d.last_name,
                row_to_json(fd.*)
            ) AS person_photo_json
        )
    ) AS director,
    (
        SELECT JSON_AGG(
                to_json(
                    cast(
                        row (
                            p.id, p.first_name, p.last_name, row_to_json(fp.*)
                        ) AS person_photo_json
                    )
                )
            )
        FROM
            movie_persons AS mp
            JOIN persons AS p ON mp.person_id = p.id
            JOIN files AS fp ON p.primary_photo_file_id = fp.id
        WHERE
            mp.movie_id = m.id
    ) AS actors,
    (
        SELECT JSON_AGG(
                to_json(
                    cast(
                        row (g.id, g.name) AS genre_json
                    )
                )
            )
        FROM movie_genres AS mg
            JOIN genres AS g ON mg.genre_id = g.id
        WHERE
            mg.movie_id = m.id
    ) AS genres
FROM
    movies AS m
    JOIN files AS f ON m.poster_file_id = f.id
    JOIN directors AS d ON m.director_id = d.id
    JOIN files AS fd ON d.photo_file_id = fd.id
WHERE
    m.id = 1;