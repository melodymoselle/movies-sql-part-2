-- Get the average rating for a movie
SELECT m.movieid, m.title, avg(r.rating)
FROM movies m
LEFT JOIN ratings r ON m.movieid = r.movieid
GROUP BY m.movieid;

-- Get the total ratings for a movie
SELECT m.title, count(r.rating)
FROM movies m
LEFT JOIN ratings r ON m.movieid = r.movieid
GROUP BY m.movieid;

-- Get the total movies for a genre
SELECT g.genres, count(m.movieid)
FROM genre g
JOIN movie_genre mg ON g.id = mg.genre_id
JOIN movies m ON mg.movieid = m.movieid
GROUP BY g.genres;

-- Get the average rating for a user
SELECT userid, avg(rating)
FROM ratings
GROUP BY userid;

-- Find the user with the most ratings
SELECT userid, count(rating)
FROM ratings
GROUP BY userid
ORDER BY count(rating) DESC;

-- Find the user with the highest average rating
SELECT userid, avg(rating), count(rating)
FROM ratings
GROUP BY userid
ORDER BY avg(rating) DESC ;

-- Find the user with the highest average rating with more than 50 reviews
SELECT userid, avg(rating), count(rating)
FROM ratings
GROUP BY userid
  HAVING count(rating) > 50
ORDER BY avg(rating) DESC ;

-- Find the movies with an average rating over 4
SELECT m.title, avg(r.rating), count(r.rating)
FROM movies m
JOIN ratings r ON m.movieid = r.movieid
GROUP BY m.title
HAVING avg(r.rating) > 4
ORDER BY count(r.rating) DESC, avg(r.rating) DESC ;

-- For each genre find the total number of reviews as well as the average review sort by highest average review.
SELECT g.genres, count(r.rating), avg(r.rating)
FROM genre g
JOIN movie_genre mg ON g.id = mg.genre_id
JOIN movies m ON mg.movieid = m.movieid
JOIN ratings r ON m.movieid = r.movieid
GROUP BY g.genres
ORDER BY avg(r.rating) DESC ;

-- Create a new table called actors (We are going to pretend the actor can only play in one movie) The table should include name, character name, foreign key to movies and date of birth at least plus an id field.
CREATE TABLE public.actors
(
    id SERIAL PRIMARY KEY NOT NULL,
    actor_name VARCHAR(255) NOT NULL,
    character_name VARCHAR(255) NOT NULL,
    movieid INTEGER NOT NULL,
    dob DATE,
    CONSTRAINT actors_movies_movieid_fk FOREIGN KEY (movied) REFERENCES movies (movieid)
);

-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
INSERT INTO actors (actor_name, character_name, movieid, dob) VALUES ('Walter Matthau', 'Max Goldman', 3, '10/01/1920'),('Jack Lemmon', 'John Gustafson', 3, '02/08/1925'), ('Sophia Loren', 'Maria Sophia Coletta Ragetti', 3, '09/20/1934'), ('Ann-Margret', 'Ariel Gustafson', 3, '04/20/1941'), ('Burgess Meredith', 'Grandpa Gustafson', 3, '11/16/1907'), ('Daryl Hannah', 'Melanie Gustafson', 3, '12/03/1960'),('Kevin Pollak', 'Jacob Goldman', 3, '10/30/1957'), ('Katie Sagona', 'Allie, Melanies Daughter', 3, '11/26/1989'), ('Ann Morgan Guilbert', 'Mama Ragetti', 3, '10/16/1928'),('James Andelin', 'Sven', 3, '09/27/1917');
INSERT INTO actors (actor_name, character_name, movieid, dob) VALUES ('Alicia Silverstone', 'Cher', 39, '10/04/1976'), ('Stacey Dash', 'Dionne', 39, '01/20/1967'), ('Brittany Murphy', 'Tai', 39, '11/10/1977'), ('Paul Rudd', 'Josh', 39, '04/06/1969'), ('Donald Faison', 'Murray', 39, '06/22/1974'), ('Elisa Donovan', 'Amber', 39, '02/03/1971'),('Breckin Meyer', 'Travis', 39, '05/07/1974'), ('Jeremy Sisto', 'Elton', 39, '10/06/1974'), ('Dan Hedaya', 'Mel Horowitz', 39, '07/24/1940'), ('Aida Linares', 'Lucy', 39, '01/01/1900');
INSERT INTO actors (actor_name, character_name, movieid, dob) VALUES ('John Candy', 'Sheriff Buf Boomer', 157, '10/30/1950'), ('Alan Alda', 'PROTUS', 157, '01/28/1936'), ('Rhea Perlman', 'Honey', 157, '03/31/1948'), ('Kevin Pollak', 'Stu Smiley', 157, '10/30/1957'), ('Rip Torn', 'General Dick Panzer', 157, '06/02/1931'), ('Kevin J. OConnor', 'Roy Boy', 157, '11/15/1963'), ('Bill Nunn', 'Kabral', 157, '10/20/1953'), ('G.D. Spradlin', 'R. J. Hacker', 157, '07/25/2011'), ('Steven Wright', 'Niagrara Mountie', 157, '12/06/1955'), ('Jim Belushi', 'Charles Jackal', 157, '06/15/1954');

-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating
ALTER TABLE public.movies ADD mpaa_rating VARCHAR(8) NULL;
UPDATE movies SET mpaa_rating = 'PG' WHERE movieid = 157;
UPDATE movies SET mpaa_rating = 'PG-13' WHERE movieid = 39;
UPDATE movies SET mpaa_rating = 'PG-13' WHERE movieid = 3;
UPDATE movies SET mpaa_rating = 'R' WHERE movieid = 6;
UPDATE movies SET mpaa_rating = 'PG' WHERE movieid = 150;

-- Create a new field on the movies table for the year. Using an update query and a substring method update that column for every movie with the year found in the title column.
ALTER TABLE public.movies ADD year VARCHAR(4) NULL;
UPDATE movies SET year = substring(title, '\d{4}');

-- Now that we know we can add actors create a join table between actors and movies.
CREATE TABLE public.movie_actor
(
    id SERIAL PRIMARY KEY NOT NULL,
    movie_id INT NOT NULL,
    actor_id INT NOT NULL,
    character_name VARCHAR(255) NOT NULL,
    CONSTRAINT movie_actor_movies_movieid_fk FOREIGN KEY (movie_id) REFERENCES movies (movieid),
    CONSTRAINT movie_actor_actors_id_fk FOREIGN KEY (actor_id) REFERENCES actors (id)
);
INSERT INTO movie_actor (movie_id, actor_id, character_name)
SELECT movieid, id, character_name
FROM actors;

-- Once you have completed the new year column go through the title column and strip out the year.
SELECT movieid, title, substr(title, 1, length(title)-7)
FROM movies
LIMIT 10;

UPDATE movies SET title = substr(title, 1, length(title)-7) WHERE movieid = 157;
UPDATE movies SET title = substr(title, 1, length(title)-7) WHERE movieid != 157;

-- Create a new column in the movies table and store the average review for each and every movie.
ALTER TABLE movies ADD avg_rating int NULL;
SELECT m.movieid, m.title, avg(r.rating)
FROM movies m
LEFT JOIN ratings r ON m.movieid = r.movieid
GROUP BY m.movieid;
UPDATE movies m1 SET avg_rating = mr.rating
FROM (
    SELECT m.movieid, m.title, avg(r.rating) as rating
  FROM movies m
  LEFT JOIN ratings r ON m.movieid = r.movieid
  GROUP BY m.movieid
) AS mr
WHERE m1.movieid = mr.movieid AND m1.movieid != 157;



