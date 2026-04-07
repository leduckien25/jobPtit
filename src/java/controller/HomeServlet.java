/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDao;
import dao.JobDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Category;
import model.Job;


@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDao categoryDao = new CategoryDao();
        JobDao jobDao = new JobDao();
        List<Category> categories = null;
        Map<Category, Integer> outstandingCategoryMap = null;
        List<Job> recentJobs = null;
        
        try {
            categories = categoryDao.getCategories();
            recentJobs = jobDao.getRecentJobs(5);
            outstandingCategoryMap = categoryDao.getOutstandingCategories(4);
            
        } catch (ClassNotFoundException ex) {
            System.getLogger(HomeServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        } catch (SQLException ex) {
            System.getLogger(HomeServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        
        request.setAttribute("categories", categories);
        request.setAttribute("recentJobs", recentJobs);
        request.setAttribute("categoryMap", outstandingCategoryMap);
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

}
