/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import dao.ApplicationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author huyle
 */
@WebServlet("/recruiter/update-status")
public class UpdateStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String appIdStr = request.getParameter("appId");
        String jobIdStr = request.getParameter("jobId");
        String statusStr = request.getParameter("newStatus");

        if (appIdStr != null && jobIdStr != null) {
            try {
                int appId = Integer.parseInt(appIdStr);
                int jobId = Integer.parseInt(jobIdStr);
                int status = Integer.parseInt(statusStr);

                ApplicationDAO dao = new ApplicationDAO();
                boolean result = dao.updateStatus(appId, status);
                
                // Sau khi xong, phải quay lại đúng trang danh sách của Job đó
                response.sendRedirect(request.getContextPath() + "/recruiter/candidates?jobId=" + jobId);
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/job-manage");
    }
}