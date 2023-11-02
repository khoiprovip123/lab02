/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class DBConnection {
     public static Connection connect() throws ClassNotFoundException, SQLException{
          Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
           Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-5ABH3PVT:1433;databaseName=lab02;user=sa;password=sa;encrypt=true;trustServerCertificate=true");
            return conn;  
    }
}
