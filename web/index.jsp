<%@page import="controller.DBW"%>
<%@page import="java.sql.*"%>

<!--If there is no session - the login.jsp page is loaded.--> 


<title>Home page</title>


<!-- INCLUDES THE HEADER -->
<%@include file="includes/header.jsp" %>



<div class="w3-center wd">

    <div class="w3-card-2 round">
        <div class="w3-container">



            <!-- BEGINNING OF THE FORM -->

            <h2><strong>Search for game</strong></h2>
        </div>  




        <!-- GET METHOD THAT REDIRECTS TO CONTROLLER WITH PARAMETER SEARCH TAKEN FROM THE SEARCH BUTTON -->
        <form method="GET" action="controller" class="w3-container w3-padding-24">
            <div> 



                <!-- SELECT OPTION "SELECT GAME" WHICH TAKES FROM THE DATABASE ALL GAME NAMES -->

                <select  class="w3-input"   name="gamename" id="gamename" >
                    <option  disabled selected hidden>Game name</option>

                    <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->

                    <% Statement st = DBW.getDbConnection().createStatement();
                        ResultSet rs = st.executeQuery("select * from game");

                        try {

                            while (rs.next()) {%> 
                    <option><%=rs.getString("gamename")%> </option>
                    <% }
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                        rs.close();
                    %>
                </select><br>




                <!-- SELECT OPTION FOR GAME CONSOLE-->

                <select  class="w3-input"  name="console" id="console">
                    <option  disabled selected hidden>Console</option>
                    <option>Xbox</option>
                    <option>Xbox 360</option>
                    <option>PS1</option>
                    <option>PS2</option>
                    <option>PS3</option>
                    <option>PS4</option>
                    <option>PC</option>
                    <option>Nintendo</option>
                </select><br>







                <!-- SELECT OPTION FOR NUMBER OF PLAYERS -->
                <select  class="w3-input" name="num_players" id="num_players">
                    <option  disabled selected hidden>Number of players</option>
                    <option value="1">1 Player</option>
                    <option value="2">2 Players</option>
                    <option value="3">3 Players</option>
                    <option value="4">4 Players</option>
                </select><br>






                <!-- SELECT OPTION FOR GENRE-->
                <select  class="w3-input" name="genre" id="genre">
                    <option  disabled selected hidden>Genre</option>
                    <option>Action</option>
                    <option>Adventure</option>
                    <option>Role-playing</option>
                    <option>Simulation</option>
                    <option>Strategy</option>
                    <option>Sports</option>
                </select><br>





                <!-- SELECT OPTION FOR PUBLISHER-->
                <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->
                <select  class="w3-input"  name="publisher" id="publisher" >
                    <option  disabled selected hidden>Publisher</option>

                    <% rs = st.executeQuery("select * from game");

                        try {

                            while (rs.next()) {%> 
                    <option><%=rs.getString("publisher")%> </option>
                    <% }
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                        rs.close();
                        st.close();
                    %>
                </select><br>

                <!-- SELECT OPTION FOR PRICE-->
                <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE PRICE OPTION -->
                <input type="text" class="w3-input inliner"  name="priceFrom" id="priceFrom" placeholder="Price from" style="width:175px;" >
                <input type="text" class="w3-input inliner"  name="priceTo" id="priceTo" placeholder="Price to" style="width:175px;" >  



                <br><br>

            </div>


            <br>
            <!-- SEARCH BUTTON -->
            <button  class="w3-button w3-block w3-blue w3-round" name="search" value="games">SEARCH</button>
            <br>
            <!-- REDIRECTS TO THE CONTROLLER WITH PARAMETER ALL-->
            <a href='controller?search'  class="w3-button w3-block w3-round"> Show all games</a><br>

        </form>

    </div>
</div>

<!-- FOOTER -->
<%@include file="includes/footer.jsp" %>





