<%-- 
    Document   : changeGroup
    Created on : Feb 29, 2024, 10:23:35 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Group</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <div class="header">
            <h1>
                FPT University Academic Portal
            </h1>
            <div>
                <div><strong>FAP mobile app (myFap) is ready at</strong></div>
                <div>
                    <img src="https://fap.fpt.edu.vn/images/app-store.png" style="width: 120px; height: 40px" alt="apple store">
                    <img src="https://fap.fpt.edu.vn/images/play-store.png" style="width: 120px; height: 40px" alt="google store">
                </div>
            </div>
        </div>
        <div class="setting">
            <div>
                <form action="../home/login" method="post">
                    <input type="hidden" name="user" value="${account.user}">
                    <input type="hidden" name="password" value="${account.password}">
                    <input type="submit" value="Home">
                </form>
                | <strong>Change Group</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <div style="font-size: 24px;">
            Student ${id}
        </div>

        <div style="color: red; margin: 10px 0 10px 0;">
            ${error}
        </div>
        <c:if test="${error eq null}">
            <div>
                <form action="../group/change" id="form" onchange="document.getElementById('form').submit()">
                    <input type="hidden" name="id" value="${id}">
                    <input type="hidden" name="month" value="${month}">
                    <input type="hidden" name="year" value="${year}">


                    <div class="container">
                        <div class="from">
                            <div>Change from:</div>
                            <div>
                                <span onclick="document.getElementById('form').submit()" class="pointer">
                                    Group:
                                </span>

                                <select name="groupIdFrom">
                                    <c:forEach items="${groupsId}" var="g">
                                        <option value="${g}"
                                                <c:if test="${g eq groupIdFrom}">
                                                    selected="selected"
                                                </c:if>
                                                >
                                            ${g}
                                        </option>
                                    </c:forEach>
                                </select>
                                <span onclick="document.getElementById('form').submit()" class="pointer">
                                    Subject:
                                </span>
                                <select name="subjectIdFrom">
                                    <c:forEach items="${subjectsId}" var="s">
                                        <option value="${s}"
                                                <c:if test="${s eq subjectIdFrom}">
                                                    selected="selected"
                                                </c:if>
                                                >
                                            ${s}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="to">
                            Change to:
                        </div>
                    </div>

                </form>
            </div>
        </c:if>
    </body>
</html>
