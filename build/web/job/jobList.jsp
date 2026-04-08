<%-- 
    Document   : jobList
    Created on : Mar 24, 2026, 6:17:28 PM
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
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <h2>Danh sách việc làm</h2>

        <c:forEach var="j" items="${list}">
           <div style="border:1px solid #ccc; margin:10px; padding:10px;">
               <h3>${j.title}</h3>
               <p>${j.description}</p>
               <p>${j.location}</p>

                <a href="${pageContext.request.contextPath}/company?id=${j.companyId}">
                    Xem công ty
                </a>

                <form action="apply" method="post">
                    <input type="hidden" name="jobId" value="${j.id}">
                    <button>Nộp CV</button>
                </form>
           </div>
        </c:forEach>

    </body>
</html>
