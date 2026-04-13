/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import dao.ApplicationDAO;
import model.Application;

/**
 *
 * @author admin
 */
@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {
    private ApplicationDAO appDAO = new ApplicationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng đến form nộp đơn
        request.getRequestDispatcher("applyForm.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Giả sử đã lấy được UserId từ Session (người dùng đã đăng nhập)
        int userId = (int) request.getSession().getAttribute("userId");
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        boolean success = appDAO.addApplication(userId, jobId);
        if (success) {
            response.sendRedirect("applied-list"); // Chuyển về trang xem đơn đã nộp
        } else {
            request.setAttribute("msg", "Nộp đơn thất bại!");
            request.getRequestDispatcher("applyForm.jsp").forward(request, response);
        }
    }
}