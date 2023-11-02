/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class Order {
    String order_id, username, order_des;
    int order_total;
    Date order_date;

    public Order() {
    }

    public Order(String order_id, String username, String order_des, int order_total, Date order_date) {
        this.order_id = order_id;
        this.username = username;
        this.order_des = order_des;
        this.order_total = order_total;
        this.order_date = order_date;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getOrder_des() {
        return order_des;
    }

    public void setOrder_des(String order_des) {
        this.order_des = order_des;
    }

    public int getOrder_total() {
        return order_total;
    }

    public void setOrder_total(int order_total) {
        this.order_total = order_total;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }
    
    
}
