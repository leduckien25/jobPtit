/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import Filter.JobFilter;
import config.DBConnection;

import model.Job;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Company;
import java.sql.Timestamp;
import java.time.LocalDateTime;


public class JobDAO {
    private Job mapRow(ResultSet rs) throws SQLException {
        Job j = new Job();
        j.setId(rs.getInt("Id"));
        j.setTitle(rs.getString("Title"));
        j.setDescription(rs.getString("Description"));
        j.setLocation(rs.getString("Location"));
        
        // Xử lý Integer có thể NULL
        j.setSalaryMin((Integer) rs.getObject("SalaryMin"));
        j.setSalaryMax((Integer) rs.getObject("SalaryMax"));
        j.setIsNegotiable(rs.getBoolean("IsNegotiable"));
        
        j.setJobType(rs.getInt("JobType"));
        j.setStatus(rs.getInt("Status"));
        
        j.setCategoryId(rs.getInt("CategoryId"));
        j.setCompanyId(rs.getInt("CompanyId"));
        j.setCreatedByUserId(rs.getInt("CreatedByUserId"));
        j.setViewsCount(rs.getInt("ViewsCount"));
        
        j.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
        j.setExpiredAt(rs.getTimestamp("ExpiredAt").toLocalDateTime());
        
        
        try { j.setCompanyName(rs.getString("CompanyName")); } catch (Exception e) {}
        try { j.setCompanyLogo(rs.getString("CompanyLogo")); } catch (Exception e) {}
        
        return j;
    }
    
    public List<Job> findPaged(String keyword, Integer status, int page, int pageSize) {
        List<Job> list = new ArrayList<>();
        // Lệnh JOIN để lấy tên công ty
        StringBuilder sql = new StringBuilder(
            "SELECT j.*, c.Name AS CompanyName, c.LogoUrl AS CompanyLogo " +
            "FROM Jobs j " +
            "JOIN Companies c ON j.CompanyId = c.Id WHERE 1=1"
        );
        //Tạo List để đựng các giá trị nhét vào dấu chấm hỏi (?)
        List<Object> params = new ArrayList<>();
        
        //Tìm kiếm theo từ khóa
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (j.Title LIKE ? OR c.Name LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        //Lọc trạng thái
        if (status != null) {
            sql.append(" AND j.Status = ?");
            params.add(status);
        }
        
        sql.append(" ORDER BY j.CreatedAt DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        //Thực thị câu truy vấn
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
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

    // Đếm tổng số bài đăng (để làm phân trang)
    public int countPaged(String keyword, Integer status) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM Jobs j JOIN Companies c ON j.CompanyId = c.Id WHERE 1=1"
        );
        //Tạo List để đựng các giá trị nhét vào dấu chấm hỏi (?)
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (j.Title LIKE ? OR c.Name LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (status != null) {
            sql.append(" AND j.Status = ?");
            params.add(status);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Job findById(int id) {
        String sql = "SELECT j.*, c.Name AS CompanyName, c.LogoUrl AS CompanyLogo " +
                     "FROM Jobs j JOIN Companies c ON j.CompanyId = c.Id WHERE j.Id = ?";
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
        String sql = "UPDATE Jobs SET Status = 1 WHERE Id = ?";
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
        String sql = "UPDATE Jobs SET Status = 3 WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Job> getJobs(String jobKeyword, String categorySlug, String location) throws ClassNotFoundException, SQLException {
        List<Job> jobs = new ArrayList<>();

        String query = "SELECT J.*, J.id AS JobId, C.id AS CompanyId, C.NAME AS CompanyName, C.LOGOURL " +
                       "FROM JOBS J " +
                       "JOIN COMPANIES C ON J.COMPANYID = C.ID " +
                       "JOIN CATEGORIES CT ON J.CATEGORYID = CT.ID " +
                       "WHERE J.Status = 1 AND C.IsVerified = 1 AND (CT.SLUG = ? OR ? = 'All') " + 
                       "  AND J.LOCATION LIKE ? " +
                       "  AND J.TITLE LIKE ?";

        try (Connection conn = new DBConnection().getConnection();
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
                    job.setIsNegotiable(rs.getBoolean("IsNegotiable"));
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
                "WHERE J.Status = 1 AND C.IsVerified = 1 "
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

        try (Connection conn = new DBConnection().getConnection();
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

                    job.setIsNegotiable(rs.getBoolean("IsNegotiable"));
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
    
    public void IncrementViewsCount(int jobId) throws ClassNotFoundException, SQLException {
    String sql = "UPDATE Jobs SET ViewsCount = ViewsCount + 1 WHERE Id = ?";
    
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        if (conn == null) {
            throw new SQLException("DBConnection returned a null connection");
        }
        
        ps.setInt(1, jobId);
        ps.executeUpdate();
        }
    }
    
    public List<Job> getRecentJobs(int size) throws SQLException, ClassNotFoundException{
        Connection conn = (new DBConnection()).getConnection();
        
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
"WHERE j.Status = 1 AND c.IsVerified = 1 \n" +
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
            job.setIsNegotiable(rs.getBoolean("IsNegotiable"));

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
                "WHERE Status = 1 "
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

        try (Connection conn = new DBConnection().getConnection();
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
                       "WHERE J.Status = 1 AND C.IsVerified = 1 AND J.Id = ?";

        Connection conn = new DBConnection().getConnection();
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setInt(1, jobId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Job job = new Job();
            job.setId(rs.getInt("JobId"));
            job.setTitle(rs.getString("Title"));

            job.setSalaryMin((Integer) rs.getObject("SalaryMin"));
            job.setSalaryMax((Integer) rs.getObject("SalaryMax"));
            job.setIsNegotiable(rs.getBoolean("IsNegotiable"));
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
