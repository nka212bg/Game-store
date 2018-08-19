package controller;

import java.sql.*;

public class DBW {

    private static Connection conn = null;

    private DBW() {
    }

    public static Connection getDbConnection() {
        try {
            if (conn == null) {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gameapp?useSSL=false", "user-xxxxxxxxxxxx", "pass-xxxxxxxxxxxx");
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return conn;
    }

    public static void setDataTo(String query) {
        try {
            PreparedStatement p = getDbConnection().prepareStatement(query);
            p.executeUpdate();
//            conn.close();

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }
}
