SELECT u.id, u.username, ARRAY_AGG(m.movie_id) AS favorite_movie_ids
FROM users AS u
    LEFT JOIN favorite_movies AS m ON u.id = m.user_id
GROUP BY
    u.id