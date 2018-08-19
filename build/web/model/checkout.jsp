<%@page import="controller.DBW"%>
<%@page import="model.LogWriter"%>
<%@page import="java.util.UUID"%>
<%@page import="model.EmailSend"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%

    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String cvv = request.getParameter("cvv");
    String tottalPrice = request.getParameter("tottalPrice");
    String userid = request.getParameter("userid");

    Statement st = DBW.getDbConnection().createStatement();
    ResultSet rs = st.executeQuery("select * from user where userid='" + userid + "'");

    if (rs.next()) {

        String dbEmail = rs.getString("email");
        String dbPassword = rs.getString("password");
        String dbcvv = rs.getString("credit_card_cvv");
        String firstname = rs.getString("firstName");
        String lastname = rs.getString("lastName");

        long unixTime = System.currentTimeMillis(); // date string
        String orderid = userid + "-" + unixTime; // Order id

        if (dbEmail.equals(email) && dbPassword.equals(password) && dbcvv.equals(cvv)) {

            try {

                /*
                WRITE IN TO THE LOG
                 */
                //String userid = rs.getString("userid");
                //String userid = (String) session.getAttribute("userid");
                LogWriter logWriter = new LogWriter();
                String action = "<b style='color:red'>Checkout:<br>Order ID-" + orderid + " / Total price- $" + tottalPrice + "</b>";
                logWriter._logWriter(userid, action);

                //\\//  TAKE GAMES  //\\//\\//\\//\\//\\//\\//\\//\\//\\//         
                ResultSet getFromCart = st.executeQuery("select * from game, cart WHERE userid = '" + userid + "' AND game.gameid =  cart.gameid ");
                String gameList = "";
                while (getFromCart.next()) {
                    String gamename = getFromCart.getString("gamename");
                    String price = getFromCart.getString("price");
                    int quantity = Integer.parseInt(getFromCart.getString("quantity"));

                    String gameid = getFromCart.getString("gameid");
                    int inventory = Integer.parseInt(getFromCart.getString("inventory"));
                    inventory = inventory - quantity;
                    DBW.setDataTo("UPDATE game SET inventory = '" + inventory + "' WHERE gameid='" + gameid + "'");

                    gameList += gamename + "<br>";

                }

                EmailSend emailSend = new EmailSend();
                emailSend._checkoutSend(email, tottalPrice, firstname, lastname, userid, orderid, gameList);

                DBW.setDataTo("DELETE FROM cart WHERE userid='" + userid + "'");

                rs.close();
                st.close();
                response.sendRedirect("../controller?cart");
                return;

            } catch (Exception e) {
                out.println(e);
            }

        } else {
            rs.close();
            st.close();
            session.invalidate();
            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Wrong credentials !!!</span></div>"
                    + "<meta http-equiv='Refresh' content='4;url=../login.jsp'>");
            return;
        }

    } else {
        rs.close();
        st.close();
        session.invalidate();
        /*  Spiner "working" and redirect */
        out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Wrong credentials !!!2</span></div>"
                + "<meta http-equiv='Refresh' content='4;url=../login.jsp'>");
        return;
    }

%>