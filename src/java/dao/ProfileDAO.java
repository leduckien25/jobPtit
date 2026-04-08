package dao;

import java.sql.*;
import model.CandidateProfile;

public class ProfileDAO extends BaseDAO {
    
    public void insert(CandidateProfile p) {
        try {
            String sql = "INSERT INTO CandidateProfiles " +
                         "(UserId, FullName, Title, Phone, Location, AboutMe, AvatarUrl, CVUrl) " +
                         "VALUES (?,?,?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, p.getUserId());
            ps.setString(2, p.getFullName());
            ps.setString(3, p.getTitle());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getLocation());
            ps.setString(6, p.getAboutMe());
            ps.setString(7, p.getAvatarUrl());
            ps.setString(8, p.getCvUrl());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public CandidateProfile getByUserId(int userId) {
        try {
            String sql = "SELECT * FROM CandidateProfiles WHERE UserId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CandidateProfile p = new CandidateProfile();
                p.setId(rs.getInt("Id"));
                p.setUserId(userId);
                p.setFullName(rs.getString("FullName"));
                p.setTitle(rs.getString("Title"));
                p.setPhone(rs.getString("Phone"));
                p.setLocation(rs.getString("Location"));
                p.setAboutMe(rs.getString("AboutMe"));
                p.setAvatarUrl(rs.getString("AvatarUrl"));
                p.setCvUrl(rs.getString("CVUrl"));
                return p;
            }
        } catch (Exception e) {}
        return null;
    }
    
    public void update(CandidateProfile p) {
        try {
            String sql = "UPDATE CandidateProfiles SET FullName=?, Title=?, Phone=?, Location=?, AboutMe=?, AvatarUrl=?, CVUrl=? WHERE UserId=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, p.getFullName());
            ps.setString(2, p.getTitle());
            ps.setString(3, p.getPhone());
            ps.setString(4, p.getLocation());
            ps.setString(5, p.getAboutMe());
            ps.setString(6, p.getAvatarUrl());
            ps.setString(7, p.getCvUrl());
            ps.setInt(8, p.getUserId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}