/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDao;
import dao.JobDao;
import dto.JobFilter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Job;


@WebServlet(name = "JobServlet", urlPatterns = {"/jobs/*"})
public class JobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if(pathInfo != null && pathInfo.length() > 1){
            try {
                handleDetail(request, response);
            } catch (ClassNotFoundException ex) {
                System.getLogger(JobServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            } catch (SQLException ex) {
                System.getLogger(JobServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
        }
        else{
            try {
                handleSearch(request, response);
            } catch (SQLException ex) {
                System.getLogger(JobServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            } catch (ClassNotFoundException ex) {
                System.getLogger(JobServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
        }
       
    }
    
    private void handleSearch(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, ServletException, IOException{        
        JobFilter filter = new JobFilter();        

        filter.setKeyword(request.getParameter("jobKeyword"));
        filter.setLocation(request.getParameter("location"));
        filter.setCategorySlug(request.getParameter("category"));

        String salaryRange = request.getParameter("salaryRange");
        filter.setSalaryRange(salaryRange);
        
        if (salaryRange != null && !salaryRange.isEmpty() && !salaryRange.equals("All")) {
            String[] salaryRanges = salaryRange.split("-");
            if (salaryRanges.length == 2) {
                try {
                    int min = Integer.parseInt(salaryRanges[0].replaceAll("[^0-9]", ""));

                    filter.setMinSalary(min);
                } catch (NumberFormatException e) {
                    filter.setMinSalary(null);
                }
                
                try {
                    int max = Integer.parseInt(salaryRanges[1].replaceAll("[^0-9]", ""));
                    filter.setMaxSalary(max);
                }catch (NumberFormatException e) {
                    filter.setMaxSalary(null);
                }
            }                
            else{
                try {
                    int min = Integer.parseInt(salaryRanges[0].replaceAll("[^0-9]", ""));

                    filter.setMinSalary(min);
                } catch (NumberFormatException e) {
                    filter.setMinSalary(null);
                }
            }
        }

        String[] jobTypesArray = request.getParameterValues("jobType");

        if (jobTypesArray != null && jobTypesArray.length > 0) {
            List<String> jobTypeList = java.util.Arrays.asList(jobTypesArray);
            filter.setJobType(jobTypeList);
        } else {
            filter.setJobType(new ArrayList<>());
        }
        
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                int page = Integer.parseInt(pageStr);
                filter.setPage(page > 0 ? page : 1);
            } catch (NumberFormatException e) {
                filter.setPage(1); 
            }
        }

        String pageSizeStr = request.getParameter("pageSize");
        if (pageSizeStr != null && !pageSizeStr.trim().isEmpty()) {
            try {
                filter.setPageSize(Integer.parseInt(pageSizeStr));
            } catch (NumberFormatException e) {
                filter.setPageSize(6); 
            }
        }

        String sort = request.getParameter("sort");
        if (sort != null && !sort.trim().isEmpty()) {
            filter.setSort(sort);
        } else {
            filter.setSort("newest"); 
        }
        
        JobDao jobDao = new JobDao();
        
        List<Job> existingJobs = jobDao.getJobs(filter);
        int totalRecords = jobDao.countJobs(filter);
        
        
        int totalPages = (totalRecords - 1) / filter.getPageSize() + 1;
        
        
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", (new CategoryDao()).getCategories());
        request.setAttribute("jobs", existingJobs);
        request.setAttribute("filter", filter);
        
        request.getRequestDispatcher("/WEB-INF/views/jobList.jsp").forward(request, response);
    }

    private void handleDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        int jobId = Integer.parseInt(request.getPathInfo().substring(1));
        
        Job existingJob = (new JobDao()).getJob(jobId);
        
        request.setAttribute("job", existingJob);
        
        request.getRequestDispatcher("/WEB-INF/views/jobDetail.jsp").forward(request, response);
    }

}
