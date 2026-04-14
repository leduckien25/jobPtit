/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.candidate;

import dao.ApplicationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Application;
import model.User;

@WebServlet(name = "AppliedJobsServlet", urlPatterns = {"/applied-jobs"})
public class AppliedJobsServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 1. Kiểm tra đăng nhập
        if (session == null || session.getAttribute("LOGIN_USER") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("LOGIN_USER");

        // 2. Gọi DAO lấy danh sách đã nộp
        ApplicationDAO appDAO = new ApplicationDAO();
        // Giả sử hàm listByCandidateId trả về danh sách các đơn ứng tuyển của sinh viên
        List<Application> appliedList = appDAO.getAppliedJobs(user.getId());

        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("appliedList", appliedList);

        // Chuyển hướng tới file JSP (Đảm bảo đường dẫn chính xác)
        request.getRequestDispatcher("/views/candidate/job/jobsApplied.jsp").forward(request, response);
    }

}
