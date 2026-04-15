/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin;

import dao.CompanyDAO;
import dao.JobDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Job;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy các con số thống kê
        int pendingJobs = jobDAO.countPaged(null, 0);       // Số bài chờ duyệt (Status = 0)
        int pendingCompanies = companyDAO.countByStatus(0); // Công ty chờ xác thực (IsVerified = 0)
        int activeJobs = jobDAO.countPaged(null, 1);        // Tổng bài đăng (Status = 1)
        
        

        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) page = Integer.parseInt(pageParam);
        } catch (Exception e) {}

        // 2. Lấy 5 bài đăng tuyển dụng theo trang hiện tại
        List<Job> recentJobs = jobDAO.findPaged(null, null, page, 5);
        
        // Tính tổng số trang (dựa trên TẤT CẢ bài đăng)
        int totalAllJobs = jobDAO.countPaged(null, null);
        int totalPages = (int) Math.ceil((double) totalAllJobs / 5);

        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("pendingJobs", pendingJobs);
        request.setAttribute("pendingCompanies", pendingCompanies);
        request.setAttribute("activeJobs", activeJobs);
        
        
        request.setAttribute("recentJobs", recentJobs);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);

    }
}