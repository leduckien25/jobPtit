package dao;

import java.sql.*;
import java.util.*;
import model.Job;

public class JobDAO extends BaseDAO {

    public List<Job> getAll() {
        List<Job> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Jobs";
            ResultSet rs = conn.createStatement().executeQuery(sql);

            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("Id"));
                j.setTitle(rs.getString("Title"));
                j.setDescription(rs.getString("Description"));
                j.setLocation(rs.getString("Location"));
                list.add(j);
            }
        } catch (Exception e) {}
        return list;
    }

}