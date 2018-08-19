<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>

        <!-- PAGE TITLE -->
        <title>Reset Password</title>

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
                <div class="w3-container">
                    <h2><strong>Forgot password</strong></h2>
                </div>  

                <!-- The validation is managed by loginCheck.jsp with parameter email and password-->
                <!-- email and password are required fields-->
                <!-- The method is POST since sensitive information (passwords) are sent with POST (hidden)-->

                <form method="POST" action="./model/passReset.jsp" class="w3-container w3-padding-24">
                    <br>


                    <!-- Email and Password fields -->
                    <input class="w3-input"  type="email" name="email" placeholder="your email" required/><br>
                    <div class="padding10"></div>


                    <!-- Login Button -->
                    <button class="w3-button  w3-blue w3-round" type="submit" value="reset" name="action">Send new password</button>


                    <!-- Register Button -->
                    <!-- The registration is managed by the CONTROLLER -->

                    &nbsp;&nbsp;<a class="defLink" href="${pageContext.request.contextPath}/controller?login">LogIn</a>

                </form>
            </div>  

        </div>

        <!-- FOOTER -->
        <%@include file="includes/footer.jsp" %> 

