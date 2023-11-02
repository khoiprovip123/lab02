<%-- 
    Document   : index
    Created on : Oct 5, 2023, 2:33:36 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="DAOs.UserDAOs"%>
<%@page import="Models.Account"%>
<%@page import="DAOs.UserDAOs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:300);
        header .header{
            background-color: #fff;
            height: 45px;
        }
        header a img{
            width: 134px;
            margin-top: 4px;
        }
        .login-page {
            width: 360px;
            padding: 8% 0 0;
            margin: auto;
        }
        .login-page .form .login{
            margin-top: -31px;
            margin-bottom: 26px;
        }
        .form {
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 100px;
            padding: 45px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
        }
        .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .form button {
            font-family: "Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background-color: #328f8a;
            background-image: linear-gradient(45deg,#328f8a,#08ac4b);
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3 ease;
            transition: all 0.3 ease;
            cursor: pointer;
        }
        .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
        }
        .form .message a {
            color: #4CAF50;
            text-decoration: none;
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 300px;
            margin: 0 auto;
        }

        body {
            background-color: #328f8a;
            background-image: linear-gradient(45deg,#328f8a,#08ac4b);
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        input[type="submit"].custom-button {
            font-family: "Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background-color: #328f8a;
            background-image: linear-gradient(45deg, #328f8a, #08ac4b);
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3s ease;
            transition: all 0.3s ease;
            cursor: pointer;
        }


    </style>
    <body>      
        <div class="login-page">
            <div class="form">
                <div class="login">
                    <div class="login-header">
                        <h3>LOGIN</h3>

                    </div>
                </div>            

                <form class="login-form" action="AccountController" method="post" onsubmit="return checkValid();">                  
                    <input type="text" name="userName" id="userName" placeholder="username">                  
                    <input type="password" name="password" id="password" placeholder="password">
                    <input type="submit" name="login" value="Login" class="custom-button">
                </form>
            </div>
        </div>

        <script>
            function checkValid() {
                var username = document.getElementById("userName").value.trim();
                var password = document.getElementById("password").value.trim();

                if (username.trim() === "" || password.trim() === "") {
                    alert("Username and password cannot be empty.");
                    return false;
                } else if (password.length < 5) {
                    alert("Password must be at least 5 characters long.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
