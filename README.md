# Movie SQL Part 2

## Tasks

### Complete the following aggregation objectives:

* Get the average rating for a movie
* Get the total ratings for a movie
* Get the total movies for a genre
* Get the average rating for a user
* Find the user with the most ratings
* Find the user with the highest average rating
* Find the user with the highest average rating with more than 50 reviews
* Find the movies with an average rating over 4
* For each genre find the total number of reviews as well as the average review sort by highest average review.

Complete the following modification objectives:

* Create a new table called actors (We are going to pretend the actor can only play in one movie)
The table should include name, character name, foreign key to movies and date of birth at least plus an id field.

* Pick 3 movies and create insert statements for 10 actors each.  You should use the multi value insert statements

* Create a new column in the movie table to hold the MPAA rating.
UPDATE 5 different movies to their correct rating


## Hard Mode
* Create a new field on the movies table for the year.  Using an update query and a substring method update that column for every movie with the year found in the title column.
HINT: The pattern needed is '\d{4}' and depending on how your datagrip was set up you may need to use the psql command line to get the query to work.

* Now that we know we can add actors create a join table between actors and movies.  This table should not only have the foreign keys for each of the tables, include an extra field for the character name for the actor.  Use the current actor table to populate the join table with data including the character’s name

* Once you have completed the new year column go through the title column and strip out the year.

* Create a new column in the movies table and store the average review for each and every movie. 

* Create a new project for movies:
	* Make a class `Movie` with the attributes of the movies table
	* Create a `static` method that takes an `id` and returns a populated object from the database
	* Create a `save` method in the class that will either create a new object or update the existing object.

## External Links
* [Github Repo](https://github.com/tiy-lv-java-2016-06/movie-sql-part-2)
