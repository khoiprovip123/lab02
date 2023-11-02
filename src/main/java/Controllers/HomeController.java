/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class HomeController extends HttpServlet {

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
//            out.println("<title>Servlet HomeController</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet HomeController at " + request.getContextPath () + "</h1>");
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
        // processRequest(request, response);
        //  HttpSession session = request.getSession();
        //  Account acc = (Account) session.getAttribute("user");
        //  String fullname = acc.getFullName();
        String path = request.getRequestURI();
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
                if (path.endsWith("/HomeController")) {
                    //  request.setAttribute("fullname", fullname);

                    request.getRequestDispatcher("homeadmin.jsp").forward(request, response);
                } else {
                    if (path.endsWith("/HomeController/Order")) {
//                        request.getRequestDispatcher("/listOrder.jsp").forward(request, response);
                        //  request.setAttribute("fullname", fullname);
                        // response.sendRedirect("/OrderController");
                        request.getRequestDispatcher("/OrderController").forward(request, response);
                    }
//                     if (path.endsWith("/HomeController/Buy")) {
//                        request.getRequestDispatcher("/listOrder.jsp").forward(request, response);
//                         request.setAttribute("fullname", fullname);
//                       // response.sendRedirect("/OrderController");
//                        request.getRequestDispatcher("/sellpProduct").forward(request, response);
//                    }

                }
                if (path.startsWith("/HomeController/logout/")) {
                    String[] s = path.split("/");
                    try {
                        String out = s[s.length - 1];
                        if (out != null && out.equals("true")) {
                            Cookie[] cookies = null;
                            cookies = request.getCookies();

                            if (cookies != null) {
                                for (Cookie c : cookies) {
                                    c.setValue("");
                                    c.setMaxAge(0);
                                    
                                    response.addCookie(c);
                                }
                            }
                            response.sendRedirect("/AccountController");
                        }

                    } catch (Exception e) {
                        response.sendRedirect("/AccountController");
                    }
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
        // processRequest(request, response);
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
