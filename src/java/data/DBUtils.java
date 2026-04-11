  package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {
   private static final String URL = "jdbc:mysql://localhost:3306/jobPtit?useUnicode=true&characterEncoding=UTF-8";
   private static final String USERNAME = "root";
   private static final String PASSWORD = "1NG@huuduc0";

   public static Connection getConnection() throws SQLException {
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
      } catch (ClassNotFoundException var1) {
         var1.printStackTrace();
      }

      return DriverManager.getConnection("jdbc:mysql://localhost:3306/jobPtit?useUnicode=true&characterEncoding=UTF-8", "root", "1NG@huuduc0");
   }

   public static void close(AutoCloseable resource) {
      if (resource != null) {
         try {
            resource.close();
         } catch (Exception var2) {
            var2.printStackTrace();
         }
      }

   }
}