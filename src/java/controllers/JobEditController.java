 package controllers;

import dao.CategoryDAO;
import dao.JobDAO;
import models.Category;
import models.Job;
import utils.ValidateForm;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public class JobEditController extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      HttpSession session = request.getSession();
      String action = request.getParameter("action");
      if ("job-update".equals(action)) {
         String idStr = request.getParameter("id");
         String title = request.getParameter("title");
         String location = request.getParameter("location");
         String description = request.getParameter("description");
         String salaryMinStr = request.getParameter("salary-min");
         String salaryMaxStr = request.getParameter("salary-max");
         String jobTypeStr = request.getParameter("job-type");
         String statusStr = request.getParameter("status");
         String categoryIdStr = request.getParameter("category");
         String negotiableStr = request.getParameter("negotiable");
         String deadlineStr = request.getParameter("deadline");
         Map<String, String> errors = ValidateForm.validateJobPost(title, location, salaryMinStr, salaryMaxStr, negotiableStr, deadlineStr);
         if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            Job oldJob = new Job();

            try {
               oldJob.setId(idStr != null ? Integer.parseInt(idStr) : 0);
               oldJob.setTitle(title);
               oldJob.setLocation(location);
               oldJob.setDescription(description);
               oldJob.setSalaryMin(ValidateForm.isInteger(salaryMinStr) ? Integer.parseInt(salaryMinStr) : 0);
               oldJob.setSalaryMax(ValidateForm.isInteger(salaryMaxStr) ? Integer.parseInt(salaryMaxStr) : 0);
               oldJob.setJobType(ValidateForm.isInteger(jobTypeStr) ? Integer.parseInt(jobTypeStr) : 1);
               oldJob.setStatus(ValidateForm.isInteger(statusStr) ? Integer.parseInt(statusStr) : 0);
               oldJob.setCategoryId(ValidateForm.isInteger(categoryIdStr) ? Integer.parseInt(categoryIdStr) : 1);
               oldJob.setNegotiable("on".equals(negotiableStr) ? 1 : 0);
               if (deadlineStr != null && !deadlineStr.isEmpty()) {
                  oldJob.setDeadline(LocalDate.parse(deadlineStr));
               } else {
                  oldJob.setDeadline((LocalDate)null);
               }
            } catch (Exception var29) {
               var29.printStackTrace();
            }

            request.setAttribute("job", oldJob);
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/views/jobEdit.jsp").forward(request, response);
         } else {
            try {
               int id = Integer.parseInt(idStr);
               int negotiable = negotiableStr.equals("on") ? 1 : 0;
               int salaryMin = 0;
               int salaryMax = 0;
               if (negotiable == 0) {
                  salaryMin = Integer.parseInt(salaryMinStr);
                  salaryMax = Integer.parseInt(salaryMaxStr);
               }

               int jobType = Integer.parseInt(jobTypeStr);
               int status = Integer.parseInt(statusStr);
               int categoryId = Integer.parseInt(categoryIdStr);
               LocalDate deadline = null;
               if (deadlineStr != null && !deadlineStr.isEmpty()) {
                  deadline = LocalDate.parse(deadlineStr);
               }

               Job job = new Job(title, location, description, salaryMax, salaryMin, jobType, status, categoryId, negotiable, deadline);
               job.setId(id);
               JobDAO jobDao = new JobDAO();
               boolean isUpdated = jobDao.updateJob(job);
               if (isUpdated) {
                  session.setAttribute("message", "Cập nhật thông tin thành công!");
                  session.setAttribute("msgType", "success");
                  response.sendRedirect(request.getContextPath() + "/job-manage");
               } else {
                  session.setAttribute("message", "Cập nhật thất bại!");
                  session.setAttribute("msgType", "error");
                  String var10001 = request.getContextPath();
                  response.sendRedirect(var10001 + "/job-edit/" + id);
               }
            } catch (Exception var28) {
               session.setAttribute("message", "Lỗi hệ thống: " + var28.getMessage());
               session.setAttribute("msgType", "error");
               response.sendRedirect(request.getContextPath() + "/job-manage");
            }
         }
      }

   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String pathInfo = request.getPathInfo();
      HttpSession session = request.getSession();
      if (pathInfo != null && !pathInfo.equals("/") && pathInfo.length() > 1) {
         try {
            int id = Integer.parseInt(pathInfo.substring(1));
            JobDAO jobDAO = new JobDAO();
            Job job = jobDAO.getJobById(id);
            if (job != null) {
               CategoryDAO categoryDAO = new CategoryDAO();
               List<Category> categories = categoryDAO.getAllCategories();
               request.setAttribute("job", job);
               request.setAttribute("categories", categories);
               request.getRequestDispatcher("/views/jobEdit.jsp").forward(request, response);
            } else {
               session.setAttribute("message", "Lỗi: Tin tuyển dụng không tồn tại hoặc đã bị xóa.");
               session.setAttribute("msgType", "error");
               response.sendRedirect(request.getContextPath() + "/job-manage");
            }
         } catch (NumberFormatException var10) {
            session.setAttribute("message", "Lỗi: ID tin tuyển dụng không hợp lệ.");
            session.setAttribute("msgType", "error");
            response.sendRedirect(request.getContextPath() + "/job-manage");
         } catch (Exception var11) {
            var11.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/job-manage");
         }

      } else {
         session.setAttribute("message", "Lỗi: Không tìm thấy ID tin tuyển dụng.");
         session.setAttribute("msgType", "error");
         response.sendRedirect(request.getContextPath() + "/job-manage");
      }
   }
}
  