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
    GENERATES THE CURRENT DATE AND TIME THAT WILL BE SENT TO THE DATABASE
     */
    Date registeredOn = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("dd.MM.yyyy '-' hh:mm:ss zzz");

    /*
    GETS THE VALUES OF THE PARAMETERS OF THE REQUEST
     */
    String email = request.getParameter("email");
    String firstname = request.getParameter("firstName");
    String lastname = request.getParameter("lastName");
    String password = request.getParameter("password");
    String passwordConfirm = request.getParameter("passwordConfirm");
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

    Statement st = DBW.getDbConnection().createStatement();
    ResultSet rs = st.executeQuery("select * from user where email='" + email + "'");

    /*
    IF THE EMAIL DOESN'T EXIST
     */
    if (!rs.next()) {

        /*
        CHECKS PASSWORDS
         */
        if (password.equals(passwordConfirm)) {
            try {

                DBW.setDataTo("INSERT INTO user (`firstname`, `lastname`, `email`, `password`, `address1`, `address2`,"
                        + " `city`, `state`, `zip`, `country`, `credit_card_type`, `credit_card_number`, `credit_card_cvv`,"
                        + " `credit_card_expiry`, `registeredOn`) VALUES ('" + firstname + "', '" + lastname + "', '" + email + "', "
                        + "'" + password + "', '" + address1 + "', '" + address2 + "', '" + city + "', '" + state + "', '" + zip + "',"
                        + " '" + country + "', '" + credit_card_type + "', '" + credit_card_number + "', '" + credit_card_cvv + "', "
                        + "'" + credit_card_expiry + "', '" + ft.format(registeredOn) + "');");

                String userid = "new_users";
                LogWriter logWriter = new LogWriter();
                String action = "New registered user  <name: " + firstname + " " + lastname + "> <email: " + email + "> <address: " + address1 + ">";
                logWriter._logWriter(userid, action);

                /*  Spiner "working" and redirect */
                out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Working ...</span></div>"
                        + "<meta http-equiv='Refresh' content='1;url=../index.jsp'>");
                return;

            } catch (Exception e) {
                out.println(e);
            }
        } else {

            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Wrong request to the server !!!</span></div>"
                    + "<meta http-equiv='Refresh' content='4;url=../register.jsp'>");
            return;

        }
    } else {

        /*  Spiner "working" and redirect */
        out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>The email already exist !!!</span></div>"
                + "<meta http-equiv='Refresh' content='4;url=../register.jsp'>");
        return;

    }
    rs.close();
    st.close();

%>