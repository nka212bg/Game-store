<%@page import="controller.DBW"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<title>Search page</title>

<%@include file="includes/header.jsp" %>


<div id="container" >
    <%        /*
        RESULT CONTAINER
        CASE: SEARCH RESULT PAGE        
         */

        Statement st = DBW.getDbConnection().createStatement();

        if (request.getParameterMap().containsKey("search")) {
            ResultSet rs = (ResultSet) request.getAttribute("searchRequest");

            out.println("<h2 style='margin-left:30px; margin-top:-30px; margin-bottom: -10px'><b>Games</b></h2>");

            try {
                while (rs.next()) {

                    String gameid = rs.getString("gameid");
                    String gamename = rs.getString("gamename");
                    String console = rs.getString("console");
                    String num_players = rs.getString("num_players");
                    String coop = rs.getString("coop");
                    String genre = rs.getString("genre");
                    String release_date = rs.getString("release_date");
                    String developer = rs.getString("developer");
                    String publisher = rs.getString("publisher");
                    String front_box_art = rs.getString("front_box_art");
                    String price = rs.getString("price");
                    String quantity = rs.getString("inventory");
                    int quantityInt = Integer.parseInt(quantity);

                    out.println("<div class='w3-block' style='margin: 10px; font-size: 80%; background-color: #eee; '>");
                    out.println("   <div class='w3-third w3-margin-bottom w3-margin-top w3-container' style='width: 300px; height: 550px; '>  ");

                    //THE FRONT BOX PICTURE IS A LINK TO THE CONTROLLER WITH GET PARAMETER gameid AND THE VALUE OF THE ID OF THE GAME
                    out.print(" <a href='?gameid=");
                    out.print(gameid);
                    out.println("'><img src='");
                    out.print(front_box_art);
                    out.println("'alt='Missing image' style='width:100%; border: 1px solid #0000004d;border-radius: 7px;box-shadow: 0px 5px 35px #00000080;' class='w3-hover-opacity'></a>");
                    out.println("<div class='w3-container' style='padding-top: 15px'>");
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                    if (!session.getAttribute("rank").equals("Guest")) {

                        String wpcolorFav = "wp-light-grey";
                        String wpcolorCart = "wp-light-grey";

                        ResultSet rsAddToFavorites = st.executeQuery("select * from favorites where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");

                        if (rsAddToFavorites.next()) {
                            wpcolorFav = "w3-yellow";
                        }
//                        rsAddToFavorites.close();
//                        st.close();

                        ResultSet rsAddToCart = st.executeQuery("select * from cart where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");
                        String gameQuantity = "1";
                        String disabled = "";
                        if (rsAddToCart.next()) {
                            wpcolorCart = "w3-yellow";
                            gameQuantity = (String) rsAddToCart.getString("quantity");
                            disabled = "disabled";
                        }

                        out.println("<form class=' inliner' metod='GET' action='./model/addToFavorites.jsp'>");
                        out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                        out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                        out.print("<input type='hidden' name='search'/>");
                        out.println("<button  class='w3-button " + wpcolorFav + " w3-small' type='submit'><i class='fa fa-star' aria-hidden='true'></i></button>");
                        out.println("</form>");

                        if (quantityInt > 1) {

                            out.println("<form class=' inliner' metod='GET' action='./model/addToCart.jsp'>");
                            out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                            out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                            out.print("<input type='hidden' name='search'/>");
                            out.println("<button  class='w3-button " + wpcolorCart + " w3-small' type='submit'><i class='fa fa-shopping-cart' aria-hidden='true'></i></button>");
                            out.println("<input  class='w3-small gameinput' type='number' name='gameQuantity' min='1' max='9' value='" + gameQuantity + "'" + disabled + "></input>");
                            out.println("</form>");

                        }

                        if (session.getAttribute("rank").equals("Admin")) {
                            out.println("<a class='w3-button w3-red w3-small' href='editGame.jsp?gameid=" + gameid + "'><i class='fa fa-pencil' aria-hidden='true'></i></a>");
                            out.println("<span class='w3-light-grey w3-small' > Stock:" + quantity + "</span><br>");

                        }

                    }

                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    out.println("<p style='line-height: 200%'><b>");
                    out.print(gamename + "&nbsp;&nbsp;&nbsp;" + "<b style='background-color: #333; color: white; padding:5px 10px; border-radius:500px'>" + price + "$</b>");
                    out.println("</b></p>");
                    out.println("<p>Players#: ");
                    out.print(num_players);
                    out.println(" | Console: ");
                    out.print(console);
                    out.println(" | Genre: ");
                    out.print(genre);
                    out.println(" | Released: ");
                    out.print(release_date);
                    out.println(" | Developer: ");
                    out.print(developer);
                    out.println(" | Publisher: ");
                    out.print(publisher);
                    out.println(" | Coop: ");
                    out.print(coop);
                    out.println("</p>");
                    out.println("   </div>  ");
                    out.println("   </div>  ");
                    out.println("   </div>  ");

                }

            } catch (Exception e) {
                out.println("An exception occurred: " + e.getMessage());
            }

            rs.close();
            st.close();

        }

        /*
        RESULT CONTAINER
        CASE: SELECTED GAME / DETAIL PAGE
        DISPLAYS THE DETAILS OF THE SELECTED GAME
        
         */
        if (request.getParameterMap().containsKey("gameid")) {
            ResultSet rs = (ResultSet) request.getAttribute("searchRequest");
            try {
                while (rs.next()) {
                    String gameid = rs.getString("gameid");
                    String gamename = rs.getString("gamename");
                    String game_description = rs.getString("game_description");
                    String console = rs.getString("console");
                    String num_players = rs.getString("num_players");
                    String coop = rs.getString("coop");
                    String genre = rs.getString("genre");
                    String release_date = rs.getString("release_date");
                    String developer = rs.getString("developer");
                    String publisher = rs.getString("publisher");
                    String front_box_art = rs.getString("front_box_art");
                    String back_box_art = rs.getString("back_box_art");
                    String logo = rs.getString("logo");
                    String developer_logo = rs.getString("developer_logo");
                    String comments = rs.getString("comments");
                    String price = rs.getString("price");
                    String quantity = rs.getString("inventory");
                    int quantityInt = Integer.parseInt(quantity);

                    out.println("<h2 style='margin-left:55px; margin-top:-30px; margin-bottom: -30px'><b>");
                    out.print(gamename + "&nbsp;&nbsp;&nbsp;" + "<b style='background-color: #333; color: white; padding:5px 25px; border-radius:500px'>" + price + "$</b><br>");
                    out.println("</b></h2>");

                    out.println("<div class='infogrid w3-container br4' style='margin: 50px;max-width: 700px; font-size: 80%;'>");
                    out.println("<div class='w3-container w3-half padding10 w3-margin-bottom w3-margin-top' style='border-radius: 5px;box-shadow: 0px 5px 25px #00000080;'>");
                    out.println("<img src='");
                    out.print(front_box_art);
                    out.println("'style='width:100%;margin-bottom:3px ;padding:2px'>");
                    out.println("<div class='w3-third padding2'>");
                    out.println("<img src='");
                    out.print(back_box_art);
                    out.println("'style='width:100%'>");
                    out.println("</div>");
                    out.println("<div class='w3-third padding2'>");
                    out.println("<img src='");
                    out.print(logo);
                    out.println("'style='width:100%'>");
                    out.println("</div>");
                    out.println("<div class='w3-third padding2'>");
                    out.println("<img src='");
                    out.print(developer_logo);
                    out.println("'style='width:100%'>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("<div class='w3-container w3-half  w3-margin-bottom w3-margin-top'>");
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if (!session.getAttribute("rank").equals("Guest")) {

                        String wpcolorFav = "wp-light-grey";
                        String wpcolorCart = "wp-light-grey";

                        ResultSet rsAddToFavorites = st.executeQuery("select * from favorites where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");

                        if (rsAddToFavorites.next()) {
                            wpcolorFav = "w3-yellow";
                        }
//                        rsAddToFavorites.close();
//                        st.close();

                        ResultSet rsAddToCart = st.executeQuery("select * from cart where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");
                        String gameQuantity = "1";
                        String disabled = "";
                        if (rsAddToCart.next()) {
                            wpcolorCart = "w3-yellow";
                            gameQuantity = (String) rsAddToCart.getString("quantity");
                            disabled = "disabled";
                        }

                        out.println("<form class=' inliner' metod='GET' action='./model/addToFavorites.jsp'>");
                        out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                        out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                        out.println("<button  class='w3-button " + wpcolorFav + " w3-small' type='submit'><i class='fa fa-star' aria-hidden='true'></i></button>");
                        out.println("</form>");

                        if (quantityInt > 1) {

                            out.println("<form class=' inliner' metod='GET' action='./model/addToCart.jsp'>");
                            out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                            out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                            //  out.print("<input type='hidden' name='search'/>");
                            out.println("<button  class='w3-button " + wpcolorCart + " w3-small' type='submit'><i class='fa fa-shopping-cart' aria-hidden='true'></i></button>");
                            out.println("<input  class='w3-small gameinput' type='number' name='gameQuantity' min='1' max='9' value='" + gameQuantity + "'" + disabled + "></input>");
                            out.println("</form>");

//                            rsAddToCart.close();
//                            st.close();
                        }

                        if (session.getAttribute("rank").equals("Admin")) {
                            out.println("<a class='w3-button w3-red w3-small' href='editGame.jsp?gameid=" + gameid + "'><i class='fa fa-pencil' aria-hidden='true'></i></a>");
                            out.println("<span class='w3-light-grey w3-small' > Stock:" + quantity + "</span><br>");
                        }
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    out.println("<p>Players#: ");
                    out.print(num_players);
                    out.println(" | Console: ");
                    out.print(console);
                    out.println(" | Genre: ");
                    out.print(genre);
                    out.println(" | Released: ");
                    out.print(release_date);
                    out.println(" | Developer: ");
                    out.print(developer);
                    out.println(" | Publisher: ");
                    out.print(publisher);
                    out.println(" | Coop: ");
                    out.print(coop);
                    out.println("</p>");
                    out.print("<p><b>Game Description: </b>");
                    out.print(game_description);
                    out.println("</p>");
                    out.print("<p><b>Coments: </b>");
                    out.print(comments);
                    out.println("</p>");
                    out.println("<br><br><br>");
                    out.println("<a class='w3-button w3-small w3-red' href='?search=games'><i class='fa fa-chevron-left' aria-hidden='true'></i> Back</a>");
                    out.println("   </div>  ");
                    out.println("   </div>  ");
                    out.println("   </div>  ");

                }

            } catch (Exception e) {
                out.println("An exception occurred: " + e.getMessage());
            }

            rs.close();
            st.close();

        }

        /*
RESULT CONTAINER
CASE: SPECIAL PAGE 
DISPLAYS GAMES WHICH HAVE DISCOUNT

         */
        if (request.getParameterMap().containsKey("special")) {
            ResultSet rs = (ResultSet) request.getAttribute("searchRequest");

            out.println("<h2 style='margin-left:30px; margin-top:-30px; margin-bottom: -10px'><i class='fa fa-gift' aria-hidden='true'></i><b> Special offers</b></h2>");

            try {
                while (rs.next()) {

                    String gameid = rs.getString("gameid");
                    String gamename = rs.getString("gamename");
                    String console = rs.getString("console");
                    String num_players = rs.getString("num_players");
                    String coop = rs.getString("coop");
                    String genre = rs.getString("genre");
                    String release_date = rs.getString("release_date");
                    String developer = rs.getString("developer");
                    String publisher = rs.getString("publisher");
                    String front_box_art = rs.getString("front_box_art");
                    String price = rs.getString("price");
                    String quantity = rs.getString("inventory");
                    int quantityInt = Integer.parseInt(quantity);

                    out.println("<div class='w3-block' style='margin: 10px; font-size: 80%; background-color: #eee;'>");
                    out.println("   <div class='w3-third w3-margin-bottom w3-margin-top w3-container' style='width: 300px; height: 550px '>  ");
                    out.print(" <a href='?gameid=");
                    out.print(gameid);
                    out.println("'><img src='");
                    out.print(front_box_art);
                    out.println("'alt='Missing image' style='width:100%; border: 1px solid #0000004d;border-radius: 7px;box-shadow: 0px 5px 35px #00000080;' class='w3-hover-opacity'></a>");
                    out.println("<div class='w3-container' style='padding-top: 15px'>");
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    String wpcolorFav = "wp-light-grey";
                    String wpcolorCart = "wp-light-grey";

                    ResultSet rsAddToFavorites = st.executeQuery("select * from favorites where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");

                    if (rsAddToFavorites.next()) {
                        wpcolorFav = "w3-yellow";
                    }

                    ResultSet rsAddToCart = st.executeQuery("select * from cart where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");
                    String gameQuantity = "1";
                    String disabled = "";
                    if (rsAddToCart.next()) {
                        wpcolorCart = "w3-yellow";
                        gameQuantity = (String) rsAddToCart.getString("quantity");
                        disabled = "disabled";
                    }

                    out.println("<form class=' inliner' metod='GET' action='./model/addToFavorites.jsp'>");
                    out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                    out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                    out.print("<input type='hidden' name='special'/>");
                    out.println("<button  class='w3-button " + wpcolorFav + " w3-small' type='submit'><i class='fa fa-star' aria-hidden='true'></i></button>");
                    out.println("</form>");

                    if (quantityInt > 1) {

                        out.println("<form class=' inliner' metod='GET' action='./model/addToCart.jsp'>");
                        out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                        out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                        out.print("<input type='hidden' name='special'/>");
                        out.println("<button  class='w3-button " + wpcolorCart + " w3-small' type='submit'><i class='fa fa-shopping-cart' aria-hidden='true'></i></button>");
                        out.println("<input  class='w3-small gameinput' type='number' name='gameQuantity' min='1' max='9' value='" + gameQuantity + "'" + disabled + "></input>");
                        out.println("</form>");

                    }

                    if (session.getAttribute("rank").equals("Admin")) {
                        out.println("<a class='w3-button w3-red w3-small' href='editGame.jsp?gameid=" + gameid + "'><i class='fa fa-pencil' aria-hidden='true'></i></a>");
                        out.println("<span class='w3-light-grey w3-small' > Stock:" + quantity + "</span><br>");
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    out.println("<p style='line-height: 200%'><b>");
                    out.print(gamename + "&nbsp;&nbsp;&nbsp;" + "<b style='background-color: #333; color: white; padding:5px 10px; border-radius:500px'>" + price + "$</b>");
                    out.println("</b></p>");
                    out.println("<p>Players#: ");
                    out.print(num_players);
                    out.println(" | Console: ");
                    out.print(console);
                    out.println(" | Genre: ");
                    out.print(genre);
                    out.println(" | Released: ");
                    out.print(release_date);
                    out.println(" | Developer: ");
                    out.print(developer);
                    out.println(" | Publisher: ");
                    out.print(publisher);
                    out.println(" | Coop: ");
                    out.print(coop);
                    out.println("</p>");
                    out.println("   </div>  ");
                    out.println("   </div>  ");
                    out.println("   </div>  ");

                }

            } catch (Exception e) {
                out.println("An exception occurred: " + e.getMessage());
            }
            rs.close();
            st.close();
        }

        /*
RESULT CONTAINER
CASE: FAVORITE PAGE 
DISPLAYS GAMES ADDED IN TO A FAVORITES

         */
        if (request.getParameterMap().containsKey("favorites")) {
            ResultSet rs = (ResultSet) request.getAttribute("searchRequest");

            out.println("<h2 style='margin-left:30px; margin-top:-30px; margin-bottom: -10px'><i class='fa fa-star' aria-hidden='true'></i><b> Favorites</b></h2>");

            try {
                while (rs.next()) {

                    String gameid = rs.getString("gameid");
                    String gamename = rs.getString("gamename");
                    String console = rs.getString("console");
                    String num_players = rs.getString("num_players");
                    String coop = rs.getString("coop");
                    String genre = rs.getString("genre");
                    String release_date = rs.getString("release_date");
                    String developer = rs.getString("developer");
                    String publisher = rs.getString("publisher");
                    String front_box_art = rs.getString("front_box_art");
                    String price = rs.getString("price");
                    String quantity = rs.getString("inventory");
                    int quantityInt = Integer.parseInt(quantity);

                    out.println("<div class='w3-block' style='margin: 10px; font-size: 80%; background-color: #eee;'>");
                    out.println("   <div class='w3-third w3-margin-bottom w3-margin-top w3-container' style='width: 300px; height: 550px '>  ");
                    out.print(" <a href='?gameid=");
                    out.print(gameid);
                    out.println("'><img src='");
                    out.print(front_box_art);
                    out.println("'alt='Missing image' style='width:100%; border: 1px solid #0000004d;border-radius: 7px;box-shadow: 0px 5px 35px #00000080;' class='w3-hover-opacity'></a>");
                    out.println("<div class='w3-container' style='padding-top: 15px'>");
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    String wpcolorFav = "wp-light-grey";
                    String wpcolorCart = "wp-light-grey";

                    ResultSet rsAddToFavorites = st.executeQuery("select * from favorites where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");

                    if (rsAddToFavorites.next()) {
                        wpcolorFav = "w3-yellow";
                    }

                    ResultSet rsAddToCart = st.executeQuery("select * from cart where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");
                    String gameQuantity = "1";
                    String disabled = "";
                    if (rsAddToCart.next()) {
                        wpcolorCart = "w3-yellow";
                        gameQuantity = (String) rsAddToCart.getString("quantity");
                        disabled = "disabled";
                    }

                    out.println("<form class=' inliner' metod='GET' action='./model/addToFavorites.jsp'>");
                    out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                    out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                    out.print("<input type='hidden' name='favorites'/>");
                    out.println("<button  class='w3-button " + wpcolorFav + " w3-small' type='submit'><i class='fa fa-star' aria-hidden='true'></i></button>");
                    out.println("</form>");

                    if (quantityInt > 1) {

                        out.println("<form class=' inliner' metod='GET' action='./model/addToCart.jsp'>");
                        out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                        out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                        out.print("<input type='hidden' name='favorites'/>");
                        out.println("<button  class='w3-button " + wpcolorCart + " w3-small' type='submit'><i class='fa fa-shopping-cart' aria-hidden='true'></i></button>");
                        out.println("<input  class='w3-small gameinput' type='number' name='gameQuantity' min='1' max='9' value='" + gameQuantity + "'" + disabled + "></input>");
                        out.println("</form>");

                    }

                    if (session.getAttribute("rank").equals("Admin")) {
                        out.println("<a class='w3-button w3-red w3-small' href='editGame.jsp?gameid=" + gameid + "'><i class='fa fa-pencil' aria-hidden='true'></i></a>");
                        out.println("<span class='w3-light-grey w3-small' > Stock:" + quantity + "</span><br>");
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    out.println("<p style='line-height: 200%'><b>");
                    out.print(gamename + "&nbsp;&nbsp;&nbsp;" + "<b style='background-color: #333; color: white; padding:5px 10px; border-radius:500px'>" + price + "$</b>");
                    out.println("</b></p>");
                    out.println("<p>Players#: ");
                    out.print(num_players);
                    out.println(" | Console: ");
                    out.print(console);
                    out.println(" | Genre: ");
                    out.print(genre);
                    out.println(" | Released: ");
                    out.print(release_date);
                    out.println(" | Developer: ");
                    out.print(developer);
                    out.println(" | Publisher: ");
                    out.print(publisher);
                    out.println(" | Coop: ");
                    out.print(coop);
                    out.println("</p>");
                    out.println("   </div>  ");
                    out.println("   </div>  ");
                    out.println("   </div>  ");

                }

            } catch (Exception e) {
                out.println("An exception occurred: " + e.getMessage());
            }
            rs.close();
            st.close();
        }


        /*
RESULT CONTAINER
CASE: CART PAGE 
DISPLAYS GAMES ADDED IN TO A CART

         */
        String gameQuantity = "1";
        if (request.getParameterMap().containsKey("cart")) {
            ResultSet rs = (ResultSet) request.getAttribute("searchRequest");

            int tottalPrice = 0;

            try {
                while (rs.next()) {

                    String gameid = rs.getString("gameid");
                    String gamename = rs.getString("gamename");
                    String console = rs.getString("console");
                    String num_players = rs.getString("num_players");
                    String coop = rs.getString("coop");
                    String genre = rs.getString("genre");
                    String release_date = rs.getString("release_date");
                    String developer = rs.getString("developer");
                    String publisher = rs.getString("publisher");
                    String front_box_art = rs.getString("front_box_art");
                    String price = rs.getString("price");

                    String quantity = rs.getString("inventory");
                    int quantityInt = Integer.parseInt(quantity);

                    out.println("<div class='w3-block' style='margin: 10px; font-size: 80%; background-color: #eee;'>");
                    out.println("   <div class='w3-third w3-margin-bottom w3-margin-top w3-container' style='width: 300px; height: 550px '>  ");
                    out.print(" <a href='?gameid=");
                    out.print(gameid);
                    out.println("'><img src='");
                    out.print(front_box_art);
                    out.println("'alt='Missing image' style='width:100%; border: 1px solid #0000004d;border-radius: 7px;box-shadow: 0px 5px 35px #00000080;' class='w3-hover-opacity'></a>");
                    out.println("<div class='w3-container' style='padding-top: 15px'>");
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    String wpcolorFav = "wp-light-grey";
                    String wpcolorCart = "wp-light-grey";

                    ResultSet rsAddToFavorites = st.executeQuery("select * from favorites where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");

                    if (rsAddToFavorites.next()) {
                        wpcolorFav = "w3-yellow";
                    }

                    ResultSet rsAddToCart = st.executeQuery("select * from cart where userid = '" + session.getAttribute("userid") + "'and gameid = '" + gameid + "'");

                    String disabled = "";
                    if (rsAddToCart.next()) {
                        wpcolorCart = "w3-yellow";
                        gameQuantity = (String) rsAddToCart.getString("quantity");
                        disabled = "disabled";
                    }
                    int tottalPriceGame = Integer.parseInt(gameQuantity) * Integer.parseInt(price);

                    out.println("<form class=' inliner' metod='GET' action='./model/addToFavorites.jsp'>");
                    out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                    out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                    out.print("<input type='hidden' name='cart'/>");
                    out.println("<button  class='w3-button " + wpcolorFav + " w3-small' type='submit'><i class='fa fa-star' aria-hidden='true'></i></button>");
                    out.println("</form>");

                    out.println("<form class=' inliner' metod='GET' action='./model/addToCart.jsp'>");
                    out.print("<input  class='w3-input' type='hidden' name='gameid' required value='" + gameid + "'/>");
                    out.print("<input  class='w3-input' type='hidden' name='userid' required value='" + session.getAttribute("userid") + "'/>");
                    out.print("<input type='hidden' name='cart'/>");
                    out.println("<button  class='w3-button " + wpcolorCart + " w3-small' type='submit'><i class='fa fa-shopping-cart' aria-hidden='true'></i></button>");
                    out.println("<input  class='w3-small  gameinput' type='number' name='gameQuantity' min='1' max='9' value='" + gameQuantity + "'" + disabled + "></input>");
                    out.println("<span  class='w3-small' >Total $" + tottalPriceGame + "</span>");
                    out.println("</form>");

                    tottalPrice += tottalPriceGame;

                    if (session.getAttribute("rank").equals("Admin")) {
                        out.println("<a class='w3-button w3-red w3-small' href='editGame.jsp?gameid=" + gameid + "'><i class='fa fa-pencil' aria-hidden='true'></i></a>");
                        out.println("<span class='w3-light-grey w3-small' > Stock:" + quantity + "</span><br>");
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    out.println("<p style='line-height: 200%'><b>");
                    out.print(gamename + "&nbsp;&nbsp;&nbsp;" + "<b style='background-color: #333; color: white; padding:5px 10px; border-radius:500px'>" + price + "$</b>");
                    out.println("</b></p>");
                    out.println("<p>Players#: ");
                    out.print(num_players);
                    out.println(" | Console: ");
                    out.print(console);
                    out.println(" | Genre: ");
                    out.print(genre);
                    out.println(" | Released: ");
                    out.print(release_date);
                    out.println(" | Developer: ");
                    out.print(developer);
                    out.println(" | Publisher: ");
                    out.print(publisher);
                    out.println(" | Coop: ");
                    out.print(coop);
                    out.println("</p>");
                    out.println("   </div>  ");
                    out.println("   </div>  ");
                    out.println("   </div>  ");

                }

            } catch (Exception e) {
                out.println("An exception occurred: " + e.getMessage());
            }

            if (tottalPrice != 0) {
                out.println("<table style='margin-left:30px; position: absolute ; top: 110px; margin-top:-30px; margin-bottom: -10px'><tbody><tr>"
                        + "<td><h2><i class='fa fa-shopping-cart' aria-hidden='true'></i><b> Cart</b></h2></td>"
                        + "<td><h4>&nbsp;&nbsp;&nbsp;Total Price - " + tottalPrice + "$</h4></td>");

                out.println("<td><button onclick='checkout();' style='margin-left: 10px;' "
                        + "class='w3-button w3-blue w3-round'>Checkout</button></tr></tbody></table>");

            } else {
                out.println("<table style='margin-left:30px; position: absolute ; top: 110px; margin-top:-30px; margin-bottom: -10px'><tbody><tr>"
                        + "<td><h2><i class='fa fa-shopping-cart' aria-hidden='true'></i><b> Your cart is empty!</b></h2></td>"
                        + "</tr></tbody></table>");
            }


    %>

</div>


<!--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CONFIRM CREDENTIALS - EMAIL, PASSWORD, CREDIT CARD CVV-->

<div id="checkout">

    <div class="w3-center wd" style="margin-top: 150px">

        <div class="w3-card-2 round">
            <i onclick='closeCheckout();' class="fa fa-times fa-2x" aria-hidden="true" style="color: black; margin: 10px; float: right; cursor: pointer" ></i>
            <div class="w3-container"><h3><strong>Confirm your credentials</strong></h3></div>  
            <form method="POST" action="./model/checkout.jsp" class="w3-container w3-padding-24"><br>

                <input class="w3-input"  type="email" name="email" placeholder="your email" required/><br>
                <input class="w3-input"  type="password" name="password" placeholder="password" required/><br>
                <input class="w3-input"  type="text" name="cvv" placeholder="card verification - cvv" required/><br><br>
                <input type="hidden" name="tottalPrice" value="<%= tottalPrice%>"/>
                <input type="hidden" name="userid" value="<%= session.getAttribute("userid")%>"/>


                <label class="w3-left w3-text-blue w3-margin-bottom" style="padding-left: 8px; color: #bbb"><h2><b>Your order is <%= tottalPrice%>$</b></h2></label> <br><br><br><br><br>
                <button class="w3-button w3-blue w3-round" type="submit" name="action">Checkout</button>
            </form>
        </div> 
    </div>
</div>


<%

        rs.close();
        st.close();

    }
%>

<%@include file="includes/footer.jsp" %>





