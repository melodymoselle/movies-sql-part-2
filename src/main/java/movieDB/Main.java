package movieDB;

import java.sql.SQLException;

/**
 * Created by melmo on 12/13/16.
 */
public class Main {
    public static void main(String[] args) throws SQLException {

        Movie cb = Movie.getMovie(157);
        System.out.println(cb);

    }
}
