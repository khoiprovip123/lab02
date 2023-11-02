<%-- 
    Document   : editOrder
    Created on : Oct 21, 2023, 7:44:53 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Models.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>

            body {
                background-color: #f0f0f0;
            }
            .form-group {
                margin-bottom: 20px;
            }


            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .form-container {
                background-color: #fff;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .form-image {
                width: 100px;
                height: 100px;
                object-fit: cover;
                margin-top: 10px;
                margin-bottom: 20px;
            }

            .btn {
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn:hover {
                background-color: #0056b3;
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
    </head>
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
        <%
            Order order = (Order) session.getAttribute("order");
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
            <h1 class="text-center">Edit Order</h1>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="form-container">
                        <form method="post" onsubmit="return validate();">
                            <div class="form-group">
                                <label for="txrName">Order ID</label>
                                <input class="form-control" type="text" name="txtID" class="input-field" value="<%=order.getOrder_id()%>" readonly="" />
                            </div>

                            <div class="form-group">
                                <label for="txrBD">User Name:</label>
                                <input class="form-control" type="text" name="txtName" class="input-field" value="<%=order.getUsername()%>" pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted." required="" />
                            </div>

                            <div class="form-group">
                                <label for="txQuan">Order Total:</label>
                                <input class="form-control" type="text" name="txtTotal" class="input-field" value="<%=order.getOrder_total()%>" required="" pattern="[1-9][0-9]*" title="Please only enter numbers greater than 0" />
                            </div>

                            <div class="form-group">
                                <label for="txtPrice">Order Date:</label>
                                <input class="form-control" type="Date" name="txtDate" class="input-field" value="<%=order.getOrder_date()%>" required="" />
                            </div>

                            <div class="form-group">
                                <label for="txtDes">Order Description:</label>
                                <input class="form-control" type="text" name="txtDes" class="input-field" value="<%=order.getOrder_des()%>" pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted."pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted." />
                            </div>

                            <div class="form-group">
                                <input class="btn btn-primary btn-block" type="submit" value="Add New" name="bttEdit" class="submit-button" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function validate() {
                var birthday = document.getElementById('txtDate').value;
                if (!isValidDate(birthday)) {
                    alert("You did not enter a valid birthday. Please use the MM/DD/YYYY format.");
                    return false; // Prevent form submission
                }

                // Form is valid, continue with form submission
                return true;
            }

            function isValidDate(d) {
                return !isNaN((new Date(d)).getTime());
            }
        </script><script>
         function validate() {
             var birthday = document.getElementById('txtDate').value;
             if (!isValidDate(birthday)) {
                 alert("You did not enter a valid birthday. Please use the MM/DD/YYYY format.");
                 return false; // Prevent form submission
             }

             // Form is valid, continue with form submission
             return true;
         }

         function isValidDate(d) {
             return !isNaN((new Date(d)).getTime());
         }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
