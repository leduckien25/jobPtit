 package Util;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;

public class ValidateForm {
   public static boolean isInteger(String str) {
      if (str == null) {
         return false;
      } else {
         try {
            Integer.parseInt(str);
            return true;
         } catch (NumberFormatException var2) {
            return false;
         }
      }
   }

   public static boolean isEmpty(String str) {
      return str == null || str.trim().isEmpty();
   }

   public static boolean isValidSalary(int min, int max) {
      return min >= 0 && max >= min;
   }

   public static Map<String, String> validateJobPost(String title, String location, String salaryMin, String salaryMax, String negotiableStr, String deadlineStr) {
      Map<String, String> errors = new HashMap();
      if (title == null || title.trim().isEmpty()) {
         errors.put("title", "Tiêu đề không được để trống");
      }

      if (location == null || location.trim().isEmpty()) {
         errors.put("location", "Địa điểm không được để trống");
      }

      if (deadlineStr != null && !deadlineStr.isEmpty()) {
         try {
            LocalDate deadline = LocalDate.parse(deadlineStr);
            LocalDate today = LocalDate.now();
            if (deadline.isBefore(today)) {
               errors.put("deadline", "Hạn nộp hồ sơ không được là ngày trong quá khứ");
            }
         } catch (DateTimeParseException var9) {
            errors.put("deadline", "Định dạng ngày không hợp lệ");
         }
      }

      if (!"on".equals(negotiableStr)) {
         try {
            int min = salaryMin != null && !salaryMin.isEmpty() ? Integer.parseInt(salaryMin) : 0;
            int max = salaryMax != null && !salaryMax.isEmpty() ? Integer.parseInt(salaryMax) : 0;
            if (min <= 0) {
               errors.put("salaryMin", "Vui lòng nhập lương tối thiểu hợp lệ");
            }

            if (max <= 0) {
               errors.put("salaryMax", "Vui lòng nhập lương tối đa hợp lệ");
            }

            if (max > 0 && min > 0 && max < min) {
               errors.put("salaryMax", "Lương tối đa phải lớn hơn lương tối thiểu");
            }
         } catch (NumberFormatException var10) {
            errors.put("salary", "Lương phải là định dạng số");
         }
      }

      errors.forEach((t, u) -> {
         System.out.println(t + u);
      });
      return errors;
   }
}
    