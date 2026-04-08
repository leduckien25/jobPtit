package dao;

import java.sql.*;

public class ApplicationDAO extends BaseDAO {

    public void apply(int userId, int jobId) {
        try {
            String sql = "INSERT INTO Applications(UserId, JobId, Status) VALUES (?,?,0)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            ps.executeUpdate();
        } catch (Exception e) {}
    }
}