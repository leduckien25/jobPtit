
package controller;

import dao.ProfileDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CandidateProfile;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int userId = (int) req.getSession().getAttribute("userId");

        ProfileDAO dao = new ProfileDAO();
        req.setAttribute("profile", dao.getByUserId(userId));

        req.getRequestDispatcher("profile/profile.jsp").forward(req, res);
    }
}