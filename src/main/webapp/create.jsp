<%-- 
    Document   : create
    Created on : Oct 19, 2023, 9:04:23 PM
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

    <!-- gg Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
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
        
        #selectedImage {
            display: none;
            max-width: 100px;
            max-height: 100px;
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
                <!--                <a href="?logout=true">Logout</a>-->
            </div>
            <!--            <div class="logout">
                            <a href="/BookController/logout/true">Logout</a>
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
                        <h1 class="text-center">Add New Product</h1>
                        <form method="post" action="BookController" enctype="multipart/form-data" onsubmit="validateFileType()">
                            <div class="form-group">
                                <label for="txtID">Product ID:</label>
                                <input type="text" name="txtID" class="form-control"required pattern="[1-9][0-9]*" required title="Please only enter numbers greater than 0" />

                            </div>
                            <div class="form-group">
                                <label for="txtName">Product Name:</label>
                                <input type="text" name="txtName" class="form-control"required pattern="[a-zA-Z]+" title="Only uppercase and lowercase letters are accepted."/>
                            </div>
                            <div class="form-group">
                                <label for="txtQuan">Product Quantity:</label>
                                <input type="text" name="txtQuan" pattern="[1-9][0-9]*" class="form-control"required title="Please only enter numbers greater than 0" />
                            </div>
                            <div class="form-group">
                                <label for="txtPrice">Product Price:</label>
                                <input type="text" name="txtPrice" class="form-control"required pattern="[1-9][0-9]*" title="Please only enter numbers greater than 0" />
                            </div>
                            <div class="form-group">
                                <label for="txtDes">Product Description:</label>
                                <input pattern="[a-zA-Z]+" title="Only uppercase and lowercase letters are accepted." type="text" name="txtDes" class="form-control "required  />
                            </div>
                            <div class="form-group">
                                <label for="filePic">Picture:</label>
                                <input type="file"  id="imageInput" name="pic" class="form-control-file" required accept="image/*"  onchange="showSelectedImage()"><br />
                           <img id="selectedImage" alt="Selected Image">
                            </div>
                            <% String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                                if (errorMessage != null) {
                            %>
                            <div style="color: red; margin-bottom: 10px;"><%= errorMessage%></div>


                            <%
                                    request.getSession().removeAttribute("errorMessage");
                                }
                            %>
                            <div class="form-group">
                                <input type="submit" value="Add New" name="bttAddnew" class="btn btn-primary btn-block" />
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>

              function showSelectedImage() {
            var imageInput = document.getElementById('imageInput');
            var selectedImage = document.getElementById('selectedImage');

            if (imageInput.files && imageInput.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    selectedImage.style.display = 'block'; // Hiển thị thẻ img
                    selectedImage.src = e.target.result;
                };
                reader.readAsDataURL(imageInput.files[0]);
            } else {
                selectedImage.style.display = 'none'; // Ẩn thẻ img nếu không có ảnh
            }
        }
            function validateFileType() {
                var selectedFile = document.getElementById('fileInput').files[0];
                var allowedTypes = ['image/jpeg', 'image/png'];

                if (!allowedTypes.includes(selectedFile.type)) {
                    alert('Invalid file type. Please upload a JPEG, PNG, or PDF file.');
                    document.getElementById('fileInput').value = '';
                }
            }
        </script>
        <!-- Thêm thư viện Bootstrap JS và Popper.js (đối với Bootstrap phiên bản 4) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
