<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Tự động chuyển hướng sang Servlet xử lý đăng nhập
    response.sendRedirect(request.getContextPath() + "/auth/login");
%>