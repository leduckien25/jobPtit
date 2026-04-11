package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Application;

public class ApplicationDAO {
    private Connection conn;

    // Constructor này giúp khởi tạo kết nối ngay khi bạn tạo đối tượng DAO
    public ApplicationDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Thay đổi user/password cho đúng với MySQL Workbench của bạn
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/JobPtit", "root", "Kobiethichiuhoi2@");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean addApplication(int userId, int jobId) {
        String sql = "INSERT INTO Applications (UserId, JobId, Status) VALUES (?, ?, 0)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return false;
    }

    public List<Application> getAppliedJobs(int userId) {
        List<Application> list = new ArrayList<>();
        // Query này join bảng để lấy tên Công việc và Công ty cho đúng Figma
        String sql = "SELECT a.*, j.Title as jobTitle, c.Name as companyName " +
                     "FROM Applications a " +
                     "JOIN Jobs j ON a.JobId = j.Id " +
                     "JOIN Companies c ON j.CompanyId = c.Id " +
                     "WHERE a.UserId = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("Id"));
                    app.setJobTitle(rs.getString("jobTitle"));
                    app.setCompanyName(rs.getString("companyName"));
                    app.setStatus(rs.getInt("Status"));
                    app.setAppliedAt(rs.getTimestamp("AppliedAt"));
                    list.add(app);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }
}