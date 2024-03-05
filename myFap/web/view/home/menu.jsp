<%-- 
    Document   : menu
    Created on : Feb 11, 2024, 1:50:59 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
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

        <c:if test="${account.role eq 1}">
            <div class="setting">
                <div>

                </div>

                <div class="setting_logout">
                    <a href="../student/information?id=${account.user}">Infomation</a>
                    | 
                    <span class="logout">
                        <a href="../home/login">logout</a>
                    </span>
                </div>
            </div>

            <div class="body">
                <h2>Academic Information</h2>
                <div class="body_items">
                    <div class="regis">
                        <h3>
                            Registration/Application(Thủ tục/đơn từ)
                        </h3>
                        <div>
                            <ul>
                                <li>
                                    <a href="../group/change/viewRequire?id=${account.user}&year=${now.year}&month=${now.month}">Yêu cầu đổi chéo lớp với sinh viên</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="infor">
                        <h3>
                            Information Access(Tra cứu thông tin)
                        </h3>
                        <div>
                            <ul>
                                <li>
                                    <a href="../student/schedule?id=${account.user}&year=${requestScope.currentYear}&week=${week}">Weekly Timetable</a>
                                    <span>(Thời khóa biểu từng tuần)</span>
                                </li>
                            </ul>

                        </div>
                    </div>
                    <div class="report">
                        <h3>Reports(Báo cáo)</h3>
                        <div>
                            <ul>
                                <li>
                                    <a href="../student/attendance?id=${account.user}&date=${requestScope.now}">Attendance Report</a>
                                    <span>(Báo cáo điểm danh)</span>
                                </li>
                                <li>
                                    <a href="../student/grade?id=${account.user}">Mark Report</a>
                                    <span>(Báo cáo điểm)</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </c:if>

        <c:if test="${account.role eq 2}">
            <div class="setting">
                <div>

                </div>

                <div class="setting_logout">
                    <a href="../lecturer/information?id=${account.user}">Infomation</a>
                    | 
                    <span class="logout">
                        <a href="../home/login" class="label label-success">logout</a>
                    </span>
                </div>
            </div>
            <div class="body">
                <h2>Academic Information</h2>
                <div class="body_items">
                    <div class="infor">
                        <h3>
                            Timetable
                        </h3>
                        <div>
                            <ul>
                                <li>
                                    <a href="../lecturer/schedule?id=${account.user}&year=${requestScope.currentYear}&week=${week}">Weekly Schedule</a>
                                    <span>(Thời khóa biểu từng tuần)</span>
                                </li>
                                <li>
                                    <a href="../lecturer/takenGroup?id=${account.user}&year=${requestScope.currentYear}&week=${week}&date=${now}">Taken</a>
                                    <span>(Điểm danh)</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="report">
                        <h3>Students</h3>
                        <div>
                            <ul>
                                <li>
                                    <a href="../group/student?year=${requestScope.currentYear}&termId=${termId}">Group Student</a>
                                    <span>(Danh sách sinh viên của từng lớp)</span>
                                </li>
                                <li>
                                    <a>
                                        Search Student
                                    </a>
                                    <form action="../student/information">
                                        Student id: <input type="text" name="id">
                                        <input type="submit" value="Search">
                                    </form>
                                    <div style="color: red">
                                        ${error}
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>    
        </c:if>

        <c:if test="${account.role eq 3}">
            <div class="setting">
                <div>

                </div>
                <div class="logout">
                    <a href="../home/login" class="label label-success">logout</a>
                </div>

            </div>
            <div class="body">
                <h2>Academic Information</h2>
                <div class="body_items">
                    <div class="lecturer">
                        <h3>
                            Information Lecturer(Thông tin giảng viên)
                        </h3>
                        <div>
                            <ul>
                                <li>
                                    <a href="../lecturer/information">Infomation</a>
                                    <span>(Thông tin)</span>
                                </li>
                                <li>
                                    <a href="../lecturer/schedule?year=${requestScope.currentYear}&week=${week}">Weekly timetable</a>
                                    <span>(Thời khóa biểu từng tuần)</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="student">
                        <h3>Inormation Student(Thông tin sinh viên)</h3>
                        <ul>
                            <li>
                                <a href="../student/information">Infomation</a>
                                <span>(Thông tin)</span>
                            </li>
                            <li>
                                <a href="../student/schedule?year=${requestScope.currentYear}&week=${week}">Weekly timetable</a>
                                <span>(Thời khóa biểu từng tuần)</span>
                            </li>
                            <li>
                                <a href="../group/change/viewRequire?year=${currentYear}&month=${month}">
                                    Requires change group
                                </a>
                                <span>(Yêu cầu đổi chéo lớp với sinh viên)</span>
                            </li>
                        </ul>
                    </div>
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
