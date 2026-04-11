 package models;

public class Category {
   private int id;
   private String name;
   private String slug;

   public void setId(int id) {
      this.id = id;
   }

   public void setName(String name) {
      this.name = name;
   }

   public void setSlug(String slug) {
      this.slug = slug;
   }

   public int getId() {
      return this.id;
   }

   public String getName() {
      return this.name;
   }

   public String getSlug() {
      return this.slug;
   }

   public Category(int id, String name, String slug) {
      this.id = id;
      this.name = name;
      this.slug = slug;
   }

   public Category() {
   }
}
    