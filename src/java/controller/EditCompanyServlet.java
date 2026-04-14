
package controller;

import dao.CompanyDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import model.Company;
import model.User;

@MultipartConfig
@WebServlet("/recruiter/edit-company")
public class EditCompanyServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("LOGIN_USER");

        CompanyDAO dao = new CompanyDAO();
        Company company = dao.getByUserId(user.getId());

        req.setAttribute("company", company);
        req.getRequestDispatcher("/views/company/editCompany.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        User user = (User) req.getSession().getAttribute("LOGIN_USER");

        String name = req.getParameter("name");
        String location = req.getParameter("location");
        String description = req.getParameter("description");

        CompanyDAO dao = new CompanyDAO();
        Company company = dao.getByUserId(user.getId());

        // ========================
        // XỬ LÝ FILE UPLOAD
        // ========================
        Part filePart = req.getPart("logoFile");

        if (filePart != null && filePart.getSize() > 0) {

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            // đường dẫn tới thư mục uploads
            String uploadPath = getServletContext().getRealPath("/uploads");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);

            // lưu vào DB
            company.setLogoUrl("uploads/" + fileName);
        }

        // update info
        company.setName(name);
        company.setLocation(location);
        company.setDescription(description);

        dao.update(company);

        res.sendRedirect(req.getContextPath() + "/recruiter/my-company");
    }
}