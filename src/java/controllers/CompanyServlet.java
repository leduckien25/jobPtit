
package controllers;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import models.Company;

 @WebServlet("/company")
public class CompanyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        try {
            Object userIdObj = req.getSession().getAttribute("userId");
            if (userIdObj == null) {
                res.sendRedirect("auth"); // Quay về trang login
                return;
            }

            int id = Integer.parseInt(userIdObj.toString());
            CompanyDAO dao = new CompanyDAO();
            Company c = dao.getById(id);
            System.out.println(c);
            if (c == null) {
                res.sendError(404);
                return;
            }

            req.setAttribute("company", c);
            req.getRequestDispatcher("/company/companyDetail.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(404);
        }
    }
}