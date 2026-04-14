package dao;

import config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Application;

public class ApplicationDAO {
    private Connection conn;

    // Constructor khởi tạo kết nối MySQL
    public ApplicationDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/JobPtit", "root", "Kobiethichiuhoi2@");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Hàm nộp đơn ứng tuyển: Chỉ lưu UserId và JobId.
     * CV sẽ được hệ thống tự động lấy từ bảng CandidateProfiles khi cần.
     */
    public boolean addApplication(int userId, int jobId) {
        // Thêm cột AppliedAt với giá trị NOW() để ghi nhận thời gian nộp đơn
        String sql = "INSERT INTO Applications (UserId, JobId, Status, AppliedAt) VALUES (?, ?, 0, NOW())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
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