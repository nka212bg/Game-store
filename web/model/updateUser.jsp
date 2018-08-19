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
    String email = request.getParameter("email");
    String firstname = request.getParameter("firstName");
    String lastname = request.getParameter("lastName");
    String password = request.getParameter("newPassword");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String zip = request.getParameter("zip");
    String country = request.getParameter("country");
    String credit_card_type = request.getParameter("ccType");
    String credit_card_number = request.getParameter("ccNumber");
    String credit_card_cvv = request.getParameter("ccCVV");
    String credit_card_expiry = request.getParameter("ccExpiry");
    String rank = request.getParameter("rank");

    if (request.getParameter("oldPassword").equals(request.getParameter("oldPasswordComf"))) {

        try {

            /*
                CREATES THE QUERY THAT IS SENT TO THE DATABASE
             */
            DBW.setDataTo("UPDATE user SET firstname = '" + firstname + "', lastname = '" + lastname + "',"
                    + " password = '" + password + "', address1 = '" + address1 + "', address2 = '" + address2 + "', "
                    + "city = '" + city + "', state = '" + state + "', zip = '" + zip + "', country = '" + country + "', "
                    + "credit_card_type = '" + credit_card_type + "', credit_card_number = '" + credit_card_number + "' , "
                    + "credit_card_cvv = '" + credit_card_cvv + "' , credit_card_expiry = '" + credit_card_expiry + "', "
                    + "rank = '" + rank + "' WHERE email='" + email + "'");

            /*
            WRITE IN TO THE LOG
             */
            String userid = (String) session.getAttribute("userid");
            LogWriter logWriter = new LogWriter();
            String action = "Edit user with email: " + email;
            logWriter._logWriter(userid, action);

            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Working ...</span></div>"
                    + "<meta http-equiv='Refresh' content='1;url=../controller?search=games'>");
            return;

        } catch (Exception e) {
            out.println(e);
        }

    } else {

        /*  Spiner "working" and redirect */
        out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: lightgray'>The confirmation password is wrong !!!</span></div>"
                + "<script>setTimeout(function(){history.back();}, 4000);</script>");

    }

%>