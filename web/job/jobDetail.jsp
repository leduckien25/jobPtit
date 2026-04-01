<%-- 
    Document   : jobDetail
    Created on : Mar 24, 2026, 6:21:48 PM
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
        <h2>Chi tiết công việc</h2>

        <h3>${job.title}</h3>
        <p>${job.description}</p>
        <p>${job.location}</p>

        <a href="company?id=${job.companyId}">Xem công ty</a>

    </body>
</html>
