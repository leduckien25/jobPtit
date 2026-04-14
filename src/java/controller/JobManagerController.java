  package controller;

import dao.JobDAO;
import dao.UserDAO;
import dao.CompanyDAO;
import model.Job;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;
import model.User;
import model.Company;
import java.util.List;

public class JobManagerController extends HttpServlet {
   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      
      JobDAO jobDAO = new JobDAO();
      String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action)) {
            // Gọi hàm xóa job với id tương ứng
            jobDAO.deleteJob(Integer.parseInt(id));
            // Chuyển hướng về lại trang danh sách
            response.sendRedirect("job-manage");
            return;
        }
      CompanyDAO companyDAO = new CompanyDAO();
      User user = (User) request.getSession().getAttribute("LOGIN_USER");
      Company company = companyDAO.findByOwnedId(user.getId());
       System.out.println(company.getId());
      String searchTitle = request.getParameter("searchTitle");
      String searchLocation = request.getParameter("searchLocation");
      String pageStr = request.getParameter("page");
      int currentPage = pageStr != null && !pageStr.isEmpty() ? Integer.parseInt(pageStr) : 1;
      int pageSize = 5;
      List<Job> listJobs = jobDAO.searchJobsPaging(searchTitle, searchLocation, currentPage, pageSize, company.getId());
      int totalJobs = jobDAO.getAllJobs(company.getId()).size();
      int totalViewsCount = jobDAO.getTotalViewsByCompany(company.getId());
      int totalRecords = jobDAO.getTotalJobs(searchTitle, searchLocation, company.getId());
      int totalPages = (int)Math.ceil((double)totalRecords / (double)pageSize);
       for (Job listJob : listJobs) {
           System.out.println(listJob);
       }

      request.setAttribute("jobs", listJobs);
      request.setAttribute("totalJobs", totalJobs);
      request.setAttribute("currentPage", currentPage);
      request.setAttribute("totalPages", totalPages);
      request.setAttribute("searchTitle", searchTitle);
      request.setAttribute("searchLocation", searchLocation);
      request.setAttribute("totalViewsCount", totalViewsCount);
      request.getRequestDispatcher("/views/job/jobManager.jsp").forward(request, response);
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      this.processRequest(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      this.processRequest(request, response);
   }
}
    