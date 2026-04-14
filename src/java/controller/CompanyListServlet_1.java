package controller;

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

        int page = 1;
        int pageSize = 6;

        try {
            if (req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page"));
            }
        } catch (Exception e) {
            page = 1;
        }

        CompanyDAO dao = new CompanyDAO();

        // chỉ lấy công ty đã duyệt
        List<Company> list = dao.findPaged(null, 1, page, pageSize);
        int total = dao.countPaged(null, 1);

        int totalPages = (int) Math.ceil((double) total / pageSize);

        req.setAttribute("companies", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/company/companyList.jsp")
                .forward(req, res);
    }
}