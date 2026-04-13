/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.candidate;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import model.Category;
import model.User;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/categories/*"})
public class CategoryServlet extends HttpServlet {
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("LOGIN_USER") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("LOGIN_USER");

        if (user.getRole() != 1) {
            // Không phải Admin -> Báo lỗi 403 (Cấm truy cập)
            request.getRequestDispatcher("/views/error/forbidden.jsp").forward(request, response);
            return; 
        }
        
        Map<Category, Integer> categoryMap = new CategoryDAO().getCategoriesWithCount();
        request.setAttribute("categoryMap", categoryMap);
        
        request.getRequestDispatcher("/views/candidate/category/categoryList.jsp").forward(request, response);
    }
}
