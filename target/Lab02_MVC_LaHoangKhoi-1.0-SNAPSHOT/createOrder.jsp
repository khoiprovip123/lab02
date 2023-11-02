<%-- 
    Document   : createOrder
    Created on : Oct 21, 2023, 7:29:54 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f0f0f0;
        }

        .container {
            margin-top: 100px;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
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
    </style>
    <body>
        <%
            if (request.getParameter("logout") != null && request.getParameter("logout").equals("true")) {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("admin")) {
                            cookie.setValue("");
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                        }
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
            <!--            <div class="logout">
                            <a href="?logout=true">Logout</a>
                        </div>-->
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
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="form-container">
                        <h1 class="text-center">Add New Order</h1>
                        <form method="post" >
                            <div class="form-group" onclick="return validateForm()">
                                <label for="txrName">Order ID</label>
                                <input title="Please only enter numbers greater than 0" class="form-control" pattern="[1-9][0-9]*" type="text" name="txtID" class="input-field" required="" />
                            </div>

                            <div class="form-group">
                                <label for="txrBD">User Name:</label>
                                <input  pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted." class="form-control" type="text" name="txtName" class="input-field" required="" />
                            </div>

                            <div class="form-group">
                                <label for="txQuan">Order Total:</label>
                                <input required="" title="Please only enter numbers greater than 0" pattern="[1-9][0-9]*" class="form-control" type="text" name="txtTotal" class="input-field" />
                            </div>

                            <div class="form-group">
                                <label for="txtPrice">Order Date:</label>
                                <input required=""  title="Enter date in MM/DD/YYYY format." class="form-control" type="Date" name="txtDate" />
                            </div>

                            <div class="form-group">
                                <label for="txtDes">Order Description:</label>
                                <input required="" pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted." class="form-control" type="text" name="txtDes" class="input-field" />
                                <% String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                                    if (errorMessage != null) {
                                %>
                                <div style="color: red; margin-bottom: 10px;"><%= errorMessage%></div>
                                <%
                                        request.getSession().removeAttribute("errorMessage");
                                    }
                                %>
                            </div>


                            <div class="form-group">
                                <input  class="btn btn-primary btn-block" type="submit" value="Add New" name="bttAddnew" class="submit-button" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function validateForm() {
                var dateInput = document.getElementById('txtDate');
                var dateValue = dateInput.value;

                if (!isValidDate(dateValue)) {
                    alert("Date is not valid. Please enter a date in MM/DD/YYYY format.");
                    return false; // Prevent form submission
                }

                // Form is valid, continue with form submission
                return true;
            }

            function isValidDate(dateString) {
                var datePattern = /^(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/\d{4}$/;

                if (datePattern.test(dateString)) {
                    return true;
                } else {
                    return false;
                }
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
