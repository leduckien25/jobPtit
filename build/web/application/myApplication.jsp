<%-- 
    Document   : myApplications
    Created on : Mar 24, 2026, 6:22:33 PM
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
        <h2>Đơn đã nộp</h2>

        <c:forEach var="a" items="${list}">
           <p>Job ID: ${a.jobId}</p>
        </c:forEach>

    </body>
</html>