package controller;

import dao.ProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.File;
import model.CandidateProfile;
import model.User;

@WebServlet("/profile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");

        // Lấy User từ Session đã lưu lúc Login
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("LOGIN_USER");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        ProfileDAO dao = new ProfileDAO();
        CandidateProfile profile = dao.getByUserId(user.getId());
        
        // Nếu chưa có profile trong DB, tạo một đối tượng rỗng để tránh lỗi JSP
        if (profile == null) {
            profile = new CandidateProfile();
            profile.setFullName(""); 
        }

        req.setAttribute("profile", profile);
        req.getRequestDispatcher("/views/profile/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("LOGIN_USER");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        int userId = user.getId();
        ProfileDAO dao = new ProfileDAO();
        CandidateProfile old = dao.getByUserId(userId);

        CandidateProfile p = new CandidateProfile();
        p.setUserId(userId);
        p.setFullName(req.getParameter("fullName"));
        p.setTitle(req.getParameter("title"));
        p.setPhone(req.getParameter("phone"));
        p.setLocation(req.getParameter("location"));
        p.setAboutMe(req.getParameter("aboutMe"));

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Xử lý AVATAR
        Part avatarPart = req.getPart("avatar");
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + new File(avatarPart.getSubmittedFileName()).getName();
            avatarPart.write(uploadPath + File.separator + fileName);
            p.setAvatarUrl("uploads/" + fileName);
        } else if (old != null) {
            p.setAvatarUrl(old.getAvatarUrl());
        }

        // Xử lý CV
        Part cvPart = req.getPart("cv");
        if (cvPart != null && cvPart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + new File(cvPart.getSubmittedFileName()).getName();
            cvPart.write(uploadPath + File.separator + fileName);
            p.setCvUrl("uploads/" + fileName);
        } else if (old != null) {
            p.setCvUrl(old.getCvUrl());
        }

        if (old == null) {
            dao.insert(p);
        } else {
            dao.update(p);
        }

        res.sendRedirect("profile");
    }
}