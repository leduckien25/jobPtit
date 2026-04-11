
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/auth" method="post">
            Email: <input type="text" name="email" /><br/>
            Password: <input type="password" name="password" /><br/>
            <button type="submit">Login</button>
        </form>
    </body>
</html>