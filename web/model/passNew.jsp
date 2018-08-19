<%@page import="controller.DBW"%>
<%@page import="model.LogWriter"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%


    /*
    GETS THE VALUES OF THE PARAMETERS
     */
    String email = request.getParameter("email");
    String key = request.getParameter("key");
    String password = request.getParameter("password");

    try {

        Statement st = DBW.getDbConnection().createStatement();
        ResultSet rs = st.executeQuery("select * from user where email='" + email + "'");

        if (rs.next()) {

            String pass = rs.getString("password");
            String userid = rs.getString("userid");
            String substr = pass.substring(pass.length() - 13);
            //  takes the date-time from the key to compare it with the current date-time
            long keyDate = Long.parseLong(substr) + 300000; // 86400000 - 24h in miliseconds  
            long unixTime = System.currentTimeMillis(); //current date-time    (unixTime < keyDate) && (pass.equals(key)

            if ((unixTime < keyDate) && (pass.equals(key))) {

                //Write a new password in the DB 
                //Automatically unblock the user
                DBW.setDataTo("UPDATE user SET password = '" + password + "', rank = '" + "Customer" + "' WHERE email='" + email + "'");

                /*
                 WRITE IN TO THE LOG
                 */
                //String userid = (String) session.getAttribute("userid");
                LogWriter logWriter = new LogWriter();
                String action = "<b style='color :red'>New password: " + password + "</b>";
                logWriter._logWriter(userid, action);

                /*
                         ALERT AND REDIRECTS TO LOGIN
                 */
                session.invalidate();
                /*  Spiner "working" and redirect */
                out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Now you can LogIn with your new password ...</span></div>"
                        + "<meta http-equiv='Refresh' content='4;url=../login.jsp'>");
                return;

            } else {
                rs.close();
                st.close();

                /*  Spiner "working" and redirect */
                out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>The email or the reset key are invalid, Or maybe the reset key has expired ...</span></div>"
                        + "<meta http-equiv='Refresh' content='4;url=../passwordNew.jsp'>");
                return;
            }

        } else {
            rs.close();
            st.close();

            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>There is no user with this email !!!</span></div>"
                    + "<meta http-equiv='Refresh' content='4;url=../passwordNew.jsp'>");
            return;

        }

    } catch (Exception e) {

        /*  Spiner "working" and redirect */
        out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>The email or the reset key are invalid-2 !!!</span></div>"
                + "<meta http-equiv='Refresh' content='4;url=../passwordNew.jsp'>");
        return;

    }


%>