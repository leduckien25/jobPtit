package controller.candidate;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ApplicationDAO;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {
    private ApplicationDAO appDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/candidate/job/applyJob.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {        
        try {
            User user = (User) request.getSession().getAttribute("LOGIN_USER");
        
            if (user == null) {
                // Sửa lại đường link redirect cho chuẩn tuyệt đối, tránh lỗi 404
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }

            int userId = user.getId();

            // 2. Lấy jobId từ thẻ input hidden trong applyForm.jsp
            String jobIdStr = request.getParameter("jobId");
            if (jobIdStr == null || jobIdStr.isEmpty()) {
                request.getRequestDispatcher("/views/candidate/index.jsp").forward(request, response);
                return;
            }
            int jobId = Integer.parseInt(jobIdStr);

            // 3. Gọi DAO để thực hiện nộp đơn (Sử dụng hàm nhận 2 tham số: userId và jobId)
            // Hệ thống sẽ mặc định dùng thông tin hồ sơ đã có trong Profile của người dùng
            boolean success = appDAO.addApplication(userId, jobId);

            if (success) {
                // Thành công: Chuyển về trang danh sách việc làm đã nộp
                response.sendRedirect(request.getContextPath() + "/applied-jobs");
            } else {
                // Thất bại (Ví dụ: Đã nộp rồi): Thông báo lại tại trang form
                request.setAttribute("msg", "Bạn đã ứng tuyển công việc này trước đó rồi.");
                request.getRequestDispatcher("/views/candidate/job/applyJob.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/candidate/job/applyJob.jsp").forward(request, response);
        }
        
    }
}
