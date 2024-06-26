<%-- 
    Document   : addSchedule
    Created on : Mar 18, 2024, 7:37:01 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Schedule</title>
        <link rel="stylesheet" href="../css/style.css">
        <style>
            form{
                width: 100%;
            }
        </style>
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
                | <strong>Add Schedule</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <form action="../group/addSchedule" method="post" onchange="document.getElementById('add').submit()" id="add">
            <table>
                <tr>
                    <td>
                        GroupId: </br>
                        <select name="groupId">
                            <c:forEach items="${groupsId}" var="g">
                                <option value="${g}" ${g eq groupId?'selected':''}>
                                    ${g}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        SubjectId:</br>
                        <select name="subjectId">
                            <c:forEach items="${subjectsId}" var="s">
                                <option value="${s}" ${s eq subjectId?'selected':''}>
                                    ${s}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        Year:</br>
                        <select name="year">
                            <option value="${now.year}" ${now.year eq year?'selected':''}>
                                ${now.year}
                            </option>
                            <option value="${now.year+1}" ${now.year+1 eq year?'selected':''}>
                                ${now.year+1}
                            </option>
                        </select>
                    </td>
                    <td>
                        Term</br>
                        <select name="termId">
                            <c:forEach items="${termsId}" var="t">
                                <option value="${t}" ${t eq termId? 'selected':''}>
                                    ${t}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        Weekday</br>
                        <select name="weekday">
                            <c:forEach items="${weekdays}" var="w">
                                <option value="${w}" ${w eq weekday ? 'selected':''}>
                                    ${w}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        Slot</br>
                        <select name="slotId">
                            <c:forEach items="${slotsId}" var="s">
                                <option value="${s}" ${s eq slotId ? 'selected':''}>
                                    ${s}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </table>
                            
        </form>
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
