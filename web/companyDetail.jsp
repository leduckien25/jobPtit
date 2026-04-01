
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>${company.name}</h2>
        <p>${company.location}</p>
        <p>${company.description}</p>

        <img src="${company.logoUrl}" width="100"/>
    </body>
</html>
