<%-- 
    Document   : information
    Created on : Feb 29, 2024, 9:01:56 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Information</title>
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
                | <strong>Student Detail</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <c:if test="${account.role eq 3}">
            <form action="../student/information">
                Student id: <input type="text" name="id" value="${student.id}">
                <input type="submit" value="Search">
            </form>
        </c:if>
        <div style="color: red; margin: 10px 0 10px 0;">
            ${error}
        </div>
        <c:if test="${student.id ne null}">
            <div style="margin-top: 20px">
                <a href="../student/attendance?id=${student.id}&date=${now}">View Attendance</a> |
                <a href="../student/grade?id=${student.id}">View Grade</a> |
                <a href="../student/schedule?id=${student.id}">View Schedule</a>
            </div>
            <div style="display: flex; justify-content: space-evenly">
                <div class="left">
                    <h2>
                        Student Information
                    </h2>
                    <div class="avatar">
                        <img src="../img/${requestScope.student.id}.jpg" class="avatar"></br>
                    </div>
                </div>
                <div class="right">
                    <h2>Profile</h2>
                    <table>
                        <tbody>
                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    Roll number
                                </td>
                                <td>
                                    ${student.id}
                                </td>
                            </tr>
                            <tr>
                                <td style="width:30%; text-align: right;">Full name&nbsp;</td>
                                <td>
                                    ${student.name}</td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Date of birth&nbsp;</td>
                                <td>
                                    ${student.dob}
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Gender&nbsp;</td>
                                <td>
                                    <c:if test="${requestScope.student.gender == true}">Male</c:if>
                                    <c:if test="${requestScope.student.gender == false}">Female</c:if></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">ID Card&nbsp;</td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Address&nbsp;</td>
                                    <td>
                                    ${student.address}
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Phone number&nbsp;</td>

                            </tr>
                            <tr>
                                <td style="text-align: right">Email&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Date of issue&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Place of issue&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    Major
                                </td>
                                <td>
                                    ${student.major.name}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
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
