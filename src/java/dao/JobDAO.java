   package dao;

import data.DBUtils;
import models.Job;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {
   public List<Job> getAllJobs() {
      List<Job> list = new ArrayList();
      String sql = "SELECT * FROM Jobs ORDER BY CreatedAt DESC";

      try {
         Connection conn = DBUtils.getConnection();

         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

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
                     job.setNegotiable(rs.getInt("IsNegotiable"));
                     Date sqlDate = rs.getDate("ExpiredAt");
                     if (sqlDate != null) {
                        job.setDeadline(sqlDate.toLocalDate());
                     } else {
                        job.setDeadline((LocalDate)null);
                     }
                  }
               } catch (Throwable var11) {
                  if (rs != null) {
                     try {
                        rs.close();
                     } catch (Throwable var10) {
                        var11.addSuppressed(var10);
                     }
                  }

                  throw var11;
               }

               if (rs != null) {
                  rs.close();
               }
            } catch (Throwable var12) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (Throwable var9) {
                     var12.addSuppressed(var9);
                  }
               }

               throw var12;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (Throwable var13) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (Throwable var8) {
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

   public Job getJobById(int id) {
      String sql = "SELECT * FROM Jobs WHERE Id = ?";
      Job job = null;

      try {
         Connection conn = DBUtils.getConnection();

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
                     job.setNegotiable(rs.getInt("IsNegotiable"));
                     Date sqlDate = rs.getDate("ExpiredAt");
                     if (sqlDate != null) {
                        job.setDeadline(sqlDate.toLocalDate());
                     } else {
                        job.setDeadline((LocalDate)null);
                     }

                     System.out.println(job.toString());
                  }
               } catch (Throwable var12) {
                  if (rs != null) {
                     try {
                        rs.close();
                     } catch (Throwable var11) {
                        var12.addSuppressed(var11);
                     }
                  }

                  throw var12;
               }

               if (rs != null) {
                  rs.close();
               }
            } catch (Throwable var13) {
               if (pstmt != null) {
                  try {
                     pstmt.close();
                  } catch (Throwable var10) {
                     var13.addSuppressed(var10);
                  }
               }

               throw var13;
            }

            if (pstmt != null) {
               pstmt.close();
            }
         } catch (Throwable var14) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (Throwable var9) {
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
      String sql = "INSERT INTO Jobs (Title, Location, Description, SalaryMin, SalaryMax, JobType, Status, CategoryId, IsNegotiable, ExpiredAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

      try {
         Connection conn = DBUtils.getConnection();

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
               pstmt.setInt(9, job.getNegotiable());
               pstmt.setDate(10, job.getDeadline() != null ? Date.valueOf(job.getDeadline()) : null);
               var5 = pstmt.executeUpdate() > 0;
            } catch (Throwable var9) {
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
         } catch (Throwable var10) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (Throwable var7) {
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
         Connection conn = DBUtils.getConnection();

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
               pstmt.setInt(9, job.getNegotiable());
               pstmt.setDate(10, job.getDeadline() != null ? Date.valueOf(job.getDeadline()) : null);
               pstmt.setInt(11, job.getId());
               var5 = pstmt.executeUpdate() > 0;
            } catch (Throwable var9) {
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
         } catch (Throwable var10) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (Throwable var7) {
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
         Connection conn = DBUtils.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setInt(1, id);
               var5 = pstmt.executeUpdate() > 0;
            } catch (Throwable var9) {
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
         } catch (Throwable var10) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (Throwable var7) {
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

   public List<Job> searchJobsPaging(String title, String location, int page, int pageSize) {
      List<Job> list = new ArrayList();
      String sql = "SELECT * FROM jobs WHERE title LIKE ? AND location LIKE ? ORDER BY createdAt DESC LIMIT ? OFFSET ?";
      String queryTitle = title == null ? "%%" : "%" + title + "%";
      String queryLoc = location == null ? "%%" : "%" + location + "%";
      int offset = (page - 1) * pageSize;

      try {
         Connection conn = DBUtils.getConnection();

         try {
            PreparedStatement ps = conn.prepareStatement(sql);

            try {
               ps.setString(1, queryTitle);
               ps.setString(2, queryLoc);
               ps.setInt(3, pageSize);
               ps.setInt(4, offset);

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
                  job.setNegotiable(rs.getInt("IsNegotiable"));
                  job.setCreatedAt(rs.getDate("CreatedAt").toLocalDate());
                  Date sqlDate = rs.getDate("ExpiredAt");
                  if (sqlDate != null) {
                     job.setDeadline(sqlDate.toLocalDate());
                  } else {
                     job.setDeadline((LocalDate)null);
                  }
               }
            } catch (Throwable var17) {
               if (ps != null) {
                  try {
                     ps.close();
                  } catch (Throwable var16) {
                     var17.addSuppressed(var16);
                  }
               }

               throw var17;
            }

            if (ps != null) {
               ps.close();
            }
         } catch (Throwable var18) {
            if (conn != null) {
               try {
                  conn.close();
               } catch (Throwable var15) {
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

   public int getTotalJobs(String title, String location) {
      String sql = "SELECT COUNT(*) FROM jobs WHERE title LIKE ? AND location LIKE ?";
      String queryTitle = title == null ? "%%" : "%" + title + "%";
      String queryLoc = location == null ? "%%" : "%" + location + "%";

      try {
         Connection conn = DBUtils.getConnection();

         int var9;
         label98: {
            try {
               PreparedStatement ps = conn.prepareStatement(sql);

               label88: {
                  try {
                     ps.setString(1, queryTitle);
                     ps.setString(2, queryLoc);
                     ResultSet rs = ps.executeQuery();
                     if (!rs.next()) {
                        break label88;
                     }

                     var9 = rs.getInt(1);
                  } catch (Throwable var12) {
                     if (ps != null) {
                        try {
                           ps.close();
                        } catch (Throwable var11) {
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
                  } catch (Throwable var10) {
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
            Connection conn = DBUtils.getConnection();
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