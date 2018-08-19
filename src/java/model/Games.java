package model;

import controller.DBW;
import java.sql.*;
import javax.sql.*;

public class Games {

    private ResultSet searchRequest = null;

    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement st = null;

    /*
    RESULTSET BASED ON USER'S INPUT
     */
    public ResultSet getSelectedGames(String gamename, String console,
            String num_players, String genre, String publisher, String priceFrom, String priceTo) {

        try {

//            conn = dataSource.getConnection();

            /*
            THE QUERY IS GENERATED BASED ON THE FIELDS THAT THE USER SELECTS
             */
            String mainQuery = "SELECT * FROM game WHERE 1=1";

            String gamenameADD = (" AND gamename='" + gamename + "'");
            String consoleADD = (" AND console='" + console + "'");
            String numOfPlayersADD = (" AND num_players = '" + num_players + "'");
            String genreADD = (" AND genre='" + genre + "'");
            String publisherADD = (" AND publisher='" + publisher + "'");
            String gamePriceFROM = (" AND price>='" + priceFrom + "'");
            String gamePriceTO = (" AND price<='" + priceTo + "'");

            //Overrides the additional query conditions if default values and adds empty string to the mainQuery 
            if (gamename == null) {
                gamenameADD = "";
            }
            if (console == null) {
                consoleADD = "";
            }
            if (num_players == null) {
                numOfPlayersADD = "";
            }

            if (genre == null) {
                genreADD = "";
            }
            if (publisher == null) {
                publisherADD = "";
            }

            if ((priceFrom == null) || (priceFrom == "")) {
                gamePriceFROM = "";
            }

            if ((priceTo == null) || (priceTo == "")) {
                gamePriceTO = "";
            }

            st = DBW.getDbConnection().createStatement();
            searchRequest = st.executeQuery(mainQuery + gamenameADD + consoleADD + numOfPlayersADD + genreADD + publisherADD + gamePriceFROM + gamePriceTO);

        } catch (Exception e) {
            e.printStackTrace();
            return searchRequest;
        }

        return searchRequest;
    }

    public ResultSet getGameId(int gameId) {

        try {

            st = DBW.getDbConnection().createStatement();
            searchRequest = st.executeQuery("select * from game where gameid='" + gameId + "'");

        } catch (Exception e) {
            e.printStackTrace();
            return searchRequest;
        }

        return searchRequest;
    }

    public ResultSet getSpecial() {

        try {

            st = DBW.getDbConnection().createStatement();
            searchRequest = st.executeQuery("select * from game where special='" + 1 + "'");

        } catch (Exception e) {
            e.printStackTrace();
            return searchRequest;
        }

        return searchRequest;

    }

    public ResultSet getFavorites(String userid) {

        try {

            st = DBW.getDbConnection().createStatement();
            searchRequest = st.executeQuery("select * from game, favorites WHERE userid = '" + userid + "' AND game.gameid =  favorites.gameid ");

        } catch (Exception e) {
            e.printStackTrace();
            return searchRequest;
        }

        return searchRequest;

    }

    public ResultSet getCart(String userid) {

        try {

            st = DBW.getDbConnection().createStatement();
            searchRequest = st.executeQuery("select * from game, cart WHERE userid = '" + userid + "' AND game.gameid =  cart.gameid ");

        } catch (Exception e) {
            e.printStackTrace();
            return searchRequest;
        }

        return searchRequest;

    }

}
