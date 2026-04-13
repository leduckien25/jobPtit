package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ApplicationDAO;

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {
    private ApplicationDAO appDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Hiển thị trang xác nhận nộp đơn
        request.getRequestDispatcher("applyForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 1. Kiểm tra đăng nhập để lấy userId
            Object userObj = request.getSession().getAttribute("userId");
            if (userObj == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int userId = (int) userObj;

            // 2. Lấy jobId từ thẻ input hidden trong applyForm.jsp
            String jobIdStr = request.getParameter("jobId");
            if (jobIdStr == null || jobIdStr.isEmpty()) {
                response.sendRedirect("index.jsp");
                return;
            }
            int jobId = Integer.parseInt(jobIdStr);

            // 3. Gọi DAO để thực hiện nộp đơn (Sử dụng hàm nhận 2 tham số: userId và jobId)
            // Hệ thống sẽ mặc định dùng thông tin hồ sơ đã có trong Profile của người dùng
            boolean success = appDAO.addApplication(userId, jobId);

            if (success) {
                // Thành công: Chuyển về trang danh sách việc làm đã nộp
                response.sendRedirect("appliedJobs.jsp");
            } else {
                // Thất bại (Ví dụ: Đã nộp rồi): Thông báo lại tại trang form
                request.setAttribute("msg", "Bạn đã ứng tuyển công việc này trước đó hoặc hệ thống bận.");
                request.getRequestDispatcher("applyForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("applyForm.jsp").forward(request, response);
        }
    }
}