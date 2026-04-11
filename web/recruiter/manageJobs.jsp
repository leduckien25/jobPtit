<%-- 
    Document   : manageJobs
    Created on : Mar 24, 2026, 6:22:10 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Quản lý job</h2>

        <c:forEach var="j" items="${list}">
           <p>${j.title}</p>
        </c:forEach>

    </body>
</html>