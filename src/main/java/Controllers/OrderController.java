/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.OrderDAOs;
import Models.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class OrderController extends HttpServlet {

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
//            out.println("<title>Servlet OrderController</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet OrderController at " + request.getContextPath () + "</h1>");
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
                String fullname = (String) request.getAttribute("fullname");
                //   processRequest(request, response);
                String path = request.getRequestURI();//lay duong dan
                if (path.endsWith("/OrderController")) { //danh sach khach hang
                    request.setAttribute("fullname", fullname);
                    request.getRequestDispatcher("listOrder.jsp").forward(request, response);
                } else {
                    if (path.endsWith("/OrderController/Create")) {

                        request.setAttribute("fullname", fullname);
                        request.getRequestDispatcher("/createOrder.jsp").forward(request, response);
                    } else {
                        if (path.startsWith("/OrderController/Edit")) {
                            String[] s = path.split("/");
                            try {
                                String id = s[s.length - 1];
                                OrderDAOs oDAO = new OrderDAOs();
                                Order order = oDAO.getOrder(id);
                                if (order == null) {
                                    response.sendRedirect("/OrderController");
                                } else {
                                    HttpSession session = request.getSession();
                                    session.setAttribute("order", order);
                                    request.setAttribute("fullname", fullname);
                                    request.getRequestDispatcher("/editOrder.jsp").forward(request, response);
                                }
                            } catch (Exception ex) {
                                response.sendRedirect("/OrderController");
                            }

                        } else {
                            if (path.startsWith("/OrderController/Delete/")) {
                                String[] s = path.split("/");
                                try {
                                    String id = s[s.length - 1];
                                    OrderDAOs oDAO = new OrderDAOs();
                                    oDAO.delete(id);
                                    response.sendRedirect("/OrderController");
                                } catch (Exception e) {
                                    response.sendRedirect("/OrderController");
                                }
                            }

                        }
                        if (path.startsWith("/OrderController/logout/")) {
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

        if (request.getParameter("bttAddnew") != null) {
            OrderDAOs oDAO = new OrderDAOs();
            String id = request.getParameter("txtID");
            boolean checkID = oDAO.checkOrderID(id);
            if (checkID) {
                request.getSession().setAttribute("errorMessage", "ID already exists in the database!");
                response.sendRedirect("/OrderController/Create");
            } else {
                String name = request.getParameter("txtName");
                int total = Integer.parseInt(request.getParameter("txtTotal"));
                Date date = Date.valueOf(request.getParameter("txtDate"));
                String des = request.getParameter("txtDes");

                Order oNew = new Order(id, name, des, total, date);

                Order b = oDAO.addNew(oNew);
                if (b == null) {
                    response.sendRedirect("/OrderController/Create");
                } else {
                    response.sendRedirect("/OrderController");
                }
            }

        }

        if (request.getParameter("bttEdit") != null) {
            OrderDAOs oDAO = new OrderDAOs();
            String id = request.getParameter("txtID");
            String name = request.getParameter("txtName");
            int total = Integer.parseInt(request.getParameter("txtTotal"));
            Date date = Date.valueOf(request.getParameter("txtDate"));
            String des = request.getParameter("txtDes");

            Order oNew = new Order(id, name, des, total, date);

            Order rs = oDAO.update(id, oNew);
            if (rs == null) {
                Order oldInfo = oDAO.getOrder(id);
                HttpSession session = request.getSession();
                session.setAttribute("order", oldInfo);
                response.sendRedirect("/OrderController/edit/" + id);
            } else {
                response.sendRedirect("/OrderController");
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
