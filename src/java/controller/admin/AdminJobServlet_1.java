
package controller.admin;

import dao.JobDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Job;

@WebServlet(name = "AdminJobServlet", urlPatterns = {"/admin/jobs/*"})
public class AdminJobServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private final JobDAO dao = new JobDAO();
 
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        switch (getAction(req)) {
            case "list"   -> list(req, resp);
            case "detail" -> detail(req, resp);
            default       -> resp.sendRedirect(req.getContextPath() + "/admin/jobs/list");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        switch (getAction(req)) {
            case "approve" -> approve(req, resp);
            case "reject"  -> reject(req, resp);
            default        -> resp.sendRedirect(req.getContextPath() + "/admin/jobs/list");
        }
    }
    
    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword   = req.getParameter("keyword");
        String statusStr = req.getParameter("status"); 
        int page         = intParam(req, "page", 1);

        // Chuyển statusStr thành số (0=Pending, 1=Active, 2=Expired, 3=Rejected)
        Integer status = parseStatus(statusStr);
        
        List<Job> list = dao.findPaged(keyword, status, page, PAGE_SIZE);
        int total      = dao.countPaged(keyword, status);
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);

        req.setAttribute("listJob",    list);
        req.setAttribute("total",      total);
        req.setAttribute("page",       page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword",    keyword);
        req.setAttribute("statusStr",  statusStr);

        // Trỏ về đúng thư mục chứa giao diện (Rút kinh nghiệm lỗi 404 lần trước nhé!)
        req.getRequestDispatcher("/views/admin/jobs/list.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = intParam(req, "id", 0);
        Job job = dao.findById(id);
        
        if (job == null) { 
            resp.sendRedirect(req.getContextPath() + "/admin/jobs/list"); 
            return; 
        }
        
        req.setAttribute("job", job);
        req.getRequestDispatcher("/views/admin/jobs/detail.jsp").forward(req, resp);
    }
    
    private void approve(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = intParam(req, "id", 0);
        boolean ok = dao.approve(id);
        flash(req, ok ? "successMsg" : "errorMsg", ok ? "Đã duyệt bài đăng thành công!" : "Lỗi khi duyệt bài!");
        resp.sendRedirect(req.getContextPath() + "/admin/jobs/list");
    }

    private void reject(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = intParam(req, "id", 0);
        boolean ok = dao.reject(id);
        flash(req, ok ? "successMsg" : "errorMsg", ok ? "Đã từ chối bài đăng!" : "Lỗi khi từ chối bài!");
        resp.sendRedirect(req.getContextPath() + "/admin/jobs/list");
    }

    // ── HÀM HỖ TRỢ ─────────────────────────────────────────────────

    private String getAction(HttpServletRequest req) {
        String pi = req.getPathInfo();
        return (pi == null || pi.equals("/")) ? "list" : pi.substring(1).toLowerCase();
    }

    private int intParam(HttpServletRequest req, String name, int def) {
        try { return Integer.parseInt(req.getParameter(name)); } catch (Exception e) { return def; }
    }

    private Integer parseStatus(String s) {
        if (s == null || s.isBlank()) return null;
        try { return Integer.parseInt(s); } catch (Exception e) { return null; }
    }

    private void flash(HttpServletRequest req, String type, String msg) {
        req.getSession(true).setAttribute(type, msg);
    }
}
