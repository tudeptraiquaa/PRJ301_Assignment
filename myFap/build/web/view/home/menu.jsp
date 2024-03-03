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
    </body>
</html>
