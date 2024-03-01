<%-- 
    Document   : editAttendance
    Created on : Feb 18, 2024, 6:19:42 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Attendance</title>
        <link rel="stylesheet" href="../../css/style.css">
    </head>
    <body>
        <div class="setting">
            <div>
                <form action="../../home/login" method="post">
                    <input type="hidden" name="user" value="${account.user}">
                    <input type="hidden" name="password" value="${account.password}">
                    <input type="submit" value="Home">
                </form>
                | <strong>Edit Attendance</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <h3>
            Edit attendance group ${groupId} (${subjectId})
        </h3>
        <form action="../../group/attendance/edit" method="post">
            <input type="hidden" name="id" value="${requestScope.id}">
            <input type="hidden" name="adminId" value="${requestScope.adminId}">
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
                        <th>
                            TAKER
                        </th>
                        <th>
                            RECORD TIME
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="1"/>
                    <c:forEach items="${requestScope.attendances}" var="a">
                        <tr>
                            <td class="no">
                                ${count}
                                <c:set var="count" value="${count+1}"/>
                            </td>
                            <td>
                                ${a.groupId}
                            </td>
                            <td>
                                <input type="hidden" name="studentId" value="${a.studentId}">
                                ${a.studentId}
                            </td>
                            <td>
                                ${a.studentName}
                            </td>
                            <td class="img">
                                img
                            </td>
                            <td>
                                Absent <input type="radio" name="${a.studentId}status" value="0" <c:if test="${!a.status}">checked</c:if>> 
                                Present <input type="radio" name="${a.studentId}status" value="1" <c:if test="${a.status}">checked</c:if>>
                                </td>
                                <td>
                                    <input type="text" name="${a.studentId}description" value="${a.description}">
                            </td>
                            <td>
                                ${a.taker}
                            </td>
                            <td>
                                ${a.timeRecord}
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
