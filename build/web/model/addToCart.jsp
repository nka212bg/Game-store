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


<%

    /*
    GETS THE VALUES OF THE PARAMETERS OF THE REQUEST
     */
    String userid = request.getParameter("userid");
    String gameid = request.getParameter("gameid");

    Statement st = DBW.getDbConnection().createStatement();
    ResultSet rs = st.executeQuery("select * from cart where userid = '" + userid + "'and gameid = '" + gameid + "'");

    /*
    IF THE GAME IS NOT IN THE FAVORITES
     */
    if (!rs.next()) {
        int quantity = Integer.parseInt(request.getParameter("gameQuantity"));
        try {

            DBW.setDataTo("INSERT INTO cart (`userid`, `gameid`, `quantity`) VALUES ('" + userid + "', '" + gameid + "', '" + quantity + "');");

            ResultSet rs2 = st.executeQuery("select * from game where gameid = '" + gameid + "'");
            while (rs2.next()) {
                String gamename = rs2.getString("gamename");
                /*
                WRITE IN TO THE LOG
                 */
                //String userid = rs.getString("userid");
                //String userid = (String) session.getAttribute("userid");
                LogWriter logWriter = new LogWriter();
                String action = "Game | " + gamename + "<br>added to cart";
                logWriter._logWriter(userid, action);
            }

            /*
                CLOSES THE CONNECTION
             */
            rs.close();
            st.close();

            if (request.getParameterMap().containsKey("cart")) {
                response.sendRedirect("../controller?cart");
                return;
            }
            if (request.getParameterMap().containsKey("special")) {
                response.sendRedirect("../controller?special");
                return;
            }
            if (request.getParameterMap().containsKey("favorites")) {
                response.sendRedirect("../controller?favorites");
                return;
            }
            if (request.getParameterMap().containsKey("search")) {
                response.sendRedirect("../controller?search");
                return;
            } else {
                response.sendRedirect("../controller?gameid=" + gameid);
                return;
            }

        } catch (Exception e) {
            out.println(e);
        }

    } else {

        try {

            /*
                CREATES THE QUERY THAT IS SENT TO THE DATABASE
             */
            DBW.setDataTo("DELETE FROM cart WHERE userid='" + userid + "' AND gameid = '" + gameid + "'");

            ResultSet rs2 = st.executeQuery("select * from game where gameid = '" + gameid + "'");
            while (rs2.next()) {
                String gamename = rs2.getString("gamename");
                /*
                WRITE IN TO THE LOG
                 */
                //String userid = rs.getString("userid");
                //String userid = (String) session.getAttribute("userid");
                LogWriter logWriter = new LogWriter();
                String action = "Game | " + gamename + "<br>removed from cart";
                logWriter._logWriter(userid, action);
            }

            /*
                CLOSES THE CONNECTION
             */
            rs2.close();
            st.close();

            if (request.getParameterMap().containsKey("cart")) {
                response.sendRedirect("../controller?cart");
                return;
            }
            if (request.getParameterMap().containsKey("special")) {
                response.sendRedirect("../controller?special");
                return;
            }
            if (request.getParameterMap().containsKey("favorites")) {
                response.sendRedirect("../controller?favorites");
                return;
            }
            if (request.getParameterMap().containsKey("search")) {
                response.sendRedirect("../controller?search");
                return;
            } else {
                response.sendRedirect("../controller?gameid=" + gameid);
                return;
            }

        } catch (Exception e) {
            out.println(e);
        }

    }

%>