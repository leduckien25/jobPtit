package dao;

import config.DBConnection;
import java.sql.*;
import model.CandidateProfile;

public class ProfileDAO {

    public void insert(CandidateProfile p) {
        String sql = "INSERT INTO CandidateProfiles (UserId, FullName, Title, Phone, Location, AboutMe, AvatarUrl, CVUrl) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getUserId());
            ps.setString(2, p.getFullName());
            ps.setString(3, p.getTitle());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getLocation());
            ps.setString(6, p.getAboutMe());
            ps.setString(7, p.getAvatarUrl());
            ps.setString(8, p.getCvUrl());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public CandidateProfile getByUserId(int userId) {
        String sql = "SELECT * FROM CandidateProfiles WHERE UserId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CandidateProfile p = new CandidateProfile();
                    p.setId(rs.getInt("Id"));
                    p.setUserId(rs.getInt("UserId"));
                    p.setFullName(rs.getString("FullName"));
                    p.setTitle(rs.getString("Title"));
                    p.setPhone(rs.getString("Phone"));
                    p.setLocation(rs.getString("Location"));
                    p.setAboutMe(rs.getString("AboutMe"));
                    p.setAvatarUrl(rs.getString("AvatarUrl"));
                    p.setCvUrl(rs.getString("CVUrl"));
                    return p;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void update(CandidateProfile p) {
        String sql = "UPDATE CandidateProfiles SET FullName=?, Title=?, Phone=?, Location=?, AboutMe=?, AvatarUrl=?, CVUrl=? WHERE UserId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getFullName());
            ps.setString(2, p.getTitle());
            ps.setString(3, p.getPhone());
            ps.setString(4, p.getLocation());
            ps.setString(5, p.getAboutMe());
            ps.setString(6, p.getAvatarUrl());
            ps.setString(7, p.getCvUrl());
            ps.setInt(8, p.getUserId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}