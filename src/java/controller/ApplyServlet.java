package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.ApplicationDAO;
import model.Application;
import model.User; 

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {
    private ApplicationDAO appDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        //  Kiểm tra đăng nhập 
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("LOGIN_USER"); // Phải lấy đúng tên "LOGIN_USER"
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "viewForm";

        switch (action) {
            case "delete": // Xử lý hủy đơn
                int appId = Integer.parseInt(request.getParameter("appId"));
                appDAO.deleteApplication(appId);
                response.sendRedirect("apply?action=list"); // Xóa xong quay lại danh sách
                break;

            case "list": // Hiển thị danh sách đã nộp
                List<Application> appliedList = appDAO.getAppliedJobs(user.getId());
                request.setAttribute("appliedList", appliedList);
                request.getRequestDispatcher("appliedJobs.jsp").forward(request, response);
                break;

            default: // Mặc định hiển thị trang xác nhận nộp đơn 
                request.getRequestDispatcher("applyForm.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 1. Lấy User từ Session (Sửa lỗi sai tên biến)
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("LOGIN_USER");
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }

            // 2. Lấy jobId
            String jobIdStr = request.getParameter("jobId");
            if (jobIdStr == null || jobIdStr.isEmpty()) {
                response.sendRedirect("index.jsp");
                return;
            }
            int jobId = Integer.parseInt(jobIdStr);

            // 3. Gọi DAO nộp đơn (Mục 9)
            boolean success = appDAO.addApplication(user.getId(), jobId);

            if (success) {
                //  Thành công thì nhảy về trang danh sách thông qua Servlet để load dữ liệu
                response.sendRedirect("apply?action=list");
            } else {
                request.setAttribute("msg", "Bạn đã ứng tuyển công việc này rồi hoặc hồ sơ chưa sẵn sàng.");
                request.getRequestDispatcher("applyForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}