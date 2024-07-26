CREATE TABLE files (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(50) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    secret_key VARCHAR(50) NOT NULL,
    source_url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    avatar_file_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (avatar_file_id) REFERENCES files (id)
);

CREATE TABLE directors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    photo_file_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (photo_file_id) REFERENCES files (id)
);

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    budget INT NOT NULL,
    release_date DATE NOT NULL,
    duration_minutes INT NOT NULL,
    director_id INT NOT NULL,
    country_id INT NOT NULL,
    poster_file_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (director_id) REFERENCES directors (id),
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (poster_file_id) REFERENCES files (id)
);

CREATE TABLE movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (genre_id) REFERENCES genres (id)
);

CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('male', 'female')),
    country_id INT NOT NULL,
    primary_photo_file_id INT,
    additional_images JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (primary_photo_file_id) REFERENCES files (id)
);

CREATE TABLE movie_persons (
    movie_id INT,
    person_id INT,
    PRIMARY KEY (movie_id, person_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (person_id) REFERENCES persons (id)
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    role VARCHAR(16) NOT NULL CHECK (
        role IN (
            'leading',
            'supporting',
            'background'
        )
    ),
    movie_id INT NOT NULL,
    person_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (person_id) REFERENCES persons (id)
);

CREATE TABLE favorite_movies (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (movie_id) REFERENCES movies (id)
);

CREATE TYPE director_json AS (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TYPE person_photo_json AS (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    photo JSON
);

CREATE TYPE genre_json AS (id INT, name VARCHAR(50));