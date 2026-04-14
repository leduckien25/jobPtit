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
import model.User;

/**
 *
 * @author ducki
 */
@WebServlet(name = "DeleteApplicationServlet", urlPatterns = {"/DeleteApplication"})
public class DeleteApplicationServlet extends HttpServlet {

    
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // 1. Kiểm tra đăng nhập
        if (session == null || session.getAttribute("LOGIN_USER") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("LOGIN_USER");

        // 2. Chỉ cho phép Ứng viên (Role 1) thực hiện hủy đơn của chính mình
        if (user.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            // 3. Lấy ID đơn hàng từ Form
            String appIdStr = request.getParameter("appId");
            
            if (appIdStr != null && !appIdStr.isEmpty()) {
                int appId = Integer.parseInt(appIdStr);
                
                ApplicationDAO dao = new ApplicationDAO();
                
                // 4. Gọi DAO để xóa (truyền cả userId để đảm bảo không xóa nhầm đơn người khác)
                boolean result = dao.deleteApplication(appId, user.getId());

                if (result) {
                    session.setAttribute("successMsg", "Đã rút hồ sơ ứng tuyển thành công.");
                } else {
                    session.setAttribute("errorMsg", "Hủy đơn thất bại. Đơn có thể đã được duyệt hoặc không tồn tại.");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // 5. Quay lại trang danh sách (PRG Pattern)
        response.sendRedirect(request.getContextPath() + "/applied-jobs");
    }

}
