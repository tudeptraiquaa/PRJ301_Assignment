<%-- 
    Document   : viewAttendance
    Created on : Feb 17, 2024, 9:12:00 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
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
                | <strong>View Attendance</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <h3>
            Attendance Group ${groupId} (${subjectId})
        </h3>
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
                            ${a.studentId}
                        </td>
                        <td>
                            ${a.studentName}
                        </td>
                        <td class="img">
                            img
                        </td>
                        <td>
                            <c:if test="${!a.status}">
                                <p style="color: red">Absent</p>
                            </c:if>
                            <c:if test="${a.status}">
                                <p style="color: green">Present</p>
                            </c:if>
                        </td>
                        <td>
                            <input type="text" value="${a.description}" disabled>
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
