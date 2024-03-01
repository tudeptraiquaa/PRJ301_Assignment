<%-- 
    Document   : viewAttendance
    Created on : Feb 19, 2024, 8:35:46 AM
    Author     : tu
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attendance Student</title>
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
                | <strong>View Attendance</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <h3>Attendance student ${id}</h3>
        <div style="display: flex">
            <div class="term" style="width: 10%">
                <h4>TERM</h4>
                <c:forEach items="${requestScope.terms}" var="t">
                    <div class="term_item">
                        <a href="../student/attendance?id=${requestScope.id}&termId=${t.id}&year=${t.year}">
                            <c:if test="${requestScope.termId eq t.id}">
                                <b>${t.name}${t.year}</b>
                            </c:if>

                            <c:if test="${requestScope.termId ne t.id}">
                                ${t.name}${t.year}
                            </c:if>    
                        </a></br>
                    </div>
                </c:forEach>
            </div>

            <div class="course">
                <h4>COURSE</h4>
                <c:forEach items="${requestScope.subjects}" var="s">
                    <div class="course_item">
                        <a href="../student/attendance?id=${requestScope.id}&termId=${requestScope.termId}
                           &year=${requestScope.year}&subjectId=${s.id}">
                            <c:if test="${s.id eq requestScope.subjectId}">
                                <b>- ${s.name}(${s.id})</b>
                            </c:if>

                            <c:if test="${s.id ne requestScope.subjectId}">
                                - ${s.name}(${s.id})
                            </c:if>    
                        </a></br>
                        <span>(${s.groupId}, from ${s.dateBegin.day}/${s.dateBegin.month}/${s.dateBegin.year} - ${s.dateEnd.day}/${s.dateEnd.month}/${s.dateBegin.year})</span>
                    </div>
                </c:forEach>
            </div> 
            <c:if test="${requestScope.subjectId ne null}">
                <div class="attendance">
                    <table>
                        <thead>
                            <tr>
                                <th>
                                    NO
                                </th>
                                <th>
                                    DATE
                                </th>
                                <th>
                                    SLOT
                                </th>
                                <th>
                                    ROOM
                                </th>
                                <th>
                                    LECTURER
                                </th>
                                <th>
                                    GROUP
                                </th>
                                <th>
                                    ATTENDANCE STATUS
                                </th>
                                <th>
                                    LECTURER'S COMMENT
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set value="1" var="count"/>
                            <c:set var="numLession" value="0"/>
                            <c:set var="numAbsent" value="0"/>
                            <c:forEach items="${requestScope.attendances}" var="a">
                                <c:if test="${a.date.compare(requestScope.now) <= 0}">
                                    <c:set var="numLession" value="${numLession + 1}"/>
                                </c:if>
                                <tr>
                                    <td>
                                        ${count}
                                        <c:set value="${count+1}" var="count"/>
                                    </td>
                                    <td>
                                        <span class="date">
                                            ${a.date.weekday} ${a.date.day}/${a.date.month}/${a.date.year}    
                                        </span>
                                    </td>
                                    <td>
                                        <span class="slot">
                                            ${a.slot.id}_(${a.slot.startTime}-${a.slot.endTime})    
                                        </span>

                                    </td>
                                    <td>
                                        ${a.roomId}
                                    </td>
                                    <td>
                                        ${a.lecturerId}
                                    </td>
                                    <td>
                                        ${a.groupId}
                                    </td>
                                    <td>
                                        <c:if test="${a.date.compare(requestScope.now) < 0 and !a.status and !a.takenGroup}">
                                            <span style="color: red">Absent</span>
                                            <c:set var="numAbsent" value="${numAbsent + 1}"/>
                                        </c:if>
                                        <c:if test="${!a.status and a.takenGroup}">
                                            <span style="color: red">Absent</span>
                                            <c:set var="numAbsent" value="${numAbsent + 1}"/>
                                        </c:if>

                                        <c:if test="${a.status}">
                                            <span style="color: green">Present</span>
                                        </c:if>

                                        <c:if test="${a.date.compare(now) >= 0 and !a.status and !a.takenGroup}">
                                            <span>Future</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        ${a.description}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="absent">
                        <h3>
                            <b>Absent: <fmt:formatNumber value="${numAbsent/(count-1)*100}" pattern="#.#" />% (${numAbsent} on ${count-1} total)</b>
                        </h3>
                    </div>

                </div>
            </c:if>
        </div>
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
