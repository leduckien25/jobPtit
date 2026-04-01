package dao;

import java.sql.*;
import model.User;

public class UserDAO extends BaseDAO {

    public User login(String email, String pass) {
        try {
            String sql = "SELECT * FROM Users WHERE Email=? AND PasswordHash=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("Id"));
                u.setEmail(rs.getString("Email"));
                u.setRole(rs.getInt("Role"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}