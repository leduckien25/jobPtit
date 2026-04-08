package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.User;
import dao.UserDAO;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    // 👉 Hiển thị trang login
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.getRequestDispatcher("/login.jsp").forward(req, res);
    }

    // 👉 Xử lý login
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String email = req.getParameter("email");
        String pass = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User u = dao.login(email, pass);

        if (u != null) {
            req.getSession().setAttribute("userId", u.getId());
            res.sendRedirect("jobs");
        } else {
            res.sendRedirect("auth");
        }
    }
}