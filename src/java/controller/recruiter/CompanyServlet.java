package controller.recruiter;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Company;
import model.User;

@WebServlet("/companies/*")
public class CompanyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            
            String idParam = req.getPathInfo().substring(1);


            if (idParam == null) {
                res.sendError(404);
                return;
            }

            int companyId = Integer.parseInt(idParam);

            CompanyDAO dao = new CompanyDAO();
            Company c = dao.findById(companyId);

            if (c == null) {
                res.sendError(404);
                System.out.println("Lỗi không thấy công ty");
                return;
            }

            req.setAttribute("company", c);
            req.getRequestDispatcher("/views/candidate/company/companyDetail.jsp")
               .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(500);
        }
    }
}