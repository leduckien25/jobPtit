
package controller;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import model.Company;

 @WebServlet("/company")
public class CompanyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        try {
            User userIdObj = (User) req.getSession().getAttribute("LOGIN_USER");
            if (userIdObj == null) {
                res.sendRedirect("auth"); // Quay về trang login
                return;
            }

            int id = userIdObj.getId();
            CompanyDAO dao = new CompanyDAO();
            Company c = dao.getByUserId(id);
            System.out.println(c);
            if (c == null) {
                res.sendError(404);
                return;
            }

            req.setAttribute("company", c);
            req.getRequestDispatcher("/views/company/companyDetail.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(404);
        }
    }
}