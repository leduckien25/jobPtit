
package controller;

import dao.ProfileDAO;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.CandidateProfile;

@WebServlet("/profile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8"); // nhận tiếng Việt từ form
        res.setContentType("text/html; charset=UTF-8"); // trả về tiếng Việt
        Object uid = req.getSession().getAttribute("userId");

        if (uid == null) {
            res.sendRedirect("auth");
            return;
        }

        int userId = (int) uid;

        ProfileDAO dao = new ProfileDAO();
        req.setAttribute("profile", dao.getByUserId(userId));

        req.getRequestDispatcher("profile/profile.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");

        // 🔒 check login
        Object uid = req.getSession().getAttribute("userId");
        if (uid == null) {
            res.sendRedirect("auth");
            return;
        }

        int userId = (int) uid;

        ProfileDAO dao = new ProfileDAO();
        CandidateProfile old = dao.getByUserId(userId);

        CandidateProfile p = new CandidateProfile();
        p.setUserId(userId);
        p.setFullName(req.getParameter("fullName"));
        p.setTitle(req.getParameter("title"));
        p.setPhone(req.getParameter("phone"));
        p.setLocation(req.getParameter("location"));
        p.setAboutMe(req.getParameter("aboutMe"));

        // 📁 THƯ MỤC UPLOAD
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // ================== AVATAR ==================
        Part avatar = req.getPart("avatar");
        String avatarName = avatar.getSubmittedFileName();

        if (avatarName != null && !avatarName.isEmpty()) {

            avatarName = new File(avatarName).getName(); // 🔥 fix lỗi trình duyệt
            String fileName = System.currentTimeMillis() + "_" + avatarName;

            avatar.write(uploadPath + File.separator + fileName);

            p.setAvatarUrl("uploads/" + fileName);
        } else if (old != null) {
            p.setAvatarUrl(old.getAvatarUrl());
        }

        // ================== CV ==================
        Part cv = req.getPart("cv");
        String cvName = cv.getSubmittedFileName();

        if (cvName != null && !cvName.isEmpty()) {

            cvName = new File(cvName).getName();
            String fileName = System.currentTimeMillis() + "_" + cvName;

            cv.write(uploadPath + File.separator + fileName);

            p.setCvUrl("uploads/" + fileName);
        } else if (old != null) {
            p.setCvUrl(old.getCvUrl());
        }

        // ================== SAVE ==================
        if (old == null) {
            dao.insert(p);
        } else {
            dao.update(p);
        }

        res.sendRedirect("profile");
    }
}