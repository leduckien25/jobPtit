/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;


@WebServlet(name = "AuthServlet", urlPatterns = {"/auth/*"})
public class AuthServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        switch (action(req)) {
            case "login"    ->{
                // --- THÊM ĐOẠN NÀY ĐỂ ĐỌC COOKIE ---
                Cookie[] cookies = req.getCookies();
                if (cookies != null) {
                    for (Cookie c : cookies) {
                        if (c.getName().equals("savedEmail")) req.setAttribute("savedEmail", c.getValue());
                        if (c.getName().equals("savedPass")) req.setAttribute("savedPass", c.getValue());
                        if (c.getName().equals("savedRemember")) req.setAttribute("savedRemember", "checked");
                    }
                } 
                forward(req, resp, "/views/auth/login.jsp");
            }
            case "register" -> forward(req, resp, "/views/auth/register.jsp");
            case "logout"   -> logout(req, resp);
            case "forgot-password" -> forward(req,resp,"/views/auth/forgot-password.jsp");
            default         -> resp.sendRedirect(req.getContextPath() + "/auth/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Hỗ trợ tiếng Việt khi submit form
        req.setCharacterEncoding("UTF-8");
        
        switch (action(req)) {
            case "login"    -> Login(req, resp);
            case "register" -> Register(req, resp);
            default         -> resp.sendRedirect(req.getContextPath() + "/auth/login");
        }
    }

   private void Login(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Dùng biến email thay vì username
        String email = trim(req.getParameter("email")); 
        String password = req.getParameter("password");
        
        // Nhận giá trị từ ô checkbox "Ghi nhớ đăng nhập"
        String remember = req.getParameter("remember"); 

        if (blank(email) || blank(password)) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu.");
            req.setAttribute("email", email);
            forward(req, resp, "/views/auth/login.jsp");
            return;
        }

        User user = userDAO.login(email, password);

        if (user == null) {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            req.setAttribute("email", email);
            forward(req, resp, "/views/auth/login.jsp");
            return;
        }

        // Tạo session
        HttpSession session = req.getSession(true);
        session.setAttribute("LOGIN_USER", user);
        session.setMaxInactiveInterval(30 * 60); // 30 phút

        // ==========================================
        // KHỐI CODE MỚI: XỬ LÝ GHI NHỚ ĐĂNG NHẬP (COOKIE)
        // ==========================================
        if (remember != null) { // Nếu người dùng CÓ tích vào ô Ghi nhớ
            Cookie cookieEmail = new Cookie("savedEmail", email);
            Cookie cookiePass = new Cookie("savedPass", password);
            Cookie cookieRemember = new Cookie("savedRemember", "true");
            
            // Thời gian sống: 7 ngày
            int maxAge = 7 * 24 * 60 * 60;
            cookieEmail.setMaxAge(maxAge);
            cookiePass.setMaxAge(maxAge);
            cookieRemember.setMaxAge(maxAge);
            
            resp.addCookie(cookieEmail);
            resp.addCookie(cookiePass);
            resp.addCookie(cookieRemember);
        } else { // Nếu KHÔNG tích -> Tiêu hủy Cookie cũ (nếu có)
            Cookie cookieEmail = new Cookie("savedEmail", "");
            Cookie cookiePass = new Cookie("savedPass", "");
            Cookie cookieRemember = new Cookie("savedRemember", "");
            
            cookieEmail.setMaxAge(0);
            cookiePass.setMaxAge(0);
            cookieRemember.setMaxAge(0);
            
            resp.addCookie(cookieEmail);
            resp.addCookie(cookiePass);
            resp.addCookie(cookieRemember);
        }
        // ==========================================

        // 1. Lấy đường dẫn cũ đã lưu trong Session (nếu có)
        String savedRedirect = (String) session.getAttribute("redirectAfterLogin");

        // 2. Lấy ra xong thì xóa luôn để lần đăng nhập sau không bị dính link cũ
        session.removeAttribute("redirectAfterLogin");

        // 3. Quyết định nơi sẽ chuyển hướng
        if (savedRedirect != null && !savedRedirect.isEmpty()) {
            // Trạng thái 1: Có link cũ -> Chuyển thẳng tới đó
            resp.sendRedirect(savedRedirect);
        } else {
            // Trạng thái 2: Đăng nhập bình thường -> Redirect theo Role chuẩn của Database
            String redirectContext = req.getContextPath();
            String defaultRedirect = switch (user.getRole()) {
                case 3 -> redirectContext + "/admin/dashboard";     // Admin
                case 2 -> redirectContext + "/job-manage"; // Nhà tuyển dụng
                case 1 -> redirectContext + "/";                // Ứng viên
                default -> redirectContext + "/auth/login";
            };
            resp.sendRedirect(defaultRedirect);
        }
    }

    private void Register(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email     = trim(req.getParameter("email"));
        String password  = req.getParameter("password");
        String password2 = req.getParameter("password2");
        String roleStr   = req.getParameter("role");
        String companyName = trim(req.getParameter("companyName"));

        // --- Validation ---
        if (blank(email) || blank(password)) {
            error(req, resp, "Vui lòng nhập đầy đủ thông tin bắt buộc!", "/views/auth/register.jsp");
            return;
        }
        
        // Validate định dạng email cơ bản
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            error(req, resp, "Định dạng email không hợp lệ!", "/views/auth/register.jsp");
            return;
        }
        
        if (password.length() < 6) {
            error(req, resp, "Mật khẩu phải có ít nhất 6 ký tự!", "/views/auth/register.jsp");
            return;
        }
        if (!password.equals(password2)) {
            error(req, resp, "Mật khẩu xác nhận không khớp!", "/views/auth/register.jsp");
            return;
        }
        
        // Kiểm tra trùng Email
        if (userDAO.existsByEmail(email)) {
            error(req, resp, "Email này đã được đăng ký!", "/views/auth/register.jsp");
            return;
        }

        // Xử lý Role (1=Candidate, 2=Recruiter)
        int role = "2".equals(roleStr) ? 2 : 1; // Nếu form gửi lên role=2 thì là NTD, ngược lại là Ứng viên
        if (role == 2 && blank(companyName)) {
            error(req, resp, "Vui lòng nhập Tên công ty!", "/views/auth/register.jsp");
            return;
        }
        // Gọi DAO đăng ký
        boolean ok = userDAO.register(email, password, role,companyName);

        if (!ok) {
            error(req, resp, "Đăng ký thất bại! Vui lòng thử lại.", "/views/auth/register.jsp");
            return;
        }

        req.getSession(true).setAttribute("successMsg", "Đăng ký thành công! Hãy đăng nhập.");
        resp.sendRedirect(req.getContextPath() + "/auth/login");
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/auth/login");
    }
    

    // ── Helpers ───────────────────────────────────────────────────────────────
    private String action(HttpServletRequest req) {
        String pi = req.getPathInfo();
        if (pi == null || pi.equals("/")) return "";
        return pi.substring(1).toLowerCase(); // Lấy chữ login, register hoặc logout
    }

    private String trim(String s)  { return s != null ? s.trim() : ""; }
    private boolean blank(String s){ return s == null || s.trim().isEmpty(); }

    private void forward(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {
        req.getRequestDispatcher(view).forward(req, resp);
    }

    private void error(HttpServletRequest req, HttpServletResponse resp,
                       String msg, String view) throws ServletException, IOException {
        req.setAttribute("error", msg);
        forward(req, resp, view);
    }
}