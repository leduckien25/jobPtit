/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.JobFilter;
import util.DBContext;
import model.Job;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Category;
import model.Company;

/**
 *
 * @author ducki
 */
public class JobDao {
    public List<Job> getJobs() throws SQLException, ClassNotFoundException{
        Connection conn = (new DBContext()).getConnection();
        
        String query = "SELECT * FROM Jobs";
        
        PreparedStatement ps = conn.prepareStatement(query);
        
        ResultSet rs = ps.executeQuery();
        
        List<Job> jobs = new ArrayList<Job>();
        
        while(rs.next()){
            int id = rs.getInt("Id");
            String title = rs.getString("Title");
            String description = rs.getString("Description");
            String location = rs.getString("Location");

            Integer salaryMin = rs.getObject("SalaryMin") != null ? rs.getInt("SalaryMin") : null;
            Integer salaryMax = rs.getObject("SalaryMax") != null ? rs.getInt("SalaryMax") : null;

            boolean isNegotiable = rs.getBoolean("IsNegotiable");

            int jobType = rs.getInt("JobType");
            int status = rs.getInt("Status");
            int categoryId = rs.getInt("CategoryId");
            int companyId = rs.getInt("CompanyId");
            int createdByUserId = rs.getInt("CreatedByUserId");
            int viewsCount = rs.getInt("ViewsCount");

            LocalDateTime createdAt = rs.getTimestamp("CreatedAt").toLocalDateTime();
            LocalDateTime expiredAt = (rs.getTimestamp("ExpiredAt") != null) ? rs.getTimestamp("ExpiredAt").toLocalDateTime() : null; 
        
            Job job = new Job(id, title, description, location, salaryMin, salaryMax, 
                  isNegotiable, jobType, status, categoryId, companyId, 
                  createdByUserId, viewsCount, createdAt, expiredAt);
            
            jobs.add(job);
        }
        return jobs;
    }
    
    public List<Job> getJobs(String jobKeyword, String categorySlug, String location) throws ClassNotFoundException, SQLException {
        List<Job> jobs = new ArrayList<>();

        String query = "SELECT J.*, J.id AS JobId, C.id AS CompanyId, C.NAME AS CompanyName, C.LOGOURL " +
                       "FROM JOBS J " +
                       "JOIN COMPANIES C ON J.COMPANYID = C.ID " +
                       "JOIN CATEGORIES CT ON J.CATEGORYID = CT.ID " +
                       "WHERE (CT.SLUG = ? OR ? = 'All') " + 
                       "  AND J.LOCATION LIKE ? " +
                       "  AND J.TITLE LIKE ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            String searchCategory = (categorySlug == null) ? "All" : categorySlug;
            String searchLocation = (location == null || location.equals("All")) ? "" : location;
            String searchKeyword = (jobKeyword == null) ? "" : jobKeyword;

            ps.setString(1, searchCategory);
            ps.setString(2, searchCategory); 
            ps.setString(3, "%" + searchLocation + "%");
            ps.setString(4, "%" + searchKeyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Job job = new Job();
                    job.setId(rs.getInt("JobId"));
                    job.setTitle(rs.getString("Title"));

                    job.setSalaryMin((Integer) rs.getObject("SalaryMin"));
                    job.setSalaryMax((Integer) rs.getObject("SalaryMax"));
                    job.setNegotiable(rs.getBoolean("IsNegotiable"));
                    job.setLocation(rs.getString("Location"));

                    Company comp = new Company();
                    comp.setId(rs.getInt("CompanyId"));
                    comp.setName(rs.getString("CompanyName"));
                    comp.setLogoUrl(rs.getString("LogoUrl"));

                    job.setCompany(comp);

                    jobs.add(job);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return jobs;
    }
    
    public List<Job> getJobs(JobFilter filter) {
        List<Job> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT J.*, J.id AS JobId, C.id AS CompanyId, C.NAME AS CompanyName, C.LOGOURL " +
                "FROM JOBS J " +
                "JOIN COMPANIES C ON J.COMPANYID = C.ID " +
                "JOIN CATEGORIES CT ON J.CATEGORYID = CT.ID " +
                "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            sql.append("AND J.TITLE LIKE ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getLocation() != null && !filter.getLocation().isEmpty() && !filter.getLocation().equalsIgnoreCase("All")) {
            sql.append("AND J.LOCATION LIKE ? ");
            params.add("%" + filter.getLocation() + "%");
        }

        if (filter.getCategorySlug() != null && !filter.getCategorySlug().isEmpty() && !filter.getCategorySlug().equalsIgnoreCase("All")) {
            sql.append("AND CT.SLUG = ? ");
            params.add(filter.getCategorySlug());
        }
        
        if(filter.getSalaryRange() != null && filter.getSalaryRange().equals("negotiable")){
            sql.append("AND J.IsNegotiable = 1 ");
        }

        if (filter.getMinSalary() != null) {
            sql.append("AND J.SALARYMIN >= ? ");
            params.add(filter.getMinSalary());
        }
        
        if(filter.getMaxSalary() != null){
            sql.append("AND J.SALARYMAX <= ? ");
            params.add(filter.getMaxSalary());
        }

        List<String> types = filter.getJobType();
        if (types != null && !types.isEmpty()) {
            sql.append(" AND (");

            for (int i = 0; i < types.size(); i++) {
                sql.append("J.JOBTYPE = ?");
                params.add(types.get(i));

                if (i < types.size() - 1) {
                    sql.append(" OR ");
                }
            }

            sql.append(") "); 
        }

        if ("oldest".equalsIgnoreCase(filter.getSort())) {
            sql.append("ORDER BY J.CREATEDAT ASC ");
        } else {
            sql.append("ORDER BY J.CREATEDAT DESC ");
        }

        sql.append("LIMIT ? OFFSET ?");
        params.add(filter.getPageSize());
        int offset = (filter.getPage() - 1) * filter.getPageSize();
        params.add(offset);

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Job job = new Job();

                    job.setId(rs.getInt("JobId"));
                    job.setTitle(rs.getString("Title"));
                    job.setDescription(rs.getString("Description"));

                    job.setSalaryMin((Integer) rs.getObject("SalaryMin"));
                    job.setSalaryMax((Integer) rs.getObject("SalaryMax"));

                    job.setNegotiable(rs.getBoolean("IsNegotiable"));
                    job.setLocation(rs.getString("Location"));

                    job.setJobType(rs.getInt("JobType"));
                    job.setStatus(rs.getInt("Status"));

                    job.setCategoryId(rs.getInt("CategoryId")); 
                    job.setCreatedByUserId(rs.getInt("CreatedByUserId"));

                    job.setViewsCount(rs.getInt("ViewsCount"));

                    if (rs.getTimestamp("CreatedAt") != null) {
                        job.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                    }
                    if (rs.getTimestamp("ExpiredAt") != null) {
                        job.setExpiredAt(rs.getTimestamp("ExpiredAt").toLocalDateTime());
                    }

                    Company comp = new Company();
                    comp.setId(rs.getInt("CompanyId"));
                    comp.setName(rs.getString("CompanyName"));
                    comp.setLogoUrl(rs.getString("LogoUrl"));

                    job.setCompany(comp);

                    jobs.add(job);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }
    
    
    public List<Job> getRecentJobs(int size) throws SQLException, ClassNotFoundException{
        Connection conn = (new DBContext()).getConnection();
        
        String query = "SELECT \n" +
"    j.Id AS JobId, \n" +
"    j.Title, \n" +
"    j.Description, \n" +
"    j.Location AS JobLocation, \n" +
"    j.SalaryMin, \n" +
"    j.SalaryMax, \n" +
"    j.IsNegotiable, \n" +
"    j.CreatedAt AS JobCreatedAt,\n" +
"    c.Id AS CompanyId, \n" +
"    c.Name AS CompanyName, \n" +
"    c.LogoUrl \n" +
"FROM Jobs j \n" +
"JOIN Companies c ON j.CompanyId = c.Id \n" +
"WHERE j.Status = 1 -- Only show active jobs\n" +
"ORDER BY j.CreatedAt DESC \n" +
"LIMIT ?;";
        
        PreparedStatement ps = conn.prepareStatement(query);
        
        ps.setInt(1, size);
        
        ResultSet rs = ps.executeQuery();
        
        List<Job> jobs= new ArrayList<Job>();
        while(rs.next()){
            Job job = new Job();
            job.setId(rs.getInt("JobId"));
            job.setTitle(rs.getString("Title"));
            job.setSalaryMin((Integer) rs.getObject("SalaryMin"));
            job.setSalaryMax((Integer) rs.getObject("SalaryMax"));
            job.setNegotiable(rs.getBoolean("IsNegotiable"));

            Company comp = new Company();
            comp.setId(rs.getInt("CompanyId"));
            comp.setName(rs.getString("CompanyName"));
            comp.setLogoUrl(rs.getString("LogoUrl"));

            job.setCompany(comp);

            jobs.add(job);
        }
        
        return jobs;
    }

    public int countJobs(JobFilter filter) {
        List<Job> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) " +
                "FROM JOBS J " +
                "JOIN COMPANIES C ON J.COMPANYID = C.ID " +
                "JOIN CATEGORIES CT ON J.CATEGORYID = CT.ID " +
                "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            sql.append("AND J.TITLE LIKE ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getLocation() != null && !filter.getLocation().isEmpty() && !filter.getLocation().equalsIgnoreCase("All")) {
            sql.append("AND J.LOCATION LIKE ? ");
            params.add("%" + filter.getLocation() + "%");
        }

        if (filter.getCategorySlug() != null && !filter.getCategorySlug().isEmpty() && !filter.getCategorySlug().equalsIgnoreCase("All")) {
            sql.append("AND CT.SLUG = ? ");
            params.add(filter.getCategorySlug());
        }

        if (filter.getMinSalary() != null) {
            sql.append("AND J.SALARYMIN >= ? ");
            params.add(filter.getMinSalary());
        }
        
        if(filter.getMaxSalary() != null){
            sql.append("AND J.SALARYMAX <= ? ");
            params.add(filter.getMaxSalary());
        }

        List<String> types = filter.getJobType();
        if (types != null && !types.isEmpty()) {
            sql.append(" AND (");

            for (int i = 0; i < types.size(); i++) {
                sql.append("J.JOBTYPE = ?");
                params.add(types.get(i));

                if (i < types.size() - 1) {
                    sql.append(" OR ");
                }
            }

            sql.append(") "); 
        }

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) 
            {   rs.next();
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
        
    public Job getJob(int jobId) throws ClassNotFoundException, SQLException {
        String query = "SELECT J.*, J.id AS JobId, C.id AS CompanyId, C.NAME AS CompanyName, C.LOGOURL " +
                       "FROM JOBS J " +
                       "JOIN COMPANIES C ON J.COMPANYID = C.ID " +
                       "JOIN CATEGORIES CT ON J.CATEGORYID = CT.ID " +
                       "WHERE J.Id = ?";

        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setInt(1, jobId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Job job = new Job();
            job.setId(rs.getInt("JobId"));
            job.setTitle(rs.getString("Title"));

            job.setSalaryMin((Integer) rs.getObject("SalaryMin"));
            job.setSalaryMax((Integer) rs.getObject("SalaryMax"));
            job.setNegotiable(rs.getBoolean("IsNegotiable"));
            job.setLocation(rs.getString("Location"));
            job.setDescription(rs.getString("Description"));
            job.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());            

            Timestamp expiredTs = rs.getTimestamp("ExpiredAt");

            if (expiredTs != null) {
                job.setExpiredAt(expiredTs.toLocalDateTime());
            }
            
            Company comp = new Company();
            comp.setId(rs.getInt("CompanyId"));
            comp.setName(rs.getString("CompanyName"));
            comp.setLogoUrl(rs.getString("LogoUrl"));

            job.setCompany(comp);

            return job;
        }
        
        return null;
    }
}
