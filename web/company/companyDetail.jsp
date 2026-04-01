
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>${company.name}</h2>

        <img src="${company.logoUrl}" width="150"><br><br>

        <p>${company.description}</p>
        <p>Địa điểm: ${company.location}</p>

    </body>
</html>
