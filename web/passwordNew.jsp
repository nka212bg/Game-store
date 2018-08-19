<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

            <p style="color: red">Check your email for a temporary reset key.</p>   
            <div class="w3-card-4 round">
                <div class="w3-container w3-light-grey">
                    <h2><strong>Reset password</strong></h2>
                </div>  
                <%


                %>
                <!-- The validation is managed by loginCheck.jsp with parameter email and password-->
                <!-- email and password are required fields-->
                <!-- The method is POST since sensitive information (passwords) are sent with POST (hidden)-->

                <form method="POST" action="./model/passNew.jsp" class="w3-container w3-padding-24"> <br>


                    <!-- Email and Password fields -->
                    <input class="w3-input"  type="email" name="email" placeholder="your email" required/><br>
                    <input class="w3-input"  type="text" name="key" placeholder="reset key" required/><br>
                    <input  class="w3-input" type="password" name="password" placeholder="Password" id="pass1"  required/><br>
                    <input  class="w3-input" type="password" name="passwordConfirm" placeholder="Confirm password" id="pass2" required/><br>
                    <div class="padding10"></div>


                    <!-- Login Button -->
                    <button class="w3-button  w3-blue w3-round" id="submit" type="submit" disabled>Reset password</button>


                    <!-- Register Button -->
                    <!-- The registration is managed by the CONTROLLER -->

                    &nbsp;&nbsp;<a class="defLink" href="${pageContext.request.contextPath}/controller?login">LogIn</a>

                </form>
            </div>  

        </div>



        <script>
            var pass1 = document.getElementById("pass1");
            var pass2 = document.getElementById("pass2");
            var submit = document.getElementById("submit");

            pass1.addEventListener("keyup", formCheck);
            pass2.addEventListener("keyup", formCheck);

            function formCheck() {

                if ((pass1.value !== pass2.value) || (pass1.value === "") || (pass2.value === "") || (pass1.value.length < 3)) {
                    submit.disabled = true;
                    submit.value = "Password Mistmach!";
                } else {
                    submit.disabled = false;
                    submit.value = "Reset password";
                }
            }
        </script>




        <!-- FOOTER -->
        <%@include file="includes/footer.jsp" %> 

