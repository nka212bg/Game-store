<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>

        <!-- PAGE TITLE -->
        <title>Register</title>

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
                    <h2><strong>Register</strong></h2>
                    <p style="color: red; text-align: justify">WARNING!<br>
                        This website is not a real store for games, it is only part of my portfolio and I advise you to don't put your real address and credit card information! If you do so, I am not responsible for your personal information. Also this site has not yet been made to handle query injections and hacker attacks. Thank you for your understanding :)</p>
                </div>  

                <!-- THE PARAMETERS OF THE FORM ARE SENT TO  registerInput.jsp WITH POST METHOD -->
                <!-- registerInput.jsp HANDLES THE INPUT IN THE DATABASE-->


                <form method="POST" action="./model/registerInput.jsp" class="w3-container w3-padding-24">
                    <div>
                        <input  class="w3-input" type="email" name="email" placeholder="Your email" id="email"  required/><br>
                        <input  class="w3-input" type="text" name="firstName" placeholder="First name" id="firstName"  required/><br>
                        <input  class="w3-input" type="text" name="lastName" placeholder="Last name" id="lastName"  required/><br>
                        <input  class="w3-input" type="password" name="password" placeholder="Password" id="pass1"  required/><br>
                        <input  class="w3-input" type="password" name="passwordConfirm" placeholder="Confirm password" id="pass2" required/><br>
                        <input  class="w3-input" type="text" name="address1" placeholder="Your address" id="address1"  required/><br>
                        <input  class="w3-input" type="text" name="address2" placeholder="Alternative address" id="address2"  /><br>
                        <input  class="w3-input" type="text" name="city" placeholder="City" id="city"  required/><br>
                    </div>
                    <div>
                        <input  class="w3-input" type="text" name="state" placeholder="State" id="state"  required/><br>
                        <input  class="w3-input" type="text" name="zip" placeholder="Zip/Postal code" id="zip"  required/><br>
                        <input  class="w3-input" type="text" name="country" placeholder="Country" id="country"  required/><br>
                        <input  class="w3-input" type="text" name="ccType" placeholder="Credit card type" id="ccType"  required/><br>
                        <input  class="w3-input" type="text" name="ccNumber" placeholder="Credit card number" id="ccNumber"  required/><br>
                        <input  class="w3-input" type="text" name="ccCVV" placeholder="Credit card cvv" id="ccCVV"  required/><br>
                        <input  class="w3-input" type="text" name="ccExpiry" placeholder="Card expire date" id="ccExpiry"  required/><br>
                    </div>


                    <input  class="w3-button  w3-blue w3-round"   type="submit" value="Register" id="submit" name="action" disabled/>

                    <!-- LOGIN BUTTON REDIRECTS TO THE CONTROLLER -->
                    &nbsp;&nbsp;<a class="defLink"  href="${pageContext.request.contextPath}/controller?login">LogIn</a>
                </form>


            </div>
        </div>


        <!--CHECKS IF THE PASSWORD IS THE SAME AS CONFIRM PASSWORD-->
        <!--REGISTER BUTTON IS DISABLED IF BOTH FIELDS ARE DIFFERENT-->


        <script>
            var pass1 = document.getElementById("pass1");
            var pass2 = document.getElementById("pass2");
            var submit = document.getElementById("submit");

            pass1.addEventListener("keyup", formCheck);
            pass2.addEventListener("keyup", formCheck);

            function formCheck() {

                if ((pass1.value !== pass2.value) || (pass1.value === "") || (pass2.value === "")) {
                    submit.disabled = true;
                    submit.value = "Password Mistmach!";
                } else {
                    submit.disabled = false;
                    submit.value = "Register";
                }
            }
        </script>

        <!--FOOTER-->
        <%@include file="includes/footer.jsp" %>



