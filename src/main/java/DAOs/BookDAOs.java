/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Book;
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
public class BookDAOs {

    Connection conn;

    public BookDAOs() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from product");
        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Book addNew(Book newBook) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into product values(?,?,?,?,?,?)");
            ps.setString(1, newBook.getPro_id());
            ps.setString(2, newBook.getPro_name());
            ps.setInt(3, newBook.getPro_price());
            ps.setInt(4, newBook.getPro_quan());
            ps.setString(5, newBook.getPro_pic());
            ps.setString(6, newBook.getPro_des());

            count = ps.executeUpdate(); // tra ve so dong bi anh huong trong sql

        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? null : newBook;
    }

    public Book getBook(String pro_id) {
        Book book = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from product where pro_id = ?");
            ps.setString(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                book = new Book(rs.getString("pro_id"), rs.getString("pro_name"), rs.getInt("pro_quan"), rs.getInt("pro_price"), rs.getString("pro_pic"), rs.getString("pro_des"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return book;
    }

    public boolean getBookID(String pro_id) {
        boolean checkID = false;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from product where pro_id = ?");
            ps.setString(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                checkID = true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
            return checkID;
        }
        return checkID;
    }

    public Book update(String pro_id, Book newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update product set pro_name =?, pro_price=?, pro_quan=?, pro_pic=?,pro_des=? where pro_id =?");

            ps.setString(1, newInfo.getPro_name());
            ps.setInt(2, newInfo.getPro_price());
            ps.setInt(3, newInfo.getPro_quan());
            ps.setString(4, newInfo.getPro_pic());
            ps.setString(5, newInfo.getPro_des());
            ps.setString(6, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newInfo;
    }

    public void delete(String idPro) {
        try {
            PreparedStatement ps = conn.prepareStatement("delete from product where pro_id =?");
            ps.setString(1, idPro);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
