<%-- 
    Document   : scheduleTableDate
    Created on : Mar 4, 2024, 3:41:57 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="table">
    <div class="table_1">
        <table style="width: 100%">
            <thead>
                <tr>
                    <th>
                        <div class="week">
                            From: <input type="date" name="fromDate" value="${fromDate}" onchange="loadDataTableDate('${option}', '${id}', '${year}', '${week}', this.value, '${toDate}')">
                        </div>
                    </th>
                </tr>
                <tr>
                    <th>
                        <div class="week">
                            To: <input type="date" name="toDate" value="${toDate}" onchange="loadDataTableDate('${option}', '${id}', '${year}', '${week}', '${fromDate}', this.value)">
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
