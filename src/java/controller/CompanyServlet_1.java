package controller;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Company;
import dao.JobDAO;
import java.util.List;
import model.Job;


@WebServlet("/company")
public class CompanyServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String idParam = req.getParameter("id");

        if (idParam == null) {
            res.sendError(404);
            return;
        }

        int companyId;
        try {
            companyId = Integer.parseInt(idParam);
        } catch (Exception e) {
            res.sendError(400);
            return;
        }

        CompanyDAO companyDAO = new CompanyDAO();
        Company company = companyDAO.findById(companyId);

        if (company == null || company.getIsVerified() != 1) {
            res.sendError(404);
            return;
        }

        // 🔥 LẤY JOB THEO COMPANY
        JobDAO jobDAO = new JobDAO();
        List<Job> jobs = jobDAO.findByCompanyId(companyId);

        req.setAttribute("company", company);
        req.setAttribute("jobs", jobs);

        req.getRequestDispatcher("/views/company/companyDetail.jsp")
                .forward(req, res);
    }
}