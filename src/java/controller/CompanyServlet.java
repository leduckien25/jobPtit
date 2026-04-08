
package controller;

import dao.CompanyDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;

@WebServlet("/company/*")
public class CompanyServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String path = req.getPathInfo(); // /1

        try {
            if (path == null || path.equals("/")) {
                res.sendError(404);
                return;
            }

            int id = Integer.parseInt(path.substring(1));

            CompanyDAO dao = new CompanyDAO();
            Company c = dao.getById(id);
            if (c == null) {
                res.sendError(404);
                return;
            }
            req.setAttribute("company", c);

            req.getRequestDispatcher("/company/companyDetail.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(404); // ❗ KHÔNG redirect nữa
        }
}
}   