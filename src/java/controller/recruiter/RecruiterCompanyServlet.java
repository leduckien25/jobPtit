package controller.recruiter;

import dao.CompanyDAO;
import dao.JobDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Company;
import model.Job;
import model.User;

@WebServlet("/recruiter/my-company")
public class RecruiterCompanyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("LOGIN_USER");

        // ❌ Không phải recruiter thì chặn
        if (user == null || user.getRole() != 2) {
            res.sendError(403);
            return;
        }

        CompanyDAO companyDAO = new CompanyDAO();
        Company company = companyDAO.getByUserId(user.getId());

        // ❗ Nếu chưa có công ty
        if (company == null) {
            res.sendRedirect(req.getContextPath() + "/recruiter/create-company");
            return;
        }

        // Lấy danh sách job của công ty này
        JobDAO jobDAO = new JobDAO();
        List<Job> jobs = jobDAO.findByCompanyId(company.getId());

        req.setAttribute("company", company);
        req.setAttribute("jobs", jobs);

        req.getRequestDispatcher("/views/recruiter/company/myCompany.jsp")
                .forward(req, res);
    }
}
