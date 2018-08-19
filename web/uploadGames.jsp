<%
    if (session.getAttribute("email") == null || session.getAttribute("email").equals("")) {
        response.sendRedirect("controller?login");
        return;
    } else if (!session.getAttribute("rank").equals("Admin")) {
        response.sendRedirect("./model/logout.jsp");
        return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>
        <title>Upload game</title>

        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
        <link href="script/myCss.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>


        <div class="w3-center wd"> 

            <p>If you want admin rights, please write me at nka212bg@gmail.com</p>  
            <div class="w3-card-2 round">
                <div class="w3-container">
                    <h2><strong>Upload game</strong></h2>
                </div>  
                <form method="POST" action="./model/gameInput.jsp" class="w3-container w3-padding-24">
                    <div>
                        <input  class="w3-input" type="text" name="gamename" placeholder="Game name" required/><br>
                        <textarea class="w3-input" rows="4" cols="50" name="game_description" placeholder="Game description" required></textarea><br>
                        <textarea class="w3-input" rows="4" cols="50" name="comments" placeholder="Comments" ></textarea><br>
                        <input type="text"  class="w3-input"  name="price" placeholder="Price"/><br>

                        <select required class="w3-input"  name="console" id="console">
                            <option  disabled selected hidden>Select console</option>
                            <option>Xbox</option>
                            <option>Xbox 360</option>
                            <option>PS1</option>
                            <option>PS2</option>
                            <option>PS3</option>
                            <option>PS4</option>
                            <option>PC</option>
                            <option>Nintendo</option>
                        </select><br>
                        <select required class="w3-input" name="num_players" id="num_players">
                            <option  disabled selected hidden>Players N</option>
                            <option value="1">1 Player</option>
                            <option value="2">2 Players</option>
                            <option value="3">3 Players</option>
                            <option value="4">4 Players</option>
                        </select><br>

                        <select required class="w3-input" name="genre" id="genre">
                            <option  disabled selected hidden>Genre</option>
                            <option>Action</option>
                            <option>Adventure</option>
                            <option>Role-playing</option>
                            <option>Simulation</option>
                            <option>Strategy</option>
                            <option>Sports</option>
                        </select><br>


                        Co-op &nbsp;&nbsp;&nbsp;<input type="radio" name="coop" value="Yes" checked> Yes &nbsp;&nbsp;&nbsp;
                        <input type="radio" name="coop" value="No"> No<br><br>


                        <input  class="w3-input" type="text" name="release_date" placeholder="Release date" required/><br>
                        <input  class="w3-input" type="text" name="developer" placeholder="Developer" required/><br>
                        <input  class="w3-input" type="text" name="publisher" placeholder="Publisher" required/><br>
                        <input  class="w3-input" type="text" name="front_box_art" placeholder="URL://...Front box art" required/><br>
                        <input  class="w3-input" type="text" name="back_box_art" placeholder="URL://...Back box art" required/><br>
                        <input  class="w3-input" type="text" name="logo" placeholder="URL://...Logo" required/><br>
                        <input  class="w3-input" type="text" name="developer_logo" placeholder="URL://...Developer logo" required/><br>

                        <input  class="w3-input" type="number" name="inventory"  min='1' max='100' placeholder="Quantity" required/><br>

                        <input type="radio" name="special" value="0" checked> Regular offer &nbsp;&nbsp;&nbsp;
                        <input type="radio" name="special" value="1"> Special offer<br><br><br>


                    </div>




                    <input  class="w3-button  w3-blue w3-round"   type="submit" value="Upload" name="action"/>
                    &nbsp;&nbsp;<a class="defLink"  href="${pageContext.request.contextPath}/controller?home">Home</a>
                </form>


            </div>
        </div>



        <%@include file="includes/footer.jsp" %>



