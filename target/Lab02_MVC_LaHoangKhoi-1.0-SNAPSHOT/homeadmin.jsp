<%-- 
    Document   : HomeAdmin
    Created on : Oct 19, 2023, 8:27:33 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Document</title>
        <!-- Latest compiled and minified CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- gg Icon -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        <style>
            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ffffff; /* Màu nền của header */
                padding: 10px 20px;
                color: rgb(13, 201, 82); /* Màu chữ trắng */
            }

            .logo img {
                width: 50px; /* Kích thước của logo */
                height: 50px;
            }

            .logout a {
                text-decoration: none;
                color: rgb(13, 201, 82); /* Màu chữ trắng */
            }

            .logout a:hover {
                text-decoration: underline; /* Hiệu ứng khi di chuột qua "Logout" */
            }

            .home{
                height: 50px;
                width: 100%;
                background-color: rgb(6, 6, 98);
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
                color: floralwhite;
            }

            .logoHome{
                width: 30px;
                height: 30px;
                line-height:50px;
                margin: 0 10px;

            }
            .home a{
                text-decoration: none;
                line-height:50px;
                font-weight: bold;
            }

            /* 
            .square{
                width: 100px;
                height: 100px;
                background-color: blue;
                margin: 10px;
                
            }
            .squareLink{ 
                background-color: #007bff;
                cursor: pointer;  
            
            } */

            .allSquare {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                margin-top: 100px;
            }

            .square {
                flex: 1;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                background-color: #007bff;
                cursor: pointer;
                min-height: 200px;
                text-align: center;
                color: #fff;
                border: 2px solid #fff;
                border-radius: 5px;
                margin: 5px;
            }

            .text{
                color: black;
                font-weight: bold;
            }


            @media (max-width: 767px) {
                .square {
                    flex: 1 1 100%;
                    min-height: auto;
                    margin:10 50px;
                }
            }
        </style>
    <body>
        <%
            if (request.getParameter("logout") != null && request.getParameter("logout").equals("true")) {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        cookie.setValue("");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
                response.sendRedirect("/AccountController");
            }
        %>


        <!-- Header -->
        <header class="">
            <div class="logo">
                <img src="https://www.pngitem.com/pimgs/m/346-3466726_transparent-ebook-icon-png-electronic-book-ebook-icon.png" alt="Logo">
                Ebook LHK         
            </div>
            <div class="logout">
                <a href="?logout=true">Logout</a>
                <!--               <a href="/BookController/logout/true">Logout</a>-->
            </div>
        </header>
        <!-- Header -->
        <div class="home">
            <div class="left-home">
                <a href="/HomeController"><img class="logoHome" src="https://www.pinclipart.com/picdir/big/564-5647199_transparent-home-icon-clipart-circle-transparent-home-icon.png" alt="">Home</a>           
            </div>    
            <% //String fullname = (String) request.getAttribute("fullname"); 
                String fullName = null;
                Cookie[] cList = null;
                cList = request.getCookies();
                for (Cookie c : cList) {
                    if (c.getValue().equals("user")) {
                        fullName = c.getName();
                    }
                }
            %>

            <div class="right-home">
                <div>Wellcome, <%= fullName%></div>
            </div>
        </div>
        <!-- Body -->
        <div class="container">
            <div class="row allSquare">
                <div class="col-12 col-md-3 square">
                    <a class="squareLink" href="/BookController/Create">
                        <div class="logo">
                            <span class="material-symbols-outlined" style="font-size: 40px; color: black;">
                                add_circle
                            </span>

                        </div>
                        <p class="text">Add Books</p>
                    </a>
                </div>
                <div class="col-12 col-md-3 square">
                    <a class="squareLink" href="/BookController">
                        <div class="logo">
                            <span class="material-symbols-outlined" style="font-size: 40px; color: black;">
                                menu_book
                            </span>
                        </div>
                        <p class="text">All Books</p>
                    </a>
                </div>
                <div class="col-12 col-md-3 square">
                    <a class="squareLink" href="/HomeController/Order">
                        <div class="logo">
                            <span class="material-symbols-outlined" style="font-size: 40px; color: black;">
                                list_alt
                            </span>
                        </div>
                        <p class="text">Orders</p>
                    </a>
                </div>
                <div class="col-12 col-md-3 square">
                    <a class="squareLink">
                        <div class="logo">
                            <span class="material-symbols-outlined" style="font-size: 40px; color: black;">
                                contacts
                            </span>
                        </div>
                        <p class="text">My Info</p>
                    </a>
                </div>
            </div>
        </div>
        <!-- Body -->

    </body>
</html>
