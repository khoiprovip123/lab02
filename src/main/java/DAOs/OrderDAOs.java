/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Book;
import Models.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class OrderDAOs {

    Connection conn;

    public OrderDAOs() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from [order]");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Order addNew(Order newOrder) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into [order] values(?,?,?,?,?)");
            ps.setString(1, newOrder.getOrder_id());
            ps.setString(2, newOrder.getUsername());
            ps.setInt(3, newOrder.getOrder_total());
            ps.setDate(4, newOrder.getOrder_date());
            ps.setString(5, newOrder.getOrder_des());

            count = ps.executeUpdate(); // tra ve so dong bi anh huong trong sql

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? null : newOrder;
    }

    public Order getOrder(String pro_id) {
        Order order = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from [order] where order_id = ?");
            ps.setString(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order(rs.getString("order_id"), rs.getString("username"), rs.getString("order_des"), rs.getInt("order_total"), rs.getDate("order_date"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return order;
    }

    public boolean checkOrderID(String pro_id) {
        boolean order = false;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from [order] where order_id = ?");
            ps.setString(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
            return order = false;
        }
        return order;
    }

    public Order update(String order_id, Order newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update [order] set username =?, order_total=?, order_date=?, order_des=? where order_id =?");
            ps.setString(1, newInfo.getUsername());
            ps.setInt(2, newInfo.getOrder_total());
            ps.setDate(3, newInfo.getOrder_date());
            ps.setString(4, newInfo.getOrder_des());
            ps.setString(5, order_id);

            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newInfo;
    }

    public void delete(String idPro) {
        try {
            PreparedStatement ps = conn.prepareStatement("delete from [order] where order_id =?");
            ps.setString(1, idPro);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
