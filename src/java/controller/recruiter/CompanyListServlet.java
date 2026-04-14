package controller.recruiter;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Company;

@WebServlet("/companies")
public class CompanyListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        CompanyDAO dao = new CompanyDAO();

        List<Company> list = dao.findPaged(null, null, 1, 20);

        req.setAttribute("companies", list);
        req.getRequestDispatcher("/views/recruiter/company/companyList.jsp")
           .forward(req, res);
    }
}