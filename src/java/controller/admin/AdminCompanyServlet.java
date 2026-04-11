/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.admin;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Company;

@WebServlet(name = "AdminCompanyServlet", urlPatterns = {"/admin/companies/*"})
public class AdminCompanyServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10;
    private final CompanyDAO dao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        switch (getAction(req)) {
            case "list"   -> list(req, resp);
            case "detail" -> detail(req, resp);
            default       -> resp.sendRedirect(req.getContextPath() + "/admin/companies/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        switch (getAction(req)) {
            case "approve" -> approve(req, resp);
            case "reject"  -> reject(req, resp);
            //case "delete"  -> delete(req, resp);
            default        -> resp.sendRedirect(req.getContextPath() + "/admin/companies/list");
        }
    }

    // ── XỬ LÝ GET ──────────────────────────────────────────────────

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword   = req.getParameter("keyword");
        String statusStr = req.getParameter("status"); // Sẽ nhận giá trị "0", "1", "2"
        int page         = intParam(req, "page", 1);

        Integer isVerified = parseStatus(statusStr);
        // Tìm kiếm công ty
        List<Company> list = dao.findPaged(keyword, isVerified, page, PAGE_SIZE);
        int total          = dao.countPaged(keyword, isVerified);
        int totalPages     = (int) Math.ceil((double) total / PAGE_SIZE);

        
        req.setAttribute("listCompany", list); 
        req.setAttribute("total",       total);
        req.setAttribute("page",        page);
        req.setAttribute("totalPages",  totalPages);
        req.setAttribute("keyword",     keyword);
        req.setAttribute("statusStr",   statusStr);

        // Trỏ về đúng file giao diện đã tạo
        req.getRequestDispatcher("/views/admin/companies/list.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = intParam(req, "id", 0);
        Company company = dao.findById(id);
        if (company == null) { 
            resp.sendRedirect(req.getContextPath() + "/admin/companies/list"); 
            return; 
        }
        req.setAttribute("company", company);
        // Tạm thời trỏ về file chưa tồn tại, bạn sẽ tạo trang này sau nếu cần
        req.getRequestDispatcher("/views/admin/companies/detail.jsp").forward(req, resp);
    }

    // ── XỬ LÝ POST (ACTIONS) ───────────────────────────────────────

    private void approve(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = intParam(req, "id", 0);
        boolean ok = dao.approve(id);
        flash(req, ok ? "successMsg" : "errorMsg", ok ? "Duyệt công ty thành công!" : "Duyệt thất bại!");
        resp.sendRedirect(req.getContextPath() + "/admin/companies/list");
    }

    private void reject(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = intParam(req, "id", 0);
        boolean ok = dao.reject(id);
        flash(req, ok ? "successMsg" : "errorMsg", ok ? "Đã từ chối/khóa công ty!" : "Từ chối thất bại!");
        resp.sendRedirect(req.getContextPath() + "/admin/companies/list");
    }

//    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        int id = intParam(req, "id", 0);
//        boolean ok = dao.delete(id);
//        flash(req, ok ? "successMsg" : "errorMsg", ok ? "Đã xóa công ty!" : "Xóa thất bại!");
//        resp.sendRedirect(req.getContextPath() + "/admin/companies/list");
//    }

    // ── HÀM HỖ TRỢ (HELPERS) ───────────────────────────────────────

    // Cắt chuỗi URL để tìm Action (vd: /admin/companies/approve -> approve)
    private String getAction(HttpServletRequest req) {
        String pi = req.getPathInfo();
        return (pi == null || pi.equals("/")) ? "list" : pi.substring(1).toLowerCase();
    }

    private int intParam(HttpServletRequest req, String name, int def) {
        try { return Integer.parseInt(req.getParameter(name)); } catch (Exception e) { return def; }
    }

    // Chuyển chuỗi status thành số nguyên để đưa vào hàm của Database
    private Integer parseStatus(String s) {
        if (s == null || s.isBlank()) return null;
        try { return Integer.parseInt(s); } catch (Exception e) { return null; }
    }

    // Gắn thông báo vào Session (tái sử dụng biến successMsg/errorMsg của file JSP)
    private void flash(HttpServletRequest req, String type, String msg) {
        req.getSession(true).setAttribute(type, msg);
    }
}