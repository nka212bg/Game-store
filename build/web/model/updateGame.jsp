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

    /*
    GETS THE VALUES OF THE PARAMETERS OF THE REQUEST
     */
    String gameid = request.getParameter("gameid");
    String gamename = request.getParameter("gamename");
    String game_description = request.getParameter("game_description");
    String comments = request.getParameter("comments");
    String price = request.getParameter("price");
    String console = request.getParameter("console");
    String num_players = request.getParameter("num_players");
    String genre = request.getParameter("genre");
    String coop = request.getParameter("coop");
    String release_date = request.getParameter("release_date");
    String developer = request.getParameter("developer");
    String publisher = request.getParameter("publisher");
    String front_box_art = request.getParameter("front_box_art");
    String back_box_art = request.getParameter("back_box_art");
    String logo = request.getParameter("logo");
    String developer_logo = request.getParameter("developer_logo");
    String special = request.getParameter("special");
    String inventory = request.getParameter("inventory");

    gamename = request.getParameter("gamename");
    gamename = gamename.replace("'", "\\'");

    game_description = request.getParameter("game_description");
    game_description = game_description.replace("'", "\\'");

    comments = request.getParameter("comments");
    comments = comments.replace("'", "\\'");

    console = request.getParameter("console");
    if (console == null) {
        console = "Xbox";
    }

    num_players = request.getParameter("num_players");
    if (num_players == null) {
        num_players = "1";
    }

    genre = request.getParameter("genre");
    if (genre == null) {
        genre = "Action";
    }

    try {

        /*
                CREATES THE QUERY THAT IS SENT TO THE DATABASE
         */
        DBW.setDataTo("UPDATE game SET gameid = '" + gameid + "', gamename = '" + gamename + "',"
                + " game_description = '" + game_description + "', comments = '" + comments + "', price = '" + price + "', "
                + "console = '" + console + "', num_players = '" + num_players + "', genre = '" + genre + "', coop = '" + coop + "', "
                + "release_date = '" + release_date + "', developer = '" + developer + "' , "
                + "publisher = '" + publisher + "' , front_box_art = '" + front_box_art + "', "
                + "back_box_art = '" + back_box_art + "' , logo = '" + logo + "', developer_logo = '" + developer_logo + "', "
                + "special = '" + special + "', "
                + "inventory = '" + inventory + "' WHERE gameid='" + gameid + "'");


        /*
            WRITE IN TO THE LOG
         */
        String userid = (String) session.getAttribute("userid");
        LogWriter logWriter = new LogWriter();
        String action = "Edit game with name: " + gamename;
        logWriter._logWriter(userid, action);

        /*  Spiner "working" and redirect */
        out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Working ...</span></div>"
                + "<meta http-equiv='Refresh' content='1;url=../controller?gameid=" + gameid + "'>");
        return;

    } catch (Exception e) {
        out.println(e);
    }


%>