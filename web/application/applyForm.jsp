<%-- 
    Document   : applyForm
    Created on : Mar 24, 2026, 6:22:25 PM
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
        <h2>Nộp CV</h2>

        <form method="post" action="apply">
           <input type="hidden" name="jobId" value="${jobId}">
           <button>Xác nhận nộp</button>
        </form>

    </body>
</html>
