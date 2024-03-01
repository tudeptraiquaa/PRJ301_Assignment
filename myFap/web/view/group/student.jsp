<%-- 
    Document   : student.jsp
    Created on : Feb 17, 2024, 5:29:23 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Student</title>
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
                | <strong>View Group Student</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <div class="container">
            <div class="term">
                <h4>TERM</h4>

                <c:forEach items="${requestScope.termGroup}" var="t">
                    <c:if test="${account.role ne 1}">
                        <div class="term_item">
                            <a href="../group/student?termId=${t.id}&year=${t.year}&id=${requestScope.id}">
                                <p
                                    <c:if test="${requestScope.date.year eq t.year and requestScope.date.month >= t.monthBegin and requestScope.date.month <= t.monthEnd}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>
                                    <c:if test="${requestScope.termId eq t.id and requestScope.year eq t.year}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>        
                                    >
                                    ${t.name}${t.year}
                                </p>
                            </a>
                        </div>
                    </c:if>

                    <c:if test="${account.role eq 1}">
                        <div class="term_item">
                            <a href="">
                                <p
                                    <c:if test="${requestScope.date.year eq t.year and requestScope.date.month >= t.monthBegin and requestScope.date.month <= t.monthEnd}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>
                                    <c:if test="${requestScope.termId eq t.id and requestScope.year eq t.year}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>        
                                    >
                                    ${t.name}${t.year}
                                </p>
                            </a>
                        </div>
                    </c:if>
                </c:forEach>    
            </div
        </div>

        <div class="group">
            <h4>GROUP</h4>
            <div>
                <c:forEach items="${requestScope.groupsId}" var="g">
                    <c:if test="${account.role ne 1}">
                        <div class="group_item">
                            <a href="../group/student?termId=${requestScope.termId}&year=${requestScope.year}&groupId=${g}&id=${requestScope.id}">
                                <span <c:if test="${g eq requestScope.groupId}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>
                                    >
                                    ${g} 
                                </span>
                            </a>    
                        </div>
                    </c:if>

                    <c:if test="${account.role eq 1}">
                        <div class="group_item">
                            <a href="">
                                <span <c:if test="${g eq requestScope.groupId}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>
                                    >
                                    ${g} 
                                </span>
                            </a>   
                        </div>
                    </c:if>

                </c:forEach>    
            </div>

        </div>

        <div class="course">
            <h4>COURSE</h4>
            <div>
                <c:if test="${account.role ne 1}">
                    <c:forEach items="${requestScope.subjectsId}" var="s">
                        <div class="course_item">
                            <a href="../group/student?termId=${requestScope.termId}&year=${requestScope.year}&groupId=${requestScope.groupId}&subjectId=${s}&id=${requestScope.id}">
                                <span <c:if test="${s eq requestScope.subjectId}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>
                                    >
                                    ${s} 
                                </span>
                            </a>
                        </div>
                    </c:forEach>    
                </c:if>

                <c:if test="${account.role eq 1}">
                    <c:forEach items="${requestScope.subjectsId}" var="s">
                        <div class="course_item">
                            <a href="">
                                <span <c:if test="${s eq requestScope.subjectId}">
                                        style="font-weight: bold; color: black;"
                                    </c:if>
                                    >
                                    ${s} 
                                </span>
                            </a>
                        </div>
                    </c:forEach>    
                </c:if>

            </div>

        </div>
    </div>

    <c:if test="${requestScope.subjectId ne null}">
        <h3>
            Student list...
        </h3>
        <div>
            <table>
                <thead>
                    <tr>
                        <th>
                            No
                        </th >
                        <th>
                            IMAGE
                        </th>
                        <th>
                            CODE
                        </th>
                        <th>
                            NAME
                        </th>
                        <c:if test="${account.role ne 1}">
                            <th>
                                GRADE
                            </th>    
                        </c:if>
                        <c:if test="${account.role ne 1}">
                            <th>
                                INFORMATION
                            </th>    
                        </c:if>

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
                            <td class="img">
                                <img src="../img/avatar.jpg">
                            </td>
                            <td>
                                ${s.id}
                            </td>
                            <td>
                                ${s.name}
                            </td>
                            <c:if test="${account.role ne 1}">
                                <c:if test="${requestScope.termId ne null}">
                                    <td>
                                        <a href="../student/grade?id=${s.id}&termId=${requestScope.termId}&year=${requestScope.year}&subjectId=${requestScope.subjectId}">
                                            View Grade    
                                        </a>
                                    </td>
                                </c:if>   
                            </c:if>

                            <c:if test="${account.role ne 1}">
                                <c:if test="${requestScope.termId ne null}">
                                    <td>
                                        <a href="../student/attendance?id=${s.id}&date=${now}">View Attendance</a>
                                    </td>
                                </c:if>   
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>    
        </div>    
    </c:if>
    <c:if test="${subjectId ne null}">
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
    </c:if>
</body>
</html>
