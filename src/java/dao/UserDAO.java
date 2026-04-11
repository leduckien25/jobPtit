/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import Util.SecurityUtil;
import config.DBConnection;
import model.User;
import java.sql.*;

/**
 *
 * @author huyle
 */
public class UserDAO {
    public User login(String email, String password) {
        String sql = "SELECT * FROM Users WHERE Email = ? AND PasswordHash = ? AND IsActive = 1";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            
            // Mã hóa mật khẩu người dùng nhập vào để đem đi so sánh với chuỗi trong DB
            String hashedPass = SecurityUtil.hashPassword(password);
            ps.setString(2, hashedPass); 
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("Id"));
                user.setEmail(rs.getString("Email"));
                user.setRole(rs.getInt("Role"));
                user.setIsActive(rs.getBoolean("IsActive"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. ĐĂNG KÝ
    public boolean register(String email, String password, int role, String companyName) {
        String insertUserSql = "INSERT INTO Users (Email, PasswordHash, Role) VALUES (?, ?, ?)";
        String insertCompanySql = "INSERT INTO Companies (Name, OwnerUserId, IsVerified) VALUES (?, ?, 0)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            // TẮT AUTO COMMIT: Bắt đầu một Transaction (Giao dịch)
            conn.setAutoCommit(false); 

            // 1. Tạo User mới
            // Statement.RETURN_GENERATED_KEYS dùng để lấy lại ID của User vừa được tạo
            try (PreparedStatement psUser = conn.prepareStatement(insertUserSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, email);
                
                String hashPass= SecurityUtil.hashPassword(password);
                psUser.setString(2, hashPass); 
                
                psUser.setInt(3, role);
                
                int affectedRows = psUser.executeUpdate();
                if (affectedRows == 0) {
                    conn.rollback(); 
                    return false;
                }

                // 2. Nếu là Nhà tuyển dụng (Role = 2), tiếp tục tạo Company
                if (role == 2) {
                    try (ResultSet generatedKeys = psUser.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int newUserId = generatedKeys.getInt(1); // Lấy ra ID vừa tạo

                            // Bắt đầu lưu vào bảng Companies
                            try (PreparedStatement psCompany = conn.prepareStatement(insertCompanySql)) {
                                // Nếu người dùng không nhập tên công ty, để tạm là "Công ty chưa cập nhật"
                                String cName = (companyName != null && !companyName.trim().isEmpty()) 
                                                ? companyName 
                                                : "Công ty chưa cập nhật";
                                                
                                psCompany.setString(1, cName);
                                psCompany.setInt(2, newUserId);
                                psCompany.executeUpdate();
                            }
                        } else {
                            conn.rollback();
                            return false;
                        }
                    }
                }
                
                // 3. Nếu mọi thứ đều thành công -> Lưu vĩnh viễn vào DB
                conn.commit();
                return true;
                
            } catch (Exception e) {
                conn.rollback(); // Bất kỳ lỗi gì xảy ra cũng hoàn tác (xóa User vừa tạo)
                e.printStackTrace();
                return false;
            } finally {
                // Trả lại trạng thái ban đầu cho Connection
                conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
    
    public boolean existsByEmail(String email) {
        String sql = "SELECT Id FROM Users WHERE Email = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Trả về true nếu đã có người dùng email này
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
