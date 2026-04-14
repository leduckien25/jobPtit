package dao;

import config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Application;

public class ApplicationDAO {

    
    /**
     * Hàm nộp đơn ứng tuyển: Chỉ lưu UserId và JobId.
     * CV sẽ được hệ thống tự động lấy từ bảng CandidateProfiles khi cần.
     */
    public boolean addApplication(int userId, int jobId) {
        // Thêm cột AppliedAt với giá trị NOW() để ghi nhận thời gian nộp đơn
        String sql = "INSERT INTO Applications (UserId, JobId, Status, AppliedAt) VALUES (?, ?, 0, NOW())";
        try (Connection conn = new DBConnection().getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            // Nếu người dùng nộp đơn trùng (Unique constraint), lỗi sẽ hiện ở đây
            e.printStackTrace(); 
        }
        return false;
    }

    /**
     * Hàm lấy danh sách công việc đã nộp để hiển thị cho ứng viên
     */
    public List<Application> getAppliedJobs(int userId) {
        List<Application> list = new ArrayList<>();
        // Query join bảng để lấy tiêu đề công việc và tên công ty
        String sql = "SELECT a.*, j.Title as jobTitle, c.Name as companyName " +
                     "FROM Applications a " +
                     "JOIN Jobs j ON a.JobId = j.Id " +
                     "JOIN Companies c ON j.CompanyId = c.Id " +
                     "WHERE a.UserId = ? " +
                     "ORDER BY a.AppliedAt DESC"; // Sắp xếp đơn mới nhất lên đầu
         
        try (Connection conn = new DBConnection().getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
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
    
    public boolean deleteApplication(int appId, int userId) {
        String sql = "DELETE FROM Applications WHERE id = ? AND userId = ?";
        try (Connection conn = new DBConnection().getConnection(); 
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}