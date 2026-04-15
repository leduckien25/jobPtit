/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import config.DBConnection;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.ApplicationDetail;

import model.CandidateProfile;

public class CandidateDAO {
    public List<ApplicationDetail> getApplicationsByJobId(int jobId) {
        List<ApplicationDetail> list = new ArrayList<>();
        String sql = "SELECT a.Id AS AppId, a.Status, a.AppliedAt, u.Email, " +
                    "cp.FullName, cp.Title, cp.Phone, cp.Location, cp.AboutMe, cp.AvatarUrl, cp.CVUrl " +
                    "FROM Applications a " +
                    "JOIN Users u ON a.UserId = u.Id " +
                    "LEFT JOIN CandidateProfiles cp ON u.Id = cp.UserId " + // Dùng LEFT JOIN ở đây
                    "WHERE a.JobId = ? " +
                    "ORDER BY a.AppliedAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ApplicationDetail ad = new ApplicationDetail();
                ad.setAppId(rs.getInt("AppId"));
                ad.setStatus(rs.getInt("Status"));
                ad.setAppliedAt(rs.getTimestamp("AppliedAt").toLocalDateTime());
                ad.setEmail(rs.getString("Email"));

                // Tạo đối tượng CandidateProfile từ model bạn đã có
                CandidateProfile cp = new CandidateProfile();
                cp.setFullName(rs.getString("FullName"));
                cp.setTitle(rs.getString("Title"));
                cp.setPhone(rs.getString("Phone"));
                cp.setLocation(rs.getString("Location"));
                cp.setAboutMe(rs.getString("AboutMe"));
                cp.setAvatarUrl(rs.getString("AvatarUrl"));
                cp.setCvUrl(rs.getString("CVUrl"));

                ad.setProfile(cp);
                list.add(ad);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public String getJobTitleById(int jobId) {
        String sql = "SELECT Title FROM Jobs WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("Title");
        } catch (Exception e) { e.printStackTrace(); }
        return "N/A";
    }
}
