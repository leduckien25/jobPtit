<%-- 
    Document   : postJob
    Created on : Mar 24, 2026, 6:22:00 PM
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
        <h2>Đăng tin tuyển dụng</h2>

        <form method="post" action="postJob">
           Title: <input name="title"><br><br>
           Description: <textarea name="description"></textarea><br><br>
           Location: <input name="location"><br><br>

           <button>Đăng</button>
        </form>

    </body>
</html>
