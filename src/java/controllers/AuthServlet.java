package controllers;

import java.io.IOException;


import models.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            res.sendRedirect("job-manage");
        } else {
            res.sendRedirect("auth");
        }
    }
}