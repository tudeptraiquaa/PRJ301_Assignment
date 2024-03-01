<%-- 
    Document   : success
    Created on : Feb 22, 2024, 9:40:08 PM
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
        Change Success!
        <form action="../home/login" method="post">
            <input type="hidden" name="user" value="${account.user}">
            <input type="hidden" name="password" value="${account.password}">
            <input type="submit" value="Home">
        </form>
    </body>
</html>
