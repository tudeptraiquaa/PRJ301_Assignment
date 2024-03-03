<%-- 
    Document   : success3layer
    Created on : Feb 28, 2024, 9:43:34 AM
    Author     : tu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        ${change}
        <form action="../../home/login" method="post">
            <input type="hidden" name="user" value="${account.user}">
            <input type="hidden" name="password" value="${account.password}">
            <input type="submit" value="Home">
        </form>
    </body>
</html>
