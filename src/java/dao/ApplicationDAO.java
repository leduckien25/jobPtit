package dao;

import config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Application;

public class ApplicationDAO {

    public ApplicationDAO() {}

    /**
     Nộp đơn ứng tuyển
     */
    public boolean addApplication(int userId, int jobId) {
        // Kiểm tra xem đã ứng tuyển chưa (tránh nộp trùng)
        if (hasApplied(userId, jobId)) return false;

        String sql = "INSERT INTO Applications (UserId, JobId, Status, AppliedAt) VALUES (?, ?, 0, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (conn == null) return false;
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm phụ kiểm tra trùng lặp
    private boolean hasApplied(int userId, int jobId) {
        String sql = "SELECT Id FROM Applications WHERE UserId = ? AND JobId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) { return false; }
    }

    /**
    Lấy danh sách việc làm đã nộp (cho Candidate)
     */
    public List<Application> getAppliedJobs(int userId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, j.Title as jobTitle, c.Name as companyName " +
                     "FROM Applications a " +
                     "JOIN Jobs j ON a.JobId = j.Id " +
                     "JOIN Companies c ON j.CompanyId = c.Id " +
                     "WHERE a.UserId = ? " +
                     "ORDER BY a.AppliedAt DESC"; 
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (conn == null) return list;
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

    /**
     Xóa đơn ứng tuyển (Hủy đơn)
     */
    public boolean deleteApplication(int appId) {
        // Chỉ cho phép xóa khi trạng thái là 0 (Đang chờ)
        String sql = "DELETE FROM Applications WHERE Id = ? AND Status = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (conn == null) return false;
            ps.setInt(1, appId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     Xem ứng viên đã ứng tuyển (Hỗ trợ Recruiter)
     * Hàm này giúp lấy thông tin Ứng viên + CV từ bảng CandidateProfiles
     */
    public List<Application> getApplicationsByJobId(int jobId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, cp.FullName, cp.CVUrl, u.Email " +
                     "FROM Applications a " +
                     "JOIN Users u ON a.UserId = u.Id " +
                     "LEFT JOIN CandidateProfiles cp ON u.Id = cp.UserId " +
                     "WHERE a.JobId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("Id"));
                app.setCandidateName(rs.getString("FullName") != null ? rs.getString("FullName") : rs.getString("Email"));
                app.setCvUrl(rs.getString("CVUrl"));
                app.setStatus(rs.getInt("Status"));
                app.setAppliedAt(rs.getTimestamp("AppliedAt"));
                list.add(app);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}