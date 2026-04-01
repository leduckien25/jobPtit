
package controller;

import dao.CompanyDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;

@WebServlet("/company")
public class CompanyServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        CompanyDAO dao = new CompanyDAO();
        req.setAttribute("company", dao.getById(id));

        req.getRequestDispatcher("company/companyDetail.jsp").forward(req, res);
    }
}