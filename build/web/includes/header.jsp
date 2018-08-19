<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head> 


        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />


        <!-- CSS -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="script/myCss.css" rel="stylesheet" type="text/css"/>
    </head> 
    <body>

        <div id="nav" style="margin-bottom: 100px">

            <a class="w3-button w3-small w3-round inliner" href='./controller?home'><i class='fa fa-search' aria-hidden='true'></i> Search</a>

            <%

                if (session.getAttribute("rank") == null || session.getAttribute("rank").equals("")) {
                    session.setAttribute("rank", "Guest");
                    session.setAttribute("firstname", "");
                    session.setAttribute("lastname", "");
                    response.sendRedirect("controller?search");
                    return;

                } else {

                    if (session.getAttribute("rank").equals("Admin")) {
                        out.println(" <a href='editUser.jsp' target='_blank' class='w3-button w3-small w3-round inliner'><i class='fa fa-user' aria-hidden='true'></i> Edit user</a>");
                        out.println(" <a href='uploadGames.jsp' target='_blank' class='w3-button w3-small w3-round inliner'><i class='fa fa-plus' aria-hidden='true'></i> Upload game</a>");
                        out.println(" <a href='showLogs.jsp' target='_blank' class='w3-button w3-small w3-round inliner'><i class='fa fa-address-book' aria-hidden='true'></i> Logs</a>");
                    }
                    if (session.getAttribute("rank").equals("Customer")) {
                        out.println(" <a href='#' onclick='logCheck();' class='w3-button w3-small w3-round inliner'><i class='fa fa-user' aria-hidden='true'></i> Edit my profile</a>");
                    }

                    if (!request.getParameterMap().containsKey("special") && !session.getAttribute("rank").equals("Guest")) {
                        out.println("<a href='controller?special'class='w3-button w3-blue w3-small w3-round inliner'><i class='fa fa-gift' aria-hidden='true'></i> Special offers</a>");
                    }

                    if (!request.getParameterMap().containsKey("favorites") && !session.getAttribute("rank").equals("Guest")) {
                        out.println("<a href='controller?favorites'class='w3-button w3-blue w3-small w3-round inliner'><i class='fa fa-star' aria-hidden='true'></i> Favorites</a>");
                    }

                    if (!request.getParameterMap().containsKey("cart") && !session.getAttribute("rank").equals("Guest")) {
                        out.println("<a href='controller?cart' class='w3-button w3-blue w3-small w3-round inliner'><i class='fa fa-shopping-cart' aria-hidden='true'></i> Cart</a>");
                    }
                }

                if (session.getAttribute("rank").equals("Guest")) {
            %><a href="./login.jsp" class="w3-button  w3-small w3-round inliner"><i class="fa fa-sign-in" aria-hidden="true"></i> LogIn</a><%
            } else {
            %><a href="./model/logout.jsp" class="w3-button  w3-small w3-round inliner"><i class="fa fa-sign-out" aria-hidden="true"></i> LogOut</a><%
                }

            %> 


            <div class="w3-small inliner" style="margin-left: 10px; line-height: 130%; vertical-align: middle;">
                    <b><i class="fa fa-user" aria-hidden="true"></i> <% String rank = (String) session.getAttribute("rank");
                    out.print(rank);%></b> <br>
                    <% String firstname = (String) session.getAttribute("firstname");
                        out.print(firstname);%> <% String lastname = (String) session.getAttribute("lastname");
                        out.print(lastname);%> 

            </div>   


        </div>

        <div id="logCheck">

            <div class="w3-center wd" style="margin-top: 150px">


                <div class="w3-center wd">

                    <div class="w3-card-2 round">
                        <i onclick='closelogCheck();' class="fa fa-times fa-2x" aria-hidden="true" style="color: black; margin: 10px; float: right; cursor: pointer" ></i>
                        <div class="w3-container"><h3><strong>Confirm your credentials</strong></h3></div>  
                        <form method="POST" action="./model/loginCheck.jsp" class="w3-container w3-padding-24"><br>
                            <input class="w3-input"  type="email" name="email" placeholder="your email" required/><br>
                            <input class="w3-input"  type="password" name="password" placeholder="password" required/><br><br>
                            <input type="hidden" name="logCheck"/>
                            <button class="w3-button w3-blue w3-round" type="submit" name="action">Continue</button>
                        </form>
                    </div> 
                </div>
            </div>
            <div style="height: 80px"></div> 


            <script>
                function logCheck() {
                    document.getElementById("logCheck").style.display = "block";
                }
                function closelogCheck() {
                    document.getElementById("logCheck").style.display = "none";
                }

            </script>
        </div>












