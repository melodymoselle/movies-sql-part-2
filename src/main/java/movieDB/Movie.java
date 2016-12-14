package movieDB;

import java.sql.*;

/**
 * Created by melmo on 12/13/16.
 */
public class Movie {
    private int movieId = 0;
    private String title;
    private String genres;
    private String mpaaRating;
    private int year;
    private int avgRating;

    public static  Movie getMovie(int id) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql:moviescopy");
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery(
                "SELECT * FROM movies WHERE movieid = " + id);
        result.next();
        int movieId = result.getInt("movieid");
        String title = result.getString("title");
        String genres = result.getString("genres");
        String mpaaRating = result.getString("mpaa_rating");
        int year = result.getInt("year");
        int avgRating = result.getInt("avg_rating");

        return new Movie(movieId, title, genres, mpaaRating, year, avgRating);
    }

    public void save() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql:moviescopy");
        if (this.id < 0) {
            PreparedStatement insert = connection.prepareStatement(
                    "INSERT INTO movies (title, genres, mpaa_rating, year, avg_rating) VALUES(?,?,?,?,?)");
            insert.setString(1, this.title);
            insert.setString(2, this.genres);
            insert.setString(3, this.mpaaRating);
            insert.setInt(4, this.year);
            insert.setInt(5, this.avgRating);
            insert.executeUpdate();
        }
        else {
            PreparedStatement update = connection.prepareStatement(
                    "UPDATE movies SET title=?, genres=?, mpaa_rating=?, year=?, avg_rating=? WHERE movieid=?");
            update.setString(1, this.title);
            update.setString(2, this.genres);
            update.setString(3, this.mpaaRating);
            update.setInt(4, this.year);
            update.setInt(5, this.avgRating);
            update.executeUpdate();
        }

    }

    public Movie(String title, String genres, String mpaaRating, int year, int avgRating){
        this.title = title;
        this.genres = genres;
        this.mpaaRating = mpaaRating;
        this.year = year;
        this.avgRating = avgRating;
    }

    public Movie(int movieId, String title, String genres, String mpaaRating, int year, int avgRating){
        this.movieId = movieId;
        this.title = title;
        this.genres = genres;
        this.mpaaRating = mpaaRating;
        this.year = year;
        this.avgRating = avgRating;
    }

    @Override
    public String toString() {
        return String.format("%s : %d", this.title, this.year);
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenres() {
        return genres;
    }

    public void setGenres(String genres) {
        this.genres = genres;
    }

    public String getMpaaRating() {
        return mpaaRating;
    }

    public void setMpaaRating(String mpaaRating) {
        this.mpaaRating = mpaaRating;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(int avgRating) {
        this.avgRating = avgRating;
    }
}
