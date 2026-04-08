package config;

import java.sql.*;

public class DBConnection {
    
    public static Connection getConnection() {
        Connection c = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String url = "jdbc:mysql://localhost:3306/jobptit?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
            c = DriverManager.getConnection(url, "root", "Kmt1stkmt1st@");
        } catch (Exception e) {
            e.printStackTrace();
        } 
        
        return c;
    }   
    
    public static void closeConnection(Connection c) {
        try {
            if (c != null) c.close();
            System.out.println("da tat");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
