<%-- 
    Document   : changeSession
    Created on : Mar 12, 2024, 8:51:49 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Session</title>
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
                | <strong>Change Session</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <form action="../lecturer/changeSession" method="get" style="width: 100%" id="form" onchange="document.getElementById('form').submit()">
            <input type="hidden" name="lecturerId" value="${schedule.lecturerId}">
            <input type="hidden" name="groupId" value="${schedule.groupId}">
            <input type="hidden" name="subjectId" value="${schedule.subjectId}">
            <input type="hidden" name="fromRoomId" value="${schedule.roomId}">
            <input type="hidden" name="fromSlotId" value="${schedule.slotId}">
            <input type="hidden" name="fromDate" value="${schedule.date}">
            From:
            <table style="width: 100%">
                <thead>
                    <tr>
                        <th>
                            Group
                        </th>
                        <th>
                            Subject
                        </th>
                        <th>
                            Slot
                        </th>
                        <th>
                            Room
                        </th>
                        <th>
                            Date
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            ${schedule.groupId}
                        </td>
                        <td>
                            ${schedule.subjectId}
                        </td>
                        <td>
                            ${schedule.slotId}
                        </td>
                        <td>
                            ${schedule.roomId}
                        </td>
                        <td>
                            ${schedule.date}
                        </td>
                    </tr>
                </tbody>
            </table>
            To:
            <table style="width: 100%">
                <thead>
                    <tr>
                        <th>
                            Date
                        </th>
                        <th>
                            Slot
                        </th>
                        <th>
                            Room
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="date" name="toDate" value="${toDate==null?schedule.date:toDate}" min="${now}">
                        </td>
                        <td>
                            <c:if test="${slots ne null}">
                                <select name="toSlotId">
                                    <c:forEach items="${slots}" var="s">
                                        <option value="${s}"
                                                <c:if test="${toSlotId == s}">
                                                    selected="selected"
                                                </c:if>
                                                >
                                            ${s}
                                        </option>
                                    </c:forEach>
                                </select>    
                            </c:if>

                        </td>
                        <td>
                            <c:if test="${rooms ne null}">
                                <select name="toRoomId">
                                    <c:forEach items="${rooms}" var="r">
                                        <option value="${r}"
                                                <c:if test="${toRoomId == r}">
                                                    selected="selected"
                                                </c:if>
                                                >
                                            ${r}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:if>
                        </td>

                    </tr>
                </tbody>
            </table>
        </form>
        <c:if test="${toRoomId ne null}">
            <form action="../lecturer/changeSession" method="post">
                <input type="hidden" name="lecturerId" value="${schedule.lecturerId}">
                <input type="hidden" name="fromSlotId" value="${schedule.slotId}">
                <input type="hidden" name="fromDate" value="${schedule.date}">
                <input type="hidden" name="toDate" value="${toDate}">
                <input type="hidden" name="toSlotId" value="${toSlotId}">
                <input type="hidden" name="toRoomId" value="${toRoomId}">
                <input type="submit" value="Submit">
            </form>                        
        </c:if>

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
