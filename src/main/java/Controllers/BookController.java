/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.BookDAOs;
import Models.Book;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB
        maxRequestSize = 20 * 1024 * 1024 // 20 MB
)
public class BookController extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "images";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet BookController</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet BookController at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();//lay duong dan
        Cookie[] cList = null;
        cList = request.getCookies();
        if (cList == null) {
            response.sendRedirect("/AccountController");
        } else {
            boolean flag = false;
            for (Cookie c : cList) {
                if (c.getName().equals("admin") && c.getValue().equals("book")) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                response.sendRedirect("/AccountController");
            } else {
                if (path.endsWith("/BookController")) { //danh sach khach hang
                    request.getRequestDispatcher("listProduct.jsp").forward(request, response);
                } else {
                    if (path.endsWith("/BookController/Create")) {
                        request.getRequestDispatcher("/create.jsp").forward(request, response);
                    } else {
                        if (path.startsWith("/BookController/Edit")) {
                            String[] s = path.split("/");
                            try {
                                String id = s[s.length - 1];
                                BookDAOs bDAO = new BookDAOs();
                                Book book = bDAO.getBook(id);
                                if (book == null) {
                                    response.sendRedirect("/BookController");
                                } else {
                                    HttpSession session = request.getSession();
                                    session.setAttribute("book", book);
                                    request.getRequestDispatcher("/edit.jsp").forward(request, response);
                                }
                            } catch (Exception ex) {
                                response.sendRedirect("/BookController");
                            }

                        } else {
                            if (path.startsWith("/BookController/Delete/")) {
                                String[] s = path.split("/");
                                try {
                                    String id = s[s.length - 1];
                                    BookDAOs bDAO = new BookDAOs();
                                    bDAO.delete(id);
                                    response.sendRedirect("/BookController");
                                } catch (Exception e) {
                                    response.sendRedirect("/BookController");
                                }
                            }

                        }

                    }
 //                  if (path.startsWith("/BookController/logout/")) {
//                        String[] s = path.split("/");
//                        try {
//                            String out = s[s.length - 1];
//                            if (out != null && out.equals("true")) {
//                                Cookie[] cookies = null;
//                                cookies = request.getCookies();
//
//                                if (cookies != null) {
//                                    for (Cookie c : cookies) {
//                                      
//                                        c.setValue("");
//                                        c.setMaxAge(0);
//                                        response.addCookie(c);
//                                    }
//                                }
//                                response.sendRedirect("/AccountController");
//                            }

//                    }catch (Exception e) {
//                            response.sendRedirect("/AccountController");
//                        }
                }
            }
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("bttAddnew") != null) {
            Part part = request.getPart("pic");
            if (part != null) {
                String realPart = request.getServletContext().getRealPath("/images");
                if (!Files.exists(Paths.get(realPart))) {
                    try {
                        Files.createDirectories(Paths.get(realPart));
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendRedirect("/BookController/Create");
                        return;
                    }
                }

                String filename = "";
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    filename = Paths.get(submittedFileName).getFileName().toString();
                    try {
                        part.write(Paths.get(realPart, filename).toString());
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendRedirect("/BookController/Create");
                        return;
                    }
                }
                BookDAOs bDAO = new BookDAOs();
                String id = request.getParameter("txtID");
                boolean checkID = bDAO.getBookID(id);
                if (checkID) {
                    request.getSession().setAttribute("errorMessage", "ID already exists in the database!");
                    response.sendRedirect("/BookController/Create");
                } else {
                    String name = request.getParameter("txtName");
                    int quan = Integer.parseInt(request.getParameter("txtQuan"));
                    int price = Integer.parseInt(request.getParameter("txtPrice"));
                    String des = request.getParameter("txtDes");

                    Book bNew = new Book(id, name, price, quan, filename, des);

                    Book b = bDAO.addNew(bNew);

                    if (b == null) {
                        response.sendRedirect("/BookController/Create");
                    } else {
                        response.sendRedirect("/BookController");
                    }
                }

            }
        }

        if (request.getParameter("bttEdit") != null) {

            Part part = request.getPart("pic");
            if (part != null) {
                String realPart = request.getServletContext().getRealPath("/images");
                if (!Files.exists(Paths.get(realPart))) {
                    try {
                        Files.createDirectories(Paths.get(realPart));
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendRedirect("/BookController/Create");
                        return;
                    }
                }

                String filename = "";
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    filename = Paths.get(submittedFileName).getFileName().toString();
                    try {
                        part.write(Paths.get(realPart, filename).toString());
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendRedirect("/BookController/Create");
                        return;
                    }
                }

                BookDAOs bDAO = new BookDAOs();
                String id = request.getParameter("txtID");
                Book oldBook = bDAO.getBook(id);
                String oldPic = oldBook.getPro_pic();

                String name = request.getParameter("txtName");
                int quan = Integer.parseInt(request.getParameter("txtQuan"));
                int price = Integer.parseInt(request.getParameter("txtPrice"));
                String des = request.getParameter("txtDes");
                String pic = filename;
                if (pic == null || pic.equals("")) {
                    pic = oldPic;
                }

                Book bNew = new Book(id, name, price, quan, pic, des);
                Book rs = bDAO.update(id, bNew);
                if (rs == null) {
                    Book oldInfo = bDAO.getBook(id);
                    HttpSession session = request.getSession();
                    session.setAttribute("book", oldInfo);
                    response.sendRedirect("/BookController/Edit/" + id);
                } else {
                    response.sendRedirect("/BookController");
                }
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
