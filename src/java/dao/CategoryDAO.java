
package dao;

import config.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Category;

/**
 *
 * @author ducki
 */
public class CategoryDAO {
    public Map<Category, Integer> getOutstandingCategories(int limit) throws ClassNotFoundException, SQLException {
        Map<Category, Integer> catMap = new LinkedHashMap<>(); 

        String query = "SELECT c.id, c.name, c.slug, COUNT(j.id) AS TotalJobs " 
                    + "FROM categories c "
                    + "LEFT JOIN jobs j ON c.id = j.categoryid AND j.Status = 1 "
                    + "GROUP BY c.id, c.name, c.slug " 
                    + "ORDER BY TotalJobs DESC "
                    + "LIMIT ?";

        try (Connection conn = new DBConnection().getConnection();
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
            
        String query = "SELECT C.*, COUNT(J.Id) AS TotalJobs FROM Categories C LEFT JOIN Jobs J ON C.Id = J.CategoryId AND J.Status=1  GROUP BY C.Id, C.Name;";

        try (Connection conn = new DBConnection().getConnection()){
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

        try (Connection conn = new DBConnection().getConnection()){
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
    public List<Category> getAllCategories() {
      List<Category> list = new ArrayList();
      String sql = "SELECT * FROM Categories";

      try {
         Connection conn = DBConnection.getConnection();

         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               ResultSet rs = pstmt.executeQuery();

               try {
                  while(rs.next()) {
                     Category category = new Category();
                     category.setId(rs.getInt("Id"));
                     category.setName(rs.getString("Name"));
                     list.add(category);
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

   public Category getCategoryById(int id) {
      String sql = "SELECT * FROM Categories WHERE Id = ?";
      Category category = null;

      try {
         Connection conn = DBConnection.getConnection();

         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setInt(1, id);
               ResultSet rs = pstmt.executeQuery();

               try {
                  if (rs.next()) {
                     category = new Category();
                     category.setId(rs.getInt("Id"));
                     category.setName(rs.getString("Name"));
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

      return category;
   }

   public boolean insertCategory(Category category) {
      String sql = "INSERT INTO Categories (Name) VALUES (?)";

      try {
         Connection conn = DBConnection.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setString(1, category.getName());
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

   public boolean updateCategory(Category category) {
      String sql = "UPDATE Categories SET Name = ? WHERE Id = ?";

      try {
         Connection conn = DBConnection.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setString(1, category.getName());
               pstmt.setInt(2, category.getId());
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

   public boolean deleteCategory(int id) {
      String sql = "DELETE FROM Categories WHERE Id = ?";

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
}