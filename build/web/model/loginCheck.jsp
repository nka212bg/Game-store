<%@page import="controller.DBW"%>
<%@page import="model.LogWriter"%>
<%@page import="java.sql.*"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%

    /*
        GETS THE VALUES OF PARAMETERS email AND password
     */
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {

        Statement st = DBW.getDbConnection().createStatement();
        ResultSet rs = st.executeQuery("select * from user  where email='" + email + "'and password='" + password + "'");

        if (rs.next()) {

            /*
                CREATES SESSION VARIABLES
             */
            String rank = rs.getString("rank");
            String userid = rs.getString("userid");
            String firstname = rs.getString("firstname");
            String lastname = rs.getString("lastname");

            /*
                CREATES SESSION WITH PARAMETER email
             */
            session.setAttribute("email", email);
            session.setAttribute("rank", rank);
            session.setAttribute("userid", userid);
            session.setAttribute("firstname", firstname);
            session.setAttribute("lastname", lastname);

            DBW.setDataTo("UPDATE user SET counter = '" + 0 + "' WHERE email='" + email + "'");
            LogWriter logWriter = new LogWriter();
            String action = "Login Access";
            logWriter._logWriter(userid, action);

            if (request.getParameterMap().containsKey("logCheck")) {
                action = "Edit User Access";
                logWriter._logWriter(userid, action);
                response.sendRedirect("../editUser.jsp");
                return;
            }

            if (rank.equals("Block")) {
                action = "User access block";
                logWriter._logWriter(userid, action);
                session.invalidate();
                /*  Spiner "working" and redirect */
                out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>This user is blocked !!!</span></div>"
                        + "<meta http-equiv='Refresh' content='4;url=../login.jsp'>");
                return;

            } else {
                response.sendRedirect("../controller?search");
                return;
            }

        } else {
            ResultSet rs2 = st.executeQuery("select * from user  where email='" + email + "'");
            if (rs2.next()) {
                int count = rs2.getInt("counter");
                if (count < 2) {
                    count++;
                    DBW.setDataTo("UPDATE user SET counter = '" + count + "' WHERE email='" + email + "'");

                    session.invalidate();
                    /*  Spiner "working" and redirect */
                    out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Try again !!!</span></div>"
                            + "<meta http-equiv='Refresh' content='2;url=../login.jsp'>");
                    return;

                } else {
                    session.setAttribute("email", email);
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //BLOCK THE USER AND RESET THE COUNTER TO 0
                    DBW.setDataTo("UPDATE user SET counter = '" + 0 + "', rank = '" + "Block" + "' WHERE email='" + email + "'");
                    /*  Spiner "working" and redirect */
                    out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>We are reseting the password of ");
                    out.print(email);
                    out.print(" !!!</span></div><meta http-equiv='Refresh' content='4;url=./passReset.jsp'>");
                    return;
                }
            }
            /*  Spiner "working" and redirect */
            out.print("<div style='margin: 40px'><img src='../img/spiner.svg' style='width: 40px'/> <span style='color: gray'>Something's wrong !!!</span></div>"
                    + "<meta http-equiv='Refresh' content='4;url=../login.jsp'>");
            return;

        }

    } catch (Exception e) {
        out.println(e);

    }


%>