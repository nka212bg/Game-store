<%@page import="controller.DBW"%>
<%if (session.getAttribute("email") == null || session.getAttribute("email").equals("")) {
        response.sendRedirect("controller?login");
        return;
    } else if (!session.getAttribute("rank").equals("Admin")) {
        response.sendRedirect("./model/logout.jsp");
        return;
    }%>

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
        <title>Edit game</title>

        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />

        <!-- HEADER -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
        <link href="script/myCss.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>


        <div class="w3-center wd">

            <p>If you want admin rights, please write me at nka212bg@gmail.com</p>  
            <div class="w3-card-2 round">


                <!-- FORM -->

                <div class="w3-container">
                    <h2><strong>Edit game</strong></h2>
                </div>  



                <form method="POST" action="./model/updateGame.jsp" class="w3-container w3-padding-24">

                    <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->

                    <%
                        String gameid = request.getParameter("gameid");

                        Statement st = DBW.getDbConnection().createStatement();
                        ResultSet rs = st.executeQuery("select * from game  where gameid='" + gameid + "'");

                        try {

                            while (rs.next()) {%> 

                    <div>
                        <p class="w3-small w3-left w3-light-grey w3-padding-large" style="margin-left: 3px">Name: <%=rs.getString("gamename")%></p><br>
                        <input  class="w3-input" type="hidden" name="gameid" required value="<%=rs.getString("gameid")%>"/>
                        <input  class="w3-input" type="hidden" name="gamename" required value="<%=rs.getString("gamename")%>"/>

                        <textarea class="w3-input" rows="4" cols="50" name="game_description" placeholder="Game description" required><%=rs.getString("game_description")%></textarea>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Game description</label> 
                        <textarea class="w3-input" rows="4" cols="50" name="comments" placeholder="Comments" ><%=rs.getString("comments")%></textarea>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Comments</label> 
                        <input type="text"  class="w3-input"  name="price" placeholder="Price" value="<%=rs.getString("price")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Price</label> 

                        <select required class="w3-input"  name="console" id="console">
                            <option selected><%=rs.getString("console")%></option>
                            <option>Xbox</option>
                            <option>Xbox 360</option>
                            <option>PS1</option>
                            <option>PS2</option>
                            <option>PS3</option>
                            <option>PS4</option>
                            <option>PC</option>
                            <option>Nintendo</option>
                        </select>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Console</label> 
                        <select required class="w3-input" name="num_players" id="num_players">
                            <option selected><%=rs.getString("num_players")%></option>
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Number of players</label> 

                        <select required class="w3-input" name="genre" id="genre">
                            <option selected><%=rs.getString("genre")%></option>
                            <option>Action</option>
                            <option>Adventure</option>
                            <option>Role-playing</option>
                            <option>Simulation</option>
                            <option>Strategy</option>
                            <option>Sports</option>
                        </select>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Genre</label> <br><br>


                        Co-op &nbsp;&nbsp;&nbsp;<input type="radio" name="coop" value="Yes" checked> Yes &nbsp;&nbsp;&nbsp;
                        <input type="radio" name="coop" value="No"> No<br><br>


                        <input  class="w3-input" type="text" name="release_date" placeholder="Release date" required value="<%=rs.getString("release_date")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Release date</label> 
                        <input  class="w3-input" type="text" name="developer" placeholder="Developer" required value="<%=rs.getString("developer")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Developer</label> 
                        <input  class="w3-input" type="text" name="publisher" placeholder="Publisher" required value="<%=rs.getString("publisher")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Publisher</label> 
                        <input  class="w3-input" type="text" name="front_box_art" placeholder="URL://...Front box art" required value="<%=rs.getString("front_box_art")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Front box art</label> 
                        <input  class="w3-input" type="text" name="back_box_art" placeholder="URL://...Back box art" required value="<%=rs.getString("back_box_art")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Back box art</label> 
                        <input  class="w3-input" type="text" name="logo" placeholder="URL://...Logo" required value="<%=rs.getString("logo")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Logo</label> 
                        <input  class="w3-input" type="text" name="developer_logo" placeholder="URL://...Developer logo" required value="<%=rs.getString("developer_logo")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Developer logo</label> 

                        <input  class="w3-input" type="number" name="inventory" placeholder="Quantity"  min='1' max='100' required value="<%=rs.getString("inventory")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Quantity</label> <br><br>


                        <input type="radio" name="special" value="0" checked> Regular offer &nbsp;&nbsp;&nbsp;
                        <input type="radio" name="special" value="1"> Special offer<br><br><br>
                    </div>

                    <% }
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }

                        rs.close();
                        st.close();
                    %>

                    <input  class="w3-button  w3-blue w3-round"   type="submit" value="Update" id="submit" name="action"/>

                    <!-- LOGIN BUTTON REDIRECTS TO THE CONTROLLER -->
                    &nbsp;&nbsp;<a class="defLink"  href="${pageContext.request.contextPath}/">Home</a>
                </form>


            </div>
        </div>


        <!--FOOTER-->
        <%@include file="includes/footer.jsp" %>



