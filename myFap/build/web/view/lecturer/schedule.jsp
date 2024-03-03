<%-- 
    Document   : schedule
    Created on : Feb 14, 2024, 3:49:30 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Schedule Lecturer</title>
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
                | <strong>View Schedule</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <div class="note">
            <p>
                <b>Note</b>: These activities do not include extra-curriculum activities, such as
                club activities ...
            </p>
            <p>
                <b>Chú thích</b>: Các hoạt động trong bảng dưới không bao gồm hoạt động ngoại khóa,
                ví dụ như hoạt động câu lạc bộ ...
            </p>
            <p>
                Các phòng bắt đầu bằng AL thuộc tòa nhà Alpha. VD: AL...<br>
                Các phòng bắt đầu bằng BE thuộc tòa nhà Beta. VD: BE,..<br>
                Các phòng bắt đầu bằng G thuộc tòa nhà Gamma. VD: G201,...<br>
                Các phòng tập bằng đầu bằng R thuộc khu vực sân tập Vovinam.<br>
                Các phòng bắt đầu bằng DE thuộc tòa nhà Delta. VD: DE,..<br>
                Little UK (LUK) thuộc tầng 5 tòa nhà Delta
            </p>
        </div>
        <form action="../lecturer/schedule" id="form" onchange="document.getElementById('form').submit()">
            Lecturer: <input type="text" name="id" value="${requestScope.id}" <c:if test="${account.role ne 3}">readonly</c:if>>
            <c:if test="${account.role eq 3}">
                <input type="submit" value="Search">
            </c:if>
            <div class="error">
                ${error}
            </div>

            <div class="option">
                Option:
                <select name="option">
                    <option value="0"
                            <c:if test="${option eq 0}">
                                selected="selected"
                            </c:if>
                            >
                        View by week
                    </option>
                    <option value="1" 
                            <c:if test="${option eq 1}">
                                selected="selected"
                            </c:if>
                            >
                        View by date
                    </option>
                </select>
            </div>

            <c:if test="${requestScope.id ne null and error eq null}">
                <c:if test="${option eq 0}">
                    <div class="control">
                        <c:set var="countWeek" value="${requestScope.week}"/>
                        <button>
                            <a href=
                               <c:if test="${requestScope.week eq 1}">
                                   "../lecturer/schedule?id=${requestScope.id}&year=${requestScope.year-1}
                                   &week=52"
                               </c:if>

                               <c:if test="${requestScope.week ne 1}">
                                   "../lecturer/schedule?id=${requestScope.id}&year=${requestScope.year}
                                   &week=${requestScope.week - 1}"
                               </c:if>
                               ">

                                <c:if test="${requestScope.year > requestScope.minYear or requestScope.week > 1}">
                                    previous
                                </c:if>

                            </a>
                        </button>

                        <button>
                            <a href=
                               <c:if test="${requestScope.week eq 52}">
                                   "../lecturer/schedule?id=${requestScope.id}&year=${requestScope.year+1}
                                   &week=1"
                               </c:if>

                               <c:if test="${requestScope.week ne 52}">
                                   "../lecturer/schedule?id=${requestScope.id}&year=${requestScope.year}
                                   &week=${requestScope.week + 1}"
                               </c:if>
                               ">

                                <c:if test="${requestScope.week < 52 or requestScope.year < requestScope.maxYear}">
                                    next
                                </c:if>
                            </a>    
                        </button>
                    </div>
                </c:if>

                <c:if test="${option eq 0}">
                    <div class="table">
                        <table style="width: 100%">
                            <thead>
                                <tr>
                                    <th rowspan="2">
                                        <c:if test="${option eq 0}">
                                            <div class="year">
                                                YEAR <select name="year">
                                                    <c:forEach items="${requestScope.years}" var="y">
                                                        <option value="${y}"
                                                                <c:if test="${requestScope.year eq y}">selected="selected"</c:if>
                                                                    >
                                                                ${y}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>    
                                        </c:if>

                                        <c:if test="${option eq 0}">
                                            <div class="week">
                                                WEEK <select name="week" id="week">
                                                    <c:set var="count" value="1"/>
                                                    <c:forEach items="${requestScope.weeks}" var="w">
                                                        <option value="${count}"
                                                                <c:if test="${requestScope.week eq null and requestScope.currentDay >= w.fromDate and requestScope.currentDay <= w.toDate}">
                                                                    selected="selected"
                                                                </c:if>
                                                                <c:if test="${requestScope.week eq count}">
                                                                    selected="selected"
                                                                </c:if>
                                                                >
                                                            ${w.fromDate.day}/${w.fromDate.month}-${w.toDate.day}/${w.toDate.month}
                                                            <c:set var="count" value="${count + 1}"/>
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>    
                                        </c:if>
                                        <c:if test="${option eq 1}">
                                            <div class="week">
                                                <input type="date" name="fromDate" value="${fromDate}">-<input type="date" name="toDate" value="${toDate}">
                                            </div>
                                        </c:if>
                                    </th>

                                    <c:forEach items="${dates}" var="d">
                                        <th>
                                            ${d.weekday}
                                        </th>
                                    </c:forEach>
                                </tr>

                                <tr>
                                    <c:forEach items="${dates}" var="d">
                                        <th>
                                            ${d.day}/${d.month}
                                        </th>
                                    </c:forEach>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${requestScope.slots}" var="s">
                                    <tr>
                                        <td>
                                            Slot ${s.id} (from <span>${s.startTime}</span> to <span>${s.endTime}</span>)
                                        </td>

                                        <c:forEach items="${dates}" var="d">
                                            <td>
                                                <c:forEach items="${requestScope.schedules}" var="sche">
                                                    <c:if test="${sche.slotId eq s.id and sche.date.compare(d) eq 0}">
                                                        <p> 
                                                            <a href="../group/student?groupId=${sche.groupId}&subjectId=${sche.subjectId}&year=${requestScope.year}&termId=${requestScope.termId}">
                                                                ${sche.groupId}-${sche.subjectId}
                                                            </a> 
                                                        </p>
                                                        <p>at ${sche.roomId}</p>

                                                        <c:if test="${sche.status and sche.date eq requestScope.currentDay}">
                                                            <c:if test="${account.role ne 3}">
                                                                <a href="../group/attendance/edit?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                                                </c:if>

                                                                <c:if test="${account.role eq 3}">
                                                                    <a href="../group/attendance/view?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                                                    </c:if>
                                                                    <p style="color: green"> (Attended) </p>
                                                                </a>
                                                            </c:if>    

                                                            <c:if test="${sche.status and sche.date < requestScope.currentDay}">
                                                                <a href="../group/attendance/view?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">    
                                                                    <p style="color: green"> (Attended) </p>
                                                                </a>
                                                            </c:if>

                                                            <c:if test="${!sche.status and sche.date eq requestScope.currentDay}">
                                                                <c:if test="${account.role eq 2}">
                                                                    <a href="../group/attendance?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">    
                                                                    </c:if>

                                                                    <p style="color: red"> (Not yet) </p>
                                                                    <c:if test="${account.role eq 2}">
                                                                    </a>
                                                                </c:if>
                                                            </c:if>

                                                            <c:if test="${!sche.status and sche.date > requestScope.currentDay}">
                                                                <p style="color: red"> (Not yet) </p>
                                                                <c:if test="${account.role eq 3}">
                                                                    <a href="../lecturer/change?id=${id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}&roomId=${sche.roomId}">
                                                                        <p> (Change Lecturer) </p>
                                                                    </a>
                                                                </c:if>
                                                            </c:if>

                                                            <c:if test="${!sche.status and sche.date < requestScope.currentDay}">
                                                                <a href="../group/attendance/view?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">    
                                                                    <p style="color: red"> (Absent) </p>
                                                                </a>
                                                            </c:if>

                                                            <c:if test="${account.role eq 3 and sche.date <= requestScope.currentDay}">
                                                                <a href="../group/attendance/edit?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                                                    <p> (Edit Attendance) </p>
                                                                </a>
                                                            </c:if>

                                                        </c:if>

                                                    </c:forEach>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <c:if test="${option eq 1}">
                    <div class="table">
                        <div class="table_1">
                            <table style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>
                                            <div class="week">
                                                From: <input type="date" name="fromDate" value="${fromDate}">
                                            </div>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>
                                            <div class="week">
                                                To: <input type="date" name="toDate" value="${toDate}">
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.slots}" var="s">
                                        <tr>
                                            <td>
                                                <div class="slot${s.id}">
                                                    Slot ${s.id} (from <span>${s.startTime}</span> to <span>${s.endTime}</span>)
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="table_2">
                            <table>
                                <thead>
                                    <tr>
                                        <c:forEach items="${dates}" var="d">
                                            <th>
                                                ${d.day}/${d.month}
                                            </th>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <c:forEach items="${dates}" var="d">
                                            <th>
                                                ${d.weekday}
                                            </th>
                                        </c:forEach>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach items="${requestScope.slots}" var="s">
                                        <tr>
                                            <c:forEach items="${dates}" var="d">
                                                <td>
                                                    <div class="slot${s.id}">
                                                        <c:forEach items="${requestScope.schedules}" var="sche">
                                                            <c:if test="${sche.slotId eq s.id and sche.date.compare(d) eq 0}">
                                                                <p> 
                                                                    <a href="../group/student?groupId=${sche.groupId}&subjectId=${sche.subjectId}&year=${requestScope.year}&termId=${requestScope.termId}">
                                                                        ${sche.groupId}-${sche.subjectId}
                                                                    </a> 
                                                                </p>
                                                                <p>at ${sche.roomId}</p>

                                                                <c:if test="${sche.status and sche.date eq requestScope.currentDay}">
                                                                    <c:if test="${account.role ne 3}">
                                                                        <a href="../group/attendance/edit?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                                                        </c:if>

                                                                        <c:if test="${account.role eq 3}">
                                                                            <a href="../group/attendance/view?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                                                            </c:if>
                                                                            <p style="color: green"> (Attended) </p>
                                                                        </a>
                                                                    </c:if>    

                                                                    <c:if test="${sche.status and sche.date < requestScope.currentDay}">
                                                                        <a href="../group/attendance/view?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">    
                                                                            <p style="color: green"> (Attended) </p>
                                                                        </a>
                                                                    </c:if>

                                                                    <c:if test="${!sche.status and sche.date eq requestScope.currentDay}">
                                                                        <c:if test="${account.role eq 2}">
                                                                            <a href="../group/attendance?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">    
                                                                            </c:if>

                                                                            <p style="color: red"> (Not yet) </p>
                                                                            <c:if test="${account.role eq 2}">
                                                                            </a>
                                                                        </c:if>
                                                                    </c:if>

                                                                    <c:if test="${!sche.status and sche.date > requestScope.currentDay}">
                                                                        <p style="color: red"> (Not yet) </p>
                                                                        <c:if test="${account.role eq 3}">
                                                                            <a href="../lecturer/change?id=${id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}&roomId=${sche.roomId}">
                                                                                <p> (Change Lecturer) </p>
                                                                            </a>
                                                                        </c:if>
                                                                    </c:if>

                                                                    <c:if test="${!sche.status and sche.date < requestScope.currentDay}">
                                                                        <a href="../group/attendance/view?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">    
                                                                            <p style="color: red"> (Absent) </p>
                                                                        </a>
                                                                    </c:if>

                                                                    <c:if test="${account.role eq 3 and sche.date <= requestScope.currentDay}">
                                                                        <a href="../group/attendance/edit?id=${requestScope.id}&groupId=${sche.groupId}&subjectId=${sche.subjectId}&date=${sche.date}&slotId=${sche.slotId}">
                                                                            <p> (Edit Attendance) </p>
                                                                        </a>
                                                                    </c:if>

                                                                </c:if>

                                                            </c:forEach>
                                                    </div>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </c:if>    
        </form>
            
        <c:if test="${error eq null}">
            <div class="note">
                <b>More note / Chú thích thêm</b>
                <ul>
                    <li>(<font color="green">attended</font>): Class has taken place / lớp học đã được diễn ra</li>
                    <li>(<font color="red">absent</font>): Class has been skipped / Lóp học đã bị bỏ qua</li> 
                    <li>(-): no data was given / chưa có dữ liệu</li> 
                </ul>
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
