/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import util.DBContext;

/**
 *
 * @author ducki
 */
public class CategoryDao {
    public Map<Category, Integer> getOutstandingCategories(int limit) throws ClassNotFoundException, SQLException {
        Map<Category, Integer> catMap = new LinkedHashMap<>(); 

        String query = "SELECT c.id, c.name, c.slug, COUNT(j.id) AS TotalJobs " 
                    + "FROM categories c "
                    + "LEFT JOIN jobs j ON c.id = j.categoryid "
                    + "GROUP BY c.id, c.name, c.slug " 
                    + "ORDER BY TotalJobs DESC "
                    + "LIMIT ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("id")); 
                    category.setName(rs.getString("name"));
                    category.setSlug(rs.getString("slug"));

                    int totalJobs = rs.getInt("TotalJobs");
                    catMap.put(category, totalJobs);
                }
            }
        }
        return catMap;
    }
    
    public Map<Category, Integer> getCategoriesWithCount(){
        Map<Category, Integer> results = new LinkedHashMap<>();
            
        String query = "SELECT C.*, COUNT(J.Id) AS TotalJobs FROM Categories C LEFT JOIN Jobs J ON C.Id = J.CategoryId GROUP BY C.Id, C.Name;";

        try (Connection conn = new DBContext().getConnection()){
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery(); 

            while (rs.next()) {
                int id = rs.getInt("Id");
                String name = rs.getString("Name");
                String slug = rs.getString("Slug");
                
                Timestamp ts = rs.getTimestamp("CreatedAt");
                LocalDateTime createdAt = (ts != null) ? ts.toLocalDateTime() : LocalDateTime.now();
                
                int TotalJobs = rs.getInt("TotalJobs");
                
                results.put(new Category(id, name, slug, createdAt), TotalJobs);
            }

        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return results; 
    }

    
    public List<Category> getCategories() throws ClassNotFoundException, SQLException {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM Categories";

        try (Connection conn = new DBContext().getConnection()){
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery(); 

            while (rs.next()) {
                int id = rs.getInt("Id");
                String name = rs.getString("Name");
                String slug = rs.getString("Slug");
                
                Timestamp ts = rs.getTimestamp("CreatedAt");
                LocalDateTime createdAt = (ts != null) ? ts.toLocalDateTime() : LocalDateTime.now();

                categories.add(new Category(id, name, slug, createdAt));
            }

        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return categories;
    }
}
