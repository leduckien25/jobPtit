package dao;

import java.sql.*;
import model.Company;

public class CompanyDAO extends BaseDAO {

    public Company getById(int id) {
        try {
            String sql = "SELECT * FROM Companies WHERE Id=?";
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
                c.setIsVerified(rs.getBoolean("IsVerified"));
                c.setYearsExperience(rs.getInt("YearsExperience"));
                c.setProjectsCount(rs.getInt("ProjectsCount"));
                c.setCountriesCount(rs.getInt("CountriesCount"));
                c.setTechStack(rs.getString("TechStack"));
                return c;
            }
        } catch (Exception e) {}
        return null;
    }
}