<%-- 
    Document   : attendance
    Created on : Feb 17, 2024, 6:51:23 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attendance</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <div class="setting">
            <div>
                <form action="../home/login" method="post">
                    <input type="hidden" name="user" value="${account.user}">
                    <input type="hidden" name="password" value="${account.password}">
                    <input type="submit" value="Home">
                </form>
                | <strong>Attendance</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <h3>
            Take attendance group ${groupId} (${subjectId})
        </h3>
        <form action="../group/attendance" method="post" class="form">
            <input type="hidden" name="lecturerId" value="${requestScope.lecturerId}">
            <input type="hidden" name="groupId" value="${requestScope.groupId}">
            <input type="hidden" name="subjectId" value="${requestScope.subjectId}">
            <input type="hidden" name="date" value="${requestScope.date}">
            <input type="hidden" name="slotId" value="${requestScope.slotId}">
            <input type="hidden" name="week" value="${requestScope.week}">
            <input type="hidden" name="year" value="${requestScope.year}">
            <table>
                <thead>
                    <tr>
                        <th>
                            No
                        </th>
                        <th>
                            GROUP
                        </th>
                        <th>
                            ID
                        </th>
                        <th>
                            NAME
                        </th>
                        <th>
                            IMAGE
                        </th>
                        <th>
                            STATUS
                        </th>
                        <th>
                            DESCRIPTION
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="1"/>
                    <c:forEach items="${requestScope.students}" var="s">
                        <tr>
                            <td class="no">
                                ${count}
                                <c:set var="count" value="${count+1}"/>
                            </td>
                            <td>
                                ${requestScope.groupId}
                            </td>
                            <td>
                                <input type="hidden" name="id" value="${s.id}">
                                ${s.id}
                            </td>
                            <td>
                                ${s.name}
                            </td>
                            <td class="img">
                                img
                            </td>
                            <td>
                                <div style="width: 200px">
                                    Absent <input type="radio" name="${s.id}status" value="0"> 
                                    Present <input type="radio" name="${s.id}status" value="1" checked>
                                </div>
                            </td>
                            <td>
                                <input type="text" name="${s.id}description">
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="button">
                <input type="reset" value="Reset" style="color: red;">
                <input type="submit" value="Save" style="color: green;">  
            </div>
        </form>
    </body>
</html>
