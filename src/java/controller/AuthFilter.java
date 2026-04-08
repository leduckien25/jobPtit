
package controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
        throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String context = request.getContextPath();

        String path = uri.substring(context.length());

        // DEBUG
        System.out.println("PATH: " + path);

        // ✅ Cho phép static + jsp + public API
        if (
            path.startsWith("/login") ||
            path.startsWith("/jobs") ||
            path.startsWith("/company") ||
            path.endsWith(".jsp") ||
            path.startsWith("/uploads")
        ) {
            chain.doFilter(req, res);
            return;
        }

        // check login
        if (request.getSession().getAttribute("userId") == null) {
            response.sendRedirect(context + "/login");
            return;
        }

        chain.doFilter(req, res);
    }
}