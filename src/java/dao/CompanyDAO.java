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
                return c;
            }
        } catch (Exception e) {}
        return null;
    }
}