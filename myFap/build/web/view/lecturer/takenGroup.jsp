<%-- 
    Document   : takenGroup
    Created on : Feb 21, 2024, 8:05:01 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Taken Group</title>
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
        <div style="font-size: 24px; margin: 20px">
            Today activity (${date})
        </div>
        <table>
            <thead>
                <tr>
                    <th>
                        SLOT
                    </th>
                    <th>
                        SUBJECT
                    </th>
                    <th>
                        GROUP
                    </th>
                    <th>
                        ROOM
                    </th>
                    <th>
                        TAKEN ATTENDANCE
                    </th>
                    <th>
                        VIEW ATTENDANCE
                    </th>
                    <th>
                        EDIT ATTENDANCE
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.schedules}" var="sche">
                    <tr>
                        <td class="slot">
                            ${sche.slotId}
                        </td>
                        <td class="subject">
                            ${sche.subjectName}
                        </td>
                        <td>
                            ${sche.groupId}
                        </td>
                        <td>
                            ${sche.roomId}
                        </td>
                        <td>
                            <c:if test="${sche.status}">
                                Taken
                            </c:if>
                            <c:if test="${!sche.status}">
                                <a href="../group/attendance?id=${sche.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                    Take
                                </a>    
                            </c:if>
                        </td>
                        <td>

                            <c:if test="${sche.status}">
                                <a href="../group/attendance/view?id=${sche.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                    View Attendance
                                </a>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${sche.status}">
                                <a href="../group/attendance/edit?id=${sche.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                    Edit Attendance
                                </a>
                            </c:if>  
                        </td>
                    </tr>
                </c:forEach>

            </tbody>
        </table>
        <div class="footer">
            <div id="ctl00_divSupport" style="text-align: center; border-bottom: 1px solid #f5f5f5; padding-bottom: 5px">
                <br>
                <b style="text-align: center">Mọi góp ý, thắc mắc xin liên hệ: </b>
                <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13.333333969116211px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;">Phòng dịch vụ sinh viên</span>
                : Email: <a href="mailto:dichvusinhvien@fe.edu.vn">dichvusinhvien@fe.edu.vn</a>.
                Điện thoại: 
                <span class="style1" style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13.333333969116211px; font-style: normal; font-variant: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;">(024)7308.13.13 </span>
                <br>
            </div>
            <p style="text-align: center">
                © Powered by <a href="http://fpt.edu.vn" target="_blank">FPT University</a>&nbsp;|&nbsp;
                <a href="http://cms.fpt.edu.vn/" target="_blank">CMS</a>&nbsp;|&nbsp; <a href="http://library.fpt.edu.vn" target="_blank">library</a>&nbsp;|&nbsp; <a href="http://library.books24x7.com" target="_blank">books24x7</a>
                <span id="ctl00_lblHelpdesk"></span>
            </p>
        </div>
    </body>
</html>
