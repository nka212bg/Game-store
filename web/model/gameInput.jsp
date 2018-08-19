<%@page import="controller.DBW"%>
<%@page import="model.LogWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%

    String gamename = request.getParameter("gamename");
    gamename = gamename.replace("'", "\\'");

    String game_description = request.getParameter("game_description");
    game_description = game_description.replace("'", "\\'");

    String comments = request.getParameter("comments");
    comments = comments.replace("'", "\\'");

    String console = request.getParameter("console");
    if (console == null) {
        console = "Xbox";
    }

    String num_players = request.getParameter("num_players");
    if (num_players == null) {
        num_players = "1";
    }

    String genre = request.getParameter("genre");
    if (genre == null) {
        genre = "Action";
    }

    String coop = request.getParameter("coop");
    String price = request.getParameter("price");
    String release_date = request.getParameter("release_date");
    String developer = request.getParameter("developer");
    String publisher = request.getParameter("publisher");
    String front_box_art = request.getParameter("front_box_art");
    String back_box_art = request.getParameter("back_box_art");
    String logo = request.getParameter("logo");
    String developer_logo = request.getParameter("developer_logo");
    String special = request.getParameter("special");
    String inventory = request.getParameter("inventory");

    try {

        DBW.setDataTo("INSERT INTO game (`gamename`, `game_description`, `price`, `comments`, `console`, "
                + "`num_players`, `genre`, `coop`, `release_date`, `developer`, `publisher`, `front_box_art`,"
                + " `back_box_art`, `logo`, `developer_logo`, `special`,`inventory` ) VALUES ('" + gamename + "',"
                + " '" + game_description + "',  '" + price + "', '" + comments + "', '" + console + "', '" + num_players + "',"
                + " '" + genre + "', '" + coop + "', '" + release_date + "', '" + developer + "', '" + publisher + "',"
                + " '" + front_box_art + "', '" + back_box_art + "', '" + logo + "', '" + developer_logo + "', '" + special + "', '" + inventory + "');");

        /*
        WRITE IN TO THE LOG
         */
        //String userid = rs.getString("userid");
        String userid = (String) session.getAttribute("userid");
        LogWriter logWriter = new LogWriter();
        String action = "Insert new game with name: " + gamename;
        logWriter._logWriter(userid, action);

    } catch (Exception e) {
        out.println(e);
    }

    /*  Spiner "working" and redirect */
    out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Working ...</span></div>"
            + "<meta http-equiv='Refresh' content='1;url=../uploadGames.jsp'>");
    return;

%>

