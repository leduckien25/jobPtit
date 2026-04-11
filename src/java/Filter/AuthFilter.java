
package Filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"}) // Bắt TẤT CẢ các đường dẫn
public class AuthFilter implements Filter {

    // Danh sách các trang cho phép vào thoải mái không cần đăng nhập
    private static final Set<String> PUBLIC_URLS = new HashSet<>(Arrays.asList(
            "/auth/login",
            "/auth/register",
            "/auth/forgot-password"
    ));

    // Các thư mục chứa file thiết kế (CSS, ảnh) - Bắt buộc phải cho qua
    private static final String[] STATIC_RESOURCES = { "/css/", "/js/", "/images/", "/fonts/", "/assets/" };

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        String contextPath = request.getContextPath();           // vd: /jobPtit
        String uri         = request.getRequestURI();            // vd: /jobPtit/admin/dashboard
        String path        = uri.substring(contextPath.length()); // vd: /admin/dashboard

        // 1. Cho qua các file CSS, JS, Hình ảnh
        for (String prefix : STATIC_RESOURCES) {
            if (path.startsWith(prefix)) { 
                chain.doFilter(req, res); 
                return; 
            }
        }

        // 2. Cho qua trang gốc (file index.jsp tự đá sang login)
        if (path.equals("/") || path.equals("/index.jsp")) {
            chain.doFilter(req, res);
            return;
        }

        // 3. Cho qua các trang Public (Đăng nhập, Đăng ký)
        for (String pub : PUBLIC_URLS) {
            if (path.equals(pub) || path.startsWith(pub + "?") || path.startsWith(pub + "/")) {
                chain.doFilter(req, res); 
                return;
            }
        }

        // 4. KIỂM TRA ĐĂNG NHẬP (Lõi của AuthFilter)
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("LOGIN_USER") != null);

        if (!isLoggedIn) {
            // Lưu lại đường dẫn người dùng đang cố vào để đăng nhập xong trả về đó
            request.getSession(true).setAttribute("redirectAfterLogin", uri);
            // Chưa đăng nhập thì đá về trang Login
            response.sendRedirect(contextPath + "/auth/login");
            return; // Dừng luồng tại đây!
        }
        chain.doFilter(req, res);
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}