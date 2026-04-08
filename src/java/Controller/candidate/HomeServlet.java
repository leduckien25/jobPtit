/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.candidate;

import dao.CategoryDAO;

import dao.JobDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Category;
import model.Job;
import model.User;


@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("LOGIN_USER") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("LOGIN_USER");

        if (user.getRole() != 1) {
            // Không phải Admin -> Báo lỗi 403 (Cấm truy cập)
            response.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "CẢNH BÁO: Bạn không có quyền truy cập khu vực này!");
            return; 
        }
        
        CategoryDAO categoryDAO = new CategoryDAO();
        JobDAO jobDao = new JobDAO();
        List<Category> categories = null;
        Map<Category, Integer> outstandingCategoryMap = null;
        List<Job> recentJobs = null;
        
        try {
            categories = categoryDAO.getCategories();
            recentJobs = jobDao.getRecentJobs(5);
            outstandingCategoryMap = categoryDAO.getOutstandingCategories(4);
            
        } catch (ClassNotFoundException ex) {
            System.getLogger(HomeServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        } catch (SQLException ex) {
            System.getLogger(HomeServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        
        request.setAttribute("categories", categories);
        request.setAttribute("recentJobs", recentJobs);
        request.setAttribute("categoryMap", outstandingCategoryMap);
        
        request.getRequestDispatcher("/views/candidate/index.jsp").forward(request, response);
    }

}
