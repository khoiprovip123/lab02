<%-- 
    Document   : listProduct
    Created on : Oct 19, 2023, 3:14:57 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.BookDAOs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
header{
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
    margin-bottom: 50px;
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

 a.button {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }

            a.button:hover {
                background-color: #0056b3;
            }
            a.button1 {
                display: inline-block;
                padding: 10px 20px;
                background-color: greenyellow;
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }

            a.button1:hover {
                background-color: green;
            }
            a.button2 {
                display: inline-block;
                padding: 10px 20px;
                background-color: red;
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }

            a.button2:hover {
                background-color: brown;
            }
        </style>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
       <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
     <!--        bootstrap-->
        
           <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
          <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
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
            <header class="">
        <div class="logo">
            <img src="https://www.pngitem.com/pimgs/m/346-3466726_transparent-ebook-icon-png-electronic-book-ebook-icon.png" alt="Logo"> 
            EBOOK
        </div>
        <div class="logout">
            <a href="?logout=true">Logout</a>
        </div>
        </header>
   <!-- Header -->
    <div class="home">
    <div class="left-home">
<!--        <a href="/HomeController"><img class="logoHome" src="https://www.pinclipart.com/picdir/big/564-5647199_transparent-home-icon-clipart-circle-transparent-home-icon.png" alt="">Home</a>           -->
    </div> 
    <div class="right-home">
        wellcom Amin
    </div>
    </div>
   <div id="table" class="container-fuirt">
            <table id="example">
                <thead> 
                    <tr>
                        <th>ID</th>
                        <th>Book Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Picture</th>
                        <th>Descrition</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>



                    <%
                        BookDAOs bDAO = new BookDAOs();
                        ResultSet rs = bDAO.getAll();

                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%=rs.getInt("pro_id")%></td>   
                        <td><%=rs.getString("pro_name")%></td>
                        <td><%=rs.getInt("pro_quan")%></td>
                        <td><%=rs.getInt("pro_price")%></td>
                        <td><img src="./images/<%=rs.getString("pro_pic")%>" alt="" style=" width: 50px; height: 50px; "> </td>
                        <th><%=rs.getString("pro_des")%></th>
                        <td>
                            <a class="button1" href="/HomeController/buy/<%=rs.getInt("pro_id")%>">Buy</a> 
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
