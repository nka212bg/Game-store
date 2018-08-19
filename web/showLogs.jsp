<%@page import="controller.DBW"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="model.LogWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>

        <!-- PAGE TITLE -->
        <title>User logs</title>

        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" /> 

        <!-- HEADER -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
        <link href="script/myCss.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <%
            if (!session.getAttribute("rank").equals("Admin")) {
                response.sendRedirect("controller?login");
                return;
            }

        %> 

        <div class="w3-center wd" style="width: 700px;">

            <p>If you want admin rights, please write me at nka212bg@gmail.com</p>  
            <div class="w3-card-2 round" >


                <!-- FORM -->

                <div class="w3-container">
                    <h2><strong>User logs</strong></h2>
                </div>  
                <form class="w3-container w3-margin-top" method="GET" action="" >
                    <select  class="w3-input" name="userid">
                        <option  disabled selected hidden>Select user</option>

                        <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->

                        <%  Statement st = DBW.getDbConnection().createStatement();
                            ResultSet rs = st.executeQuery("select * from user");

                            try {
                                while (rs.next()) {%> 
                        <option value="<%=rs.getString("userid")%>"><%=rs.getString("firstname") + " " + rs.getString("lastname")%></option>

                        <% }
                            } catch (Exception e) {
                                out.println(e.getMessage());
                            }

                            rs.close();
                            st.close();
                        %>
                    </select><br><br>
                    <button class="w3-button  w3-blue w3-round"   type="submit"  name="select" >Select user</button>&nbsp;&nbsp;&nbsp;<a class="w3-button  w3-light-grey w3-round"  href="${pageContext.request.contextPath}/">back to home</a><br><br><br>
                </form>


                <div style="text-align: left; margin-left: 50px; font-size: 80%">
                    <%
                        String userid = request.getParameter("userid");
                        LogWriter logReader = new LogWriter();
                        out.println(logReader._logReader(userid));
                    %>
                </div>

                <br><br><br></div>

        </div>


        <!--FOOTER-->
        <%@include file="includes/footer.jsp" %>



