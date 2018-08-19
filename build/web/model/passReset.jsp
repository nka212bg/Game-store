<%@page import="controller.DBW"%>
<%@page import="model.LogWriter"%>
<%@page import="model.EmailSend"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%

    /*
        GETS THE VALUES OF PARAMETERS email AND password
     */
//    String email = request.getParameter("email");
    String email = (String) session.getAttribute("email");

    try {

        Statement st = DBW.getDbConnection().createStatement();
        ResultSet rs = st.executeQuery("select * from user where email='" + email + "'");

        if (rs.next()) {

            /*
                 GENERATE AN ACCESS KEY
             */
            long unixTime = System.currentTimeMillis(); // date string
            String key = UUID.randomUUID().toString() + "-" + unixTime;; // id key

            try {

                DBW.setDataTo("UPDATE user SET password = '" + key + "' WHERE email='" + email + "'");

                //Send an email to ""email"" with ""key"" to the client with the new access key //////////////////////////////////////////
                EmailSend emailSend = new EmailSend();
                emailSend._keySend(email, key);

                /*
            WRITE IN TO THE LOG
                 */
                String userid = rs.getString("userid");
                LogWriter logWriter = new LogWriter();
                String action = "<b style='color :red'>Password reset, sequrity key:<br>" + key + "</b>";
                logWriter._logWriter(userid, action);

            } catch (Exception e) {
                out.println(e);
            }

            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Check your email for a temporary password ...</span></div>"
                    + "<meta http-equiv='Refresh' content='4;url=../passwordNew.jsp'>");
            return;

        } else {

//            /*  Spiner "working" and redirect */
//            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>There is no user with this email !!!</span></div>"
//                    + "<script>setTimeout(function(){history.back();}, 3000);</script>");

            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Something's wrong !!!</span></div>"
                    + "<meta http-equiv='Refresh' content='4;url=../login.jsp'>");
            return;

        }

    } catch (Exception e) {
        out.println(e);
    }


%>