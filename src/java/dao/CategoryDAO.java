 package dao;

import data.DBUtils;
import models.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
   public List<Category> getAllCategories() {
      List<Category> list = new ArrayList();
      String sql = "SELECT * FROM Categories";

      try {
         Connection conn = DBUtils.getConnection();

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
         Connection conn = DBUtils.getConnection();

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
         Connection conn = DBUtils.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setString(1, category.getName());
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

   public boolean updateCategory(Category category) {
      String sql = "UPDATE Categories SET Name = ? WHERE Id = ?";

      try {
         Connection conn = DBUtils.getConnection();

         boolean var5;
         try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            try {
               pstmt.setString(1, category.getName());
               pstmt.setInt(2, category.getId());
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

   public boolean deleteCategory(int id) {
      String sql = "DELETE FROM Categories WHERE Id = ?";

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
}