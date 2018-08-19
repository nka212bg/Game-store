<%@page import="controller.DBW"%>
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
        <title>Edit user</title>

        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" /> 

        <!-- HEADER -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
        <link href="script/myCss.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <%if (session.getAttribute("email") == null || session.getAttribute("email").equals("")) {
                response.sendRedirect("controller?login");
                return;
            } else if (session.getAttribute("rank").equals("Admin")) {

        %> 

        <div class="w3-center wd">

            <p>If you want admin rights, please write me at nka212bg@gmail.com</p>  
            <div class="w3-card-2 round">


                <!-- FORM -->

                <div class="w3-container">
                    <h2><strong>Edit user</strong></h2>
                </div>  


                <form class="w3-container w3-margin-top" method="GET" action="" >


                    <select  class="w3-input" name="userid">
                        <option  disabled selected hidden>Select user</option>

                        <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->

                        <%                            Statement st = DBW.getDbConnection().createStatement();
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
                    </select><br> 

                    <button style="float: right" class="w3-button  w3-blue w3-round"   type="submit"  name="select" >Select</button>


                </form>


                <form method="POST" action="./model/updateUser.jsp" class="w3-container w3-padding-24">

                    <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->

                    <%
                        String userid = request.getParameter("userid");

                        st = DBW.getDbConnection().createStatement();
                        rs = st.executeQuery("select * from user  where userid='" + userid + "'");

                        try {

                            while (rs.next()) {%> 

                    <div>
                        <p class="w3-small w3-left w3-light-grey w3-padding-large" style="margin-left: 3px"><%=rs.getString("email")%></p><br>
                        <input  class="w3-input" type="hidden" name="email" placeholder="Your email" id="email"  required value="<%=rs.getString("email")%>"/><br>
                        <input  class="w3-input" type="text" name="firstName" placeholder="First name" id="firstName"  required value="<%=rs.getString("firstname")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">First Name</label>                        
                        <input  class="w3-input" type="text" name="lastName" placeholder="Last name" id="lastName"  required value="<%=rs.getString("lastname")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Last Name</label>

                        <input type="hidden" name="oldPassword"  value="<%=rs.getString("password")%>"/>
                        <input type="hidden" name="oldPasswordComf"  value="<%=rs.getString("password")%>"/>
                        <input  class="w3-input" type="text" name="newPassword" id="pass1" value="<%=rs.getString("password")%>" required/>
                        <label class="w3-left w3-small w3-margin-bottom  w3-text-red" style="padding-left: 8px; color: #bbb">Password</label>

                        <input  class="w3-input" type="text" name="address1" placeholder="Your address" id="address1"  required value="<%=rs.getString("address1")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Your address</label>
                        <input  class="w3-input" type="text" name="address2" placeholder="Alternative address" id="address2"  value="<%=rs.getString("address2")%>" />
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Alternative address</label>
                        <input  class="w3-input" type="text" name="city" placeholder="City" id="city"  required value="<%=rs.getString("city")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">City</label>
                        <input  class="w3-input" type="text" name="state" placeholder="State" id="state"  required value="<%=rs.getString("state")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">State</label>
                        <input  class="w3-input" type="text" name="zip" placeholder="Zip/Postal code" id="zip"  required value="<%=rs.getString("zip")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Zip/Postal code</label>
                        <input  class="w3-input" type="text" name="country" placeholder="Country" id="country"  required value="<%=rs.getString("country")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Country</label>
                        <input  class="w3-input" type="text" name="ccType" placeholder="Credit card type" id="ccType"  required value="<%=rs.getString("credit_card_type")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Credit card type</label>
                        <input  class="w3-input" type="text" name="ccNumber" placeholder="Credit card number" id="ccNumber"  required value="<%=rs.getString("credit_card_number")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Credit card number</label>
                        <input  class="w3-input" type="text" name="ccCVV" placeholder="Credit card cvv" id="ccCVV"  required value="<%=rs.getString("credit_card_cvv")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Credit card cvv</label>
                        <input  class="w3-input" type="text" name="ccExpiry" placeholder="Card expire date" id="ccExpiry"  required value="<%=rs.getString("credit_card_expiry")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Card expire date</label>
                        <input  class="w3-input" type="text" name="registered" placeholder="Registered on" id="ccExpiry"  required value="Registered on: <%=rs.getString("registeredOn")%>" disabled/><br>

                        <select  class="w3-input" name="rank" >
                            <option selected value="<%=rs.getString("rank")%>">Rank: <%=rs.getString("rank")%></option>
                            <option>Customer</option>
                            <option>Admin</option>
                            <option>Block</option>
                        </select><br><br> 

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


        <% } else if (session.getAttribute("rank").equals("Customer")) {

        %> 

        <div class="w3-center wd">

            <p>If you want admin rights, please write me at nka212bg@gmail.com</p>  
            <div class="w3-card-2 round">

                <!-- FORM -->

                <div class="w3-container">
                    <h2><strong>Edit my profile</strong></h2>
                </div>  

                <form method="POST" action="./model/updateUser.jsp" class="w3-container w3-padding-24">

                    <!-- CONNECTION WITH THE DATABASE TO GENERATE THE VALUES OF THE SELECT OPTION -->

                    <%                        String userid = request.getParameter("userid");

                        Statement st = DBW.getDbConnection().createStatement();
                        ResultSet rs = st.executeQuery("select * from user  where userid='" + session.getAttribute("userid") + "'");

                        try {

                            while (rs.next()) {%> 

                    <div>
                        <p class="w3-small w3-left w3-light-grey w3-padding-large" style="margin-left: 3px"><%=rs.getString("email")%></p><br>
                        <input  class="w3-input" type="hidden" name="email" placeholder="Your email" id="email"  required value="<%=rs.getString("email")%>"/><br>
                        <input  class="w3-input" type="text" name="firstName" placeholder="First name" id="firstName"  required value="<%=rs.getString("firstname")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">First Name</label>                        
                        <input  class="w3-input" type="text" name="lastName" placeholder="Last name" id="lastName"  required value="<%=rs.getString("lastname")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Last Name</label>
                        <input  class="w3-input" type="hidden" name="oldPassword" value="<%=rs.getString("password")%>"/>
                        <input  class="w3-input" type="password" name="oldPasswordComf" required/>
                        <label class="w3-left w3-small w3-margin-bottom w3-text-red" style="padding-left: 8px; color: #bbb">Old password</label>
                        <input  class="w3-input" type="password" name="newPassword" id="pass1"  required/>
                        <label class="w3-left w3-small w3-margin-bottom w3-text-red" style="padding-left: 8px; color: #bbb">New Password</label>
                        <input  class="w3-input" type="password" name="passwordConfirm" id="pass2" required/>
                        <label class="w3-left w3-small w3-margin-bottom w3-text-red" style="padding-left: 8px; color: #bbb">Confirm password</label>
                        <input  class="w3-input" type="text" name="address1" placeholder="Your address" id="address1"  required value="<%=rs.getString("address1")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Your address</label>
                        <input  class="w3-input" type="text" name="address2" placeholder="Alternative address" id="address2"  value="<%=rs.getString("address2")%>" />
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Alternative address</label>
                        <input  class="w3-input" type="text" name="city" placeholder="City" id="city"  required value="<%=rs.getString("city")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">City</label>
                        <input  class="w3-input" type="text" name="state" placeholder="State" id="state"  required value="<%=rs.getString("state")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">State</label>
                        <input  class="w3-input" type="text" name="zip" placeholder="Zip/Postal code" id="zip"  required value="<%=rs.getString("zip")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Zip/Postal code</label>
                        <input  class="w3-input" type="text" name="country" placeholder="Country" id="country"  required value="<%=rs.getString("country")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Country</label>
                        <input  class="w3-input" type="text" name="ccType" placeholder="Credit card type" id="ccType"  required value="<%=rs.getString("credit_card_type")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Credit card type</label>
                        <input  class="w3-input" type="text" name="ccNumber" placeholder="Credit card number" id="ccNumber"  required value="<%=rs.getString("credit_card_number")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Credit card number</label>
                        <input  class="w3-input" type="text" name="ccCVV" placeholder="Credit card cvv" id="ccCVV"  required value="<%=rs.getString("credit_card_cvv")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Credit card cvv</label>
                        <input  class="w3-input" type="text" name="ccExpiry" placeholder="Card expire date" id="ccExpiry"  required value="<%=rs.getString("credit_card_expiry")%>"/>
                        <label class="w3-left w3-small w3-margin-bottom" style="padding-left: 8px; color: #bbb">Card expire date</label>
                        <input  class="w3-input" type="text" name="registered" placeholder="Registered on" required value="Registered on: <%=rs.getString("registeredOn")%>" disabled/><br><br> 
                        <input  type="hidden" name="rank" value="<%=rs.getString("rank")%>"/>


                    </div>

                    <% }
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }

                        rs.close();
                        st.close();
                    %>

                    <input  class="w3-button  w3-blue w3-round"   type="submit" value="Update" id="submit" name="action" disabled/>

                    <!-- LOGIN BUTTON REDIRECTS TO THE CONTROLLER -->
                    &nbsp;&nbsp;<a class="defLink"  href="${pageContext.request.contextPath}/">Home</a>
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
                if ((pass1.value !== pass2.value) || (pass1.value === "") || (pass2.value === "") || (pass1.value.length < 3)) {
                    submit.disabled = true;
                    submit.value = "Password Mistmach!";
                } else {
                    submit.disabled = false;
                    submit.value = "Update";
                }
            }
        </script>

        <% }%>

        <!--FOOTER-->
        <%@include file="includes/footer.jsp" %>



