/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.*;
/**
 *
 * @author ducki
 */
public class DBContext {
    private final String url = "jdbc:mysql://localhost:3306/jobptit";
    private final String user = "root";
    private final String password = "1234";
    
    public Connection getConnection() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");        
        return DriverManager.getConnection(url, user, password);
    }
}
