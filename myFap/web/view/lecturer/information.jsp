<%-- 
    Document   : information
    Created on : Feb 14, 2024, 3:49:17 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Information Lecturer</title>
        <style>
            .error{
                color: red;
            }
            .header{
                display: flex;
                justify-content: space-evenly;
            }
            a{
                display: inline-block;
                text-decoration: none;
                color: #337ab7;
            }
            a:hover{
                color: black;
                text-decoration: black;
            }
            p{
                margin: 0;
            }
            th{
                background-color: #6b90da;
            }
            .setting{
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
                margin-bottom: 20px;
                background-color: #F5F5F5;
                padding: 10px;
                border-radius: 10px;
            }
            .logout {
                width: 100px;
                display: flex;
                justify-content: center;
                background-color: #5CB85C;
                border-radius: 5px;
                margin:0px 5px 0px 5px;
            }
            .setting a {
                align-content: center;
                color: white;
                font-weight: bold;
            }
            form{
                border: 0px;
                display: inline-block;
            }
            .left, .right{
                width: 30%;
            }
            img{
                width: 70%;
            }
            td{
                border-bottom: 1px solid #F5F5F5;
                border-right: 1px solid #F5F5F5;
                width: 200px;
                height:15px;
                padding: 5px;
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
                | <strong>Lecturer Detail</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <c:if test="${account.role eq 3}">
            <form action="../lecturer/information">
                Lecturer id: <input type="text" name="id" value="${lecturer.id}">
                <input type="submit" value="Search">
            </form>
        </c:if>
        <div style="color: red; margin: 10px 0 10px 0;">
            ${error}
        </div>
        <c:if test="${lecturer.id ne null}">
            <c:if test="${account.role ne 1}">
                <div style="margin-top: 20px">
                    <a href="../lecturer/schedule?id=${lecturer.id}&year=${year}&week=${week}">Weekly Schedule</a>
                </div>    
            </c:if>

            <div style="display: flex; justify-content: space-evenly">
                <div class="left">
                    <h2>
                        Student Information
                    </h2>
                    <div class="avatar">
                        <img src="../img/avatar.jpg" class="avatar"></br>
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
                                    ${lecturer.id}
                                </td>
                            </tr>
                            <tr>
                                <td style="width:30%; text-align: right;">Full name&nbsp;</td>
                                <td>
                                    ${lecturer.name}</td>
                            </tr>

                            <tr>
                                <td style="text-align: right">Address</td>
                                <td>
                                    ${student.address}
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Phone number</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    Qualification
                                </td>
                                <td>
                                    ${lecturer.qualification}
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    Email
                                </td>
                                <td>
                                    ${lecturer.id}@fe.edu.vn
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
