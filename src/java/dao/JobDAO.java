/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import filter.JobFilter;
import config.DBConnection;

import model.Job;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Company;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashSet;
import java.util.Set;


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
    public List<Job> getAllJobs(int id) {
      List<Job> list = new ArrayList();
      String sql = "SELECT * FROM Jobs WHERE CompanyId = ? ORDER BY CreatedAt DESC";

      try {
         Connection conn = DBConnection.getConnection();

         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            try {
               ResultSet rs = pstmt.executeQuery();
               Job job;
               try {
                  for(; rs.next(); list.add(job)) {
                     job = new Job();
                     job.setId(rs.getInt("Id"));
                     job.setTitle(rs.getString("Title"));
                     job.setLocation(rs.getString("Location"));
                     job.setSalaryMin(rs.getInt("SalaryMin"));
                     job.setSalaryMax(rs.getInt("SalaryMax"));
                     job.setJobType(rs.getInt("JobType"));
                     job.setStatus(rs.getInt("Status"));
                     job.setCategoryId(rs.getInt("CategoryId"));
                     job.setDescription(rs.getString("Description"));
                     job.setIsNegotiable(rs.getBoolean("IsNegotiable"));
                     Timestamp sqlDate = rs.getTimestamp("ExpiredAt");
                     if (sqlDate != null) {
                        job.setExpiredAt(sqlDate.toLocalDateTime());
                     } else {
                        job.setExpiredAt(null);
                     }
                  }
               } catch (SQLException var11) {
                  if (rs != null) {
                     try {
                        rs.close();
                     } catch (SQLException var10) {
                        var11.addSuppressed(var10);
                     }
                  }

                  throw var11;
               }

               if (rs != null) {
                  rs.close();
               }
            } catch (SQLException var12) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (SQLException var9) {
                     var12.addSuppressed(var9);
                  }
               }

               throw var12;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (SQLException var13) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (SQLException var8) {
                  var13.addSuppressed(var8);
               }
            }

            throw var13;
         }

         if (conn != null) {
            conn.close();
         }
      } catch (SQLException var14) {
         var14.printStackTrace();
      }

      return list;
   }
    public int getTotalViewsByCompany(int companyId) {
     String sql = "SELECT SUM(ViewsCount) AS TotalViews FROM Jobs WHERE CompanyId = ?";
     int totalViews = 0;

     // Sử dụng try-with-resources để tự động đóng Connection, PreparedStatement và ResultSet
     try (Connection conn = DBConnection.getConnection();
          PreparedStatement pstmt = conn.prepareStatement(sql)) {

         pstmt.setInt(1, companyId);

         try (ResultSet rs = pstmt.executeQuery()) {
             if (rs.next()) {
                 totalViews = rs.getInt("TotalViews");
             }
         }
     } catch (SQLException e) {
         e.printStackTrace();
     }

     return totalViews;
 }
   public Job getJobById(int id) {
      String sql = "SELECT * FROM Jobs WHERE Id = ?";
      Job job = null;

      try {
         Connection conn = DBConnection.getConnection();

         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setInt(1, id);
               ResultSet rs = pstmt.executeQuery();

               try {
                  if (rs.next()) {
                     job = new Job();
                     job.setId(rs.getInt("Id"));
                     job.setTitle(rs.getString("Title"));
                     job.setLocation(rs.getString("Location"));
                     job.setSalaryMin(rs.getInt("SalaryMin"));
                     job.setSalaryMax(rs.getInt("SalaryMax"));
                     job.setJobType(rs.getInt("JobType"));
                     job.setStatus(rs.getInt("Status"));
                     job.setCategoryId(rs.getInt("CategoryId"));
                     job.setDescription(rs.getString("Description"));
                     job.setIsNegotiable(rs.getBoolean("IsNegotiable"));
                     Timestamp sqlDate = rs.getTimestamp("ExpiredAt");
                     if (sqlDate != null) {
                        job.setExpiredAt(sqlDate.toLocalDateTime());
                     } else {
                        job.setExpiredAt(null);
                     }

                     System.out.println(job.toString());
                  }
               } catch (SQLException var12) {
                  if (rs != null) {
                     try {
                        rs.close();
                     } catch (SQLException var11) {
                        var12.addSuppressed(var11);
                     }
                  }

                  throw var12;
               }

               if (rs != null) {
                  rs.close();
               }
            } catch (SQLException var13) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (SQLException var10) {
                     var13.addSuppressed(var10);
                  }
               }

               throw var13;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (SQLException var14) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (SQLException var9) {
                  var14.addSuppressed(var9);
               }
            }

            throw var14;
         }

         if (conn != null) {
            conn.close();
         }
      } catch (SQLException var15) {
         var15.printStackTrace();
      }

      return job;
   }

   public boolean insertJob(Job job) {
      String sql = "INSERT INTO Jobs (Title, Location, Description, SalaryMin, SalaryMax, JobType, Status, CategoryId, IsNegotiable, ExpiredAt, CompanyId, CreatedByUserId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

      try {
         Connection conn = DBConnection.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setString(1, job.getTitle());
               pstmt.setString(2, job.getLocation());
               pstmt.setString(3, job.getDescription());
               pstmt.setInt(4, job.getSalaryMin());
               pstmt.setInt(5, job.getSalaryMax());
               pstmt.setInt(6, job.getJobType());
               pstmt.setInt(7, job.getStatus());
               pstmt.setInt(8, job.getCategoryId());
               pstmt.setBoolean(9, job.getIsNegotiable());
               pstmt.setTimestamp(10, job.getExpiredAt()!= null ? Timestamp.valueOf(job.getExpiredAt()) : null);
               pstmt.setInt(11, job.getCompanyId());
               pstmt.setInt(12, job.getCreatedByUserId());
               var5 = pstmt.executeUpdate() > 0;
            } catch (SQLException var9) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (Throwable var8) {
                     var9.addSuppressed(var8);
                  }
               }

               throw var9;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (SQLException var10) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (SQLException var7) {
                  var10.addSuppressed(var7);
               }
            }

            throw var10;
         }

         if (conn != null) {
            conn.close();
         }

         return var5;
      } catch (SQLException var11) {
         var11.printStackTrace();
         return false;
      }
   }

   public boolean updateJob(Job job) {
      String sql = "UPDATE Jobs SET Title = ?, Location = ?, SalaryMin = ?, SalaryMax = ?, JobType = ?, Status = ?, CategoryId = ?, Description = ?, IsNegotiable = ?, ExpiredAt=? WHERE Id = ?";

      try {
         Connection conn = DBConnection.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setString(1, job.getTitle());
               pstmt.setString(2, job.getLocation());
               pstmt.setInt(3, job.getSalaryMin());
               pstmt.setInt(4, job.getSalaryMax());
               pstmt.setInt(5, job.getJobType());
               pstmt.setInt(6, job.getStatus());
               pstmt.setInt(7, job.getCategoryId());
               pstmt.setString(8, job.getDescription());
               pstmt.setBoolean(9, job.getIsNegotiable());
               pstmt.setDate(10, job.getExpiredAt()!= null ? Date.valueOf(job.getExpiredAt().toLocalDate()) : null);
               pstmt.setInt(11, job.getId());
               var5 = pstmt.executeUpdate() > 0;
            } catch (SQLException var9) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (SQLException var8) {
                     var9.addSuppressed(var8);
                  }
               }

               throw var9;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (Throwable var10) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (SQLException var7) {
                  var10.addSuppressed(var7);
               }
            }

            throw var10;
         }

         if (conn != null) {
            conn.close();
         }

         return var5;
      } catch (SQLException var11) {
         var11.printStackTrace();
         return false;
      }
   }

   public boolean deleteJob(int id) {
      String sql = "DELETE FROM Jobs WHERE Id = ?";

      try {
         Connection conn = DBConnection.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setInt(1, id);
               var5 = pstmt.executeUpdate() > 0;
            } catch (SQLException var9) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (SQLException var8) {
                     var9.addSuppressed(var8);
                  }
               }

               throw var9;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (SQLException var10) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (SQLException var7) {
                  var10.addSuppressed(var7);
               }
            }

            throw var10;
         }

         if (conn != null) {
            conn.close();
         }

         return var5;
      } catch (SQLException var11) {
         var11.printStackTrace();
         return false;
      }
   }

   public List<Job> searchJobsPaging(String title, String location, int page, int pageSize, int id) {
      List<Job> list = new ArrayList();
      String sql = "SELECT * FROM jobs WHERE CompanyId =? AND title LIKE ? AND location LIKE ? ORDER BY createdAt DESC LIMIT ? OFFSET ?";
      String queryTitle = title == null ? "%%" : "%" + title + "%";
      String queryLoc = location == null ? "%%" : "%" + location + "%";
      int offset = (page - 1) * pageSize;

      try {
         Connection conn = DBConnection.getConnection();

         try {
            PreparedStatement ps = conn.prepareStatement(sql);

            try {
               ps.setInt(1, id);
               ps.setString(2, queryTitle);
               ps.setString(3, queryLoc);
               ps.setInt(4, pageSize);
               ps.setInt(5, offset);

               Job job;
               for(ResultSet rs = ps.executeQuery(); rs.next(); list.add(job)) {
                  job = new Job();
                  job.setId(rs.getInt("Id"));
                  job.setTitle(rs.getString("Title"));
                  job.setLocation(rs.getString("Location"));
                  job.setSalaryMin(rs.getInt("SalaryMin"));
                  job.setSalaryMax(rs.getInt("SalaryMax"));
                  job.setJobType(rs.getInt("JobType"));
                  job.setStatus(rs.getInt("Status"));
                  job.setCategoryId(rs.getInt("CategoryId"));
                  job.setDescription(rs.getString("Description"));
                  job.setIsNegotiable(rs.getBoolean("IsNegotiable"));
                  job.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                  job.setViewsCount(rs.getInt("ViewsCount"));
                  
                   Timestamp sqlDate= rs.getTimestamp("ExpiredAt");
                  if (sqlDate != null) {
                     job.setExpiredAt(sqlDate.toLocalDateTime());
                  } else {
                     job.setExpiredAt(null);
                  }
               }
            } catch (SQLException var17) {
               if (ps != null) {
                  try {
                     ps.close();
                  } catch (SQLException var16) {
                     var17.addSuppressed(var16);
                  }
               }

               throw var17;
            }

            if (ps != null) {
               ps.close();
            }
         } catch (SQLException var18) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (SQLException var15) {
                  var18.addSuppressed(var15);
               }
            }

            throw var18;
         }

         if (conn != null) {
            conn.close();
         }
      } catch (Exception var19) {
         var19.printStackTrace();
      }

      return list;
   }

   public int getTotalJobs(String title, String location, int id) {
      String sql = "SELECT COUNT(*) FROM jobs WHERE CompanyId = ? AND title LIKE ? AND location LIKE ?";
      String queryTitle = title == null ? "%%" : "%" + title + "%";
      String queryLoc = location == null ? "%%" : "%" + location + "%";

      try {
         Connection conn = DBConnection.getConnection();

         int var9;
         label98: {
            try {
               PreparedStatement ps = conn.prepareStatement(sql);

               label88: {
                  try {
                     ps.setInt(1, id);
                     ps.setString(2, queryTitle);
                     ps.setString(3, queryLoc);
                     ResultSet rs = ps.executeQuery();
                     if (!rs.next()) {
                        break label88;
                     }

                     var9 = rs.getInt(1);
                  } catch (SQLException var12) {
                     if (ps != null) {
                        try {
                           ps.close();
                        } catch (SQLException var11) {
                           var12.addSuppressed(var11);
                        }
                     }

                     throw var12;
                  }

                  if (ps != null) {
                     ps.close();
                  }
                  break label98;
               }

               if (ps != null) {
                  ps.close();
               }
            } catch (Throwable var13) {
               if (conn != null) {
                  try {
                     conn.close();
                  } catch (SQLException var10) {
                     var13.addSuppressed(var10);
                  }
               }

               throw var13;
            }

            if (conn != null) {
               conn.close();
            }

            return 0;
         }

         if (conn != null) {
            conn.close();
         }

         return var9;
      } catch (Exception var14) {
         var14.printStackTrace();
         return 0;
      }
   }
    public List<Job> getAll() {
        List<Job> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Jobs";
            ResultSet rs = conn.createStatement().executeQuery(sql);

            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("Id"));
                j.setCompanyId(rs.getInt("CompanyId"));
                j.setTitle(rs.getString("Title"));
                j.setDescription(rs.getString("Description"));
                j.setLocation(rs.getString("Location"));
                list.add(j);
            }
        } catch (Exception e) {}
        return list;
    }
}
