  package controller.recruiter;

import dao.CategoryDAO;
import dao.JobDAO;
import model.Category;
import model.Job;
import util.ValidateForm;
import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import model.Company;
import model.User;

@WebServlet(
   name = "JobController",
   urlPatterns = {"/job"}
)
public class JobServlet extends HttpServlet {
   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      HttpSession session = request.getSession(false);
      User user = (session != null) ? (User) session.getAttribute("LOGIN_USER") : null;
      if (user == null) {
          response.sendRedirect(request.getContextPath() + "/auth/login");
      } else if (user.getRole() != 2) { 
          request.setAttribute("error", "Bạn không có quyền truy cập chức năng này!");
          request.getRequestDispatcher("/views/error/forbidden.jsp").forward(request, response);
      } else {
          System.out.println("User đang đăng nhập: " + user.getEmail());
      }
      CompanyDAO companyDAO = new CompanyDAO();
      Company company = companyDAO.findByOwnedId(user.getId());
      if (company == null || company.getIsVerified() != 1) {
         session.setAttribute("message", "Công ty của bạn chưa được duyệt. Vui lòng chờ admin xét duyệt!");
         session.setAttribute("msgType", "error");
         response.sendRedirect(request.getContextPath() + "/job-manage");
         return; // ← PHẢI có return
      }
      
      String url = "/views/recruiter/job/jobPost.jsp";
      String action = request.getParameter("action");
      CategoryDAO categoryDAO = new CategoryDAO();
      List<Category> categories = categoryDAO.getAllCategories();
      request.setAttribute("categories", categories);
      if (action == null) {
         url = "/views/recruiter/job/jobPost.jsp";
      } else if (action.equals("job-post")) {
         try {
            String title = request.getParameter("title");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String salaryMinStr = request.getParameter("salary-min");
            String salaryMaxStr = request.getParameter("salary-max");
            String jobTypeStr = request.getParameter("job-type");
//            String statusStr = request.getParameter("status");
            String categoryIdStr = request.getParameter("category");
            String negotiableStr = request.getParameter("negotiable");
            boolean negotiable = negotiableStr != null && negotiableStr.equals("on") ? true : false;
            String deadlineStr = !request.getParameter("deadline").isEmpty()? request.getParameter("deadline") : null;
            Map<String, String> errors = ValidateForm.validateJobPost(title, location, salaryMinStr, salaryMaxStr, negotiableStr, deadlineStr);
            Job oldJob = new Job();
            oldJob.setTitle(title);
            oldJob.setLocation(location);
            oldJob.setDescription(description);
            oldJob.setExpiredAt(deadlineStr != null && !deadlineStr.isEmpty() ? LocalDate.parse(deadlineStr).atStartOfDay() : null);

            try {
               oldJob.setSalaryMin(salaryMinStr != null && !salaryMinStr.isEmpty() ? Integer.valueOf(salaryMinStr) : 0);
               oldJob.setSalaryMax(salaryMaxStr != null && !salaryMaxStr.isEmpty() ? Integer.valueOf(salaryMaxStr) : 0);
               oldJob.setJobType(Integer.parseInt(jobTypeStr));
               oldJob.setCategoryId(Integer.parseInt(categoryIdStr));
               oldJob.setIsNegotiable(negotiable);
            } catch (Exception var30) {
            }

            if (!errors.isEmpty()) {
               request.setAttribute("errors", errors);
               request.setAttribute("oldJob", oldJob);
               url = "/views/recruiter/job/jobPost.jsp";
            } else {
               int salaryMin = 0;
               int salaryMax = 0;
               if (!negotiable) {
                  salaryMin = Integer.parseInt(salaryMinStr);
                  salaryMax = Integer.parseInt(salaryMaxStr);
               }

               int jobType = Integer.parseInt(jobTypeStr);
               int categoryId = Integer.parseInt(categoryIdStr);
               LocalDateTime deadline = deadlineStr!= null && !deadlineStr.isEmpty() ?LocalDate.parse(deadlineStr).atStartOfDay() : null;
               Job job = new Job(title, location, description, salaryMax, salaryMin, jobType, 0, categoryId, negotiable, deadline);
               JobDAO jobDao = new JobDAO();
//               CompanyDAO companyDAO = new CompanyDAO();
//               Company company = companyDAO.findByOwnedId(user.getId());
                job.setCompanyId(company.getId());
                job.setCreatedByUserId(user.getId());
                
               boolean checkInsert = jobDao.insertJob(job);
               if (checkInsert) {
                  session.setAttribute("message", "Đăng tin tuyển dụng thành công!");
                  session.setAttribute("msgType", "success");
                  response.sendRedirect(request.getContextPath() + "/job-manage");
                  return;
               }
               else{
                   System.out.println(checkInsert);
               }

               request.setAttribute("message", "Lỗi: Không thể lưu vào cơ sở dữ liệu.");
               request.setAttribute("msgType", "error");
               System.out.println("Lỗi CSDL");
               url = "/views/recruiter/job/jobPost.jsp";
            }
         } catch (NumberFormatException var31) {
            request.setAttribute("message", "Lỗi: Mức lương phải là chữ số!");
            request.setAttribute("msgType", "error");
            System.out.println("Lỗi số lương");
            url = "/views/recruiter/job/jobPost.jsp";
         } catch (Exception var32) {
            request.setAttribute("message", "Đã xảy ra lỗi hệ thống: " + var32.getMessage());
            request.setAttribute("msgType", "error");
            System.out.println("Lỗi hệ thống");
            var32.printStackTrace();
            url = "/views/recruiter/job/jobPost.jsp";
         }
      }

      this.getServletContext().getRequestDispatcher(url).forward(request, response);
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      this.processRequest(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      this.processRequest(request, response);
   }
}
    