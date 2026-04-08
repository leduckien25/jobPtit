
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

        Object uid = req.getSession().getAttribute("userId");

        if (uid == null) {
            res.sendRedirect("login");
            return;
        }

        int userId = (int) uid;

        ProfileDAO dao = new ProfileDAO();
        req.setAttribute("profile", dao.getByUserId(userId));

        req.getRequestDispatcher("profile/profile.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        // 🔒 check login
        Object uid = req.getSession().getAttribute("userId");
        if (uid == null) {
            res.sendRedirect("login");
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

        // 📁 Upload avatar
        Part avatar = req.getPart("avatar");
        String avatarName = avatar.getSubmittedFileName();

        if (avatarName != null && !avatarName.isEmpty()) {
            String path = getServletContext().getRealPath("/uploads");

            // tạo folder nếu chưa có
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdir();
            }

            // tránh trùng tên
            String fileName = System.currentTimeMillis() + "_" + avatarName;

            avatar.write(path + "/" + fileName);
            p.setAvatarUrl("uploads/" + fileName);
        } else {
            // giữ avatar cũ
            if (old != null) {
                p.setAvatarUrl(old.getAvatarUrl());
            }
        }

        // 📁 Upload CV
        Part cv = req.getPart("cv");
        String cvName = cv.getSubmittedFileName();

        if (cvName != null && !cvName.isEmpty()) {
            String path = getServletContext().getRealPath("/uploads");

            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdir();
            }

            String fileName = System.currentTimeMillis() + "_" + cvName;

            cv.write(path + "/" + fileName);
            p.setCvUrl("uploads/" + fileName);
        } else {
            // giữ CV cũ
            if (old != null) {
                p.setCvUrl(old.getCvUrl());
            }
        }

        if (old == null) {
            dao.insert(p);
        } else {
            dao.update(p);
        }

        res.sendRedirect("profile");
    }
}