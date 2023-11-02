<%-- 
    Document   : edit
    Created on : Oct 19, 2023, 9:44:21 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Models.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    </head>
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
        
        <%
            Book book = (Book) session.getAttribute("book");
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
            <h1 class="text-center">Edit Product</h1>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="form-container">
                        <form method="post" action="BookController" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="txtID">Product Id</label>
                                <input type="text" name="txtID" class="form-control" value="<%=book.getPro_id()%>" readonly="" />
                            </div>
                            <div class="form-group">
                                <label for="txtName">Product Name:</label>
                                <input type="text" name="txtName" class="form-control" required="" value="<%=book.getPro_name()%>" pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted." />
                            </div>
                            <div class="form-group">
                                <label for="txtQuan">Product Quantity:</label>
                                <input type="text" name="txtQuan" class="form-control" required="" value="<%=book.getPro_quan()%>"  pattern="[1-9][0-9]*" title="Please only enter numbers greater than 0" />
                            </div>
                            <div class="form-group">
                                <label for="txtPrice">Product Price:</label>
                                <input type="text" name="txtPrice" class="form-control" required="" value="<%=book.getPro_price()%>" pattern="[1-9][0-9]*" title="Please only enter numbers greater than 0"/>
                            </div>
                            <div class="form-group">
                                <label for="txtDes">Product Description:</label>
                                <input type="text" name ="txtDes" class="form-control" required="" value="<%=book.getPro_des()%>" pattern="[a-zA-Z ]+" title="Only uppercase and lowercase letters are accepted." />
                            </div>
                            <label for="filePic">Picture:</label>
                            <input type="file" id="filePic" name="pic" class="form-control-file" accept="image/*">
                            <img src="/images/<%=book.getPro_pic()%>" class="form-image" />
                            <div class="form-group">
                                <input type="submit" value="Edit" name="bttEdit" class="btn btn-primary btn-block" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thêm thư viện Bootstrap JS và Popper.js (đối với Bootstrap phiên bản 4) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
