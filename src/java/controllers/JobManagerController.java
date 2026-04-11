  package controllers;

import dao.JobDAO;
import models.Job;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

public class JobManagerController extends HttpServlet {
   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      JobDAO jobDAO = new JobDAO();
      String searchTitle = request.getParameter("searchTitle");
      String searchLocation = request.getParameter("searchLocation");
      String pageStr = request.getParameter("page");
      int currentPage = pageStr != null && !pageStr.isEmpty() ? Integer.parseInt(pageStr) : 1;
      int pageSize = 5;
      List<Job> listJobs = jobDAO.searchJobsPaging(searchTitle, searchLocation, currentPage, pageSize);
      int totalJobs = jobDAO.getAllJobs().size();
      int totalRecords = jobDAO.getTotalJobs(searchTitle, searchLocation);
      int totalPages = (int)Math.ceil((double)totalRecords / (double)pageSize);
      Iterator var13 = listJobs.iterator();

      while(var13.hasNext()) {
         Job listJob = (Job)var13.next();
         System.out.println(listJob);
      }

      request.setAttribute("jobs", listJobs);
      request.setAttribute("totalJobs", totalJobs);
      request.setAttribute("currentPage", currentPage);
      request.setAttribute("totalPages", totalPages);
      request.setAttribute("searchTitle", searchTitle);
      request.setAttribute("searchLocation", searchLocation);
      request.getRequestDispatcher("/views/jobManager.jsp").forward(request, response);
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      this.processRequest(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      this.processRequest(request, response);
   }
}
    