package dao;

import java.sql.*;
import model.CandidateProfile;

public class ProfileDAO extends BaseDAO {

    public CandidateProfile getByUserId(int userId) {
        try {
            String sql = "SELECT * FROM CandidateProfiles WHERE UserId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CandidateProfile p = new CandidateProfile();
                p.setUserId(userId);
                p.setFullName(rs.getString("FullName"));
                p.setTitle(rs.getString("Title"));
                return p;
            }
        } catch (Exception e) {}
        return null;
    }
}