/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.DBConnection;
import model.Company;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {
    private Company mapRow(ResultSet rs) throws SQLException {
        Company c = new Company();
        c.setId(rs.getInt("Id"));
        c.setName(rs.getString("Name"));
        c.setLocation(rs.getString("Location"));
        c.setLogoUrl(rs.getString("LogoUrl"));
        c.setDescription(rs.getString("Description"));
        c.setOwnerUserId(rs.getInt("OwnerUserId"));
        c.setCreatedAt(rs.getTimestamp("CreatedAt"));
        c.setIsVerified(rs.getInt("IsVerified"));
        return c;
    }

    // Hàm hỗ trợ truyền tham số động 
    private void setParameters(PreparedStatement ps, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
    }
    
    public boolean insert(Company c) {
        String sql = "INSERT INTO Companies (Name, Location, LogoUrl, Description, OwnerUserId, IsVerified) VALUES (?, ?, ?, ?, ?, 0)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.setString(2, c.getLocation());
            ps.setString(3, c.getLogoUrl());
            ps.setString(4, c.getDescription());
            ps.setInt(5, c.getOwnerUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public Company findById(int id) {
        String sql = "SELECT * FROM Companies WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Company findByOwnedId(int id) {
        String sql = "SELECT * FROM Companies WHERE OwnerUserId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean approve(int id) {
        String sql = "UPDATE Companies SET IsVerified = 1 WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean reject(int id) {
        String sql = "UPDATE Companies SET IsVerified = 2 WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Company> findPaged(String keyword, Integer isVerified, int page, int pageSize) {
        List<Company> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Companies WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (Name LIKE ? OR Location LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        
        if (isVerified != null) {
            sql.append(" AND IsVerified = ?");
            params.add(isVerified);
        }
        
        sql.append(" ORDER BY CreatedAt DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            setParameters(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public int countPaged(String keyword, Integer isVerified) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Companies WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (Name LIKE ? OR Location LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        
        if (isVerified != null) {
            sql.append(" AND IsVerified = ?");
            params.add(isVerified);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            setParameters(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int countByStatus(int isVerified){
        String sql = "SELECT COUNT(*) FROM Companies WHERE IsVerified = ?";
        try(Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){
            
            ps.setInt(1, isVerified);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
     public Company getByUserId(int id) {
        try {
            String sql = "SELECT * FROM Companies WHERE OwnerUserId=?";
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Company c = new Company();
                c.setId(id);
                c.setName(rs.getString("Name"));
                c.setDescription(rs.getString("Description"));
                c.setLocation(rs.getString("Location"));
                c.setLogoUrl(rs.getString("LogoUrl"));
                c.setOwnerUserId(rs.getInt("OwnerUserId"));
                c.setIsVerified(rs.getInt("IsVerified"));
//                c.setYearsExperience(rs.getInt("YearsExperience"));
//                c.setProjectsCount(rs.getInt("ProjectsCount"));
//                c.setCountriesCount(rs.getInt("CountriesCount"));
//                c.setTechStack(rs.getString("TechStack"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
