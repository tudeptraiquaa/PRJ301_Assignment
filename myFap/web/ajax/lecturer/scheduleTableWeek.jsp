<%-- 
    Document   : scheduleTable
    Created on : Mar 4, 2024, 8:12:34 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="control">
    <c:set var="countWeek" value="${requestScope.week}"/>
    <button 
        <c:if test="${requestScope.week eq 1}">
            onclick="loadDataTableWeek('${option}', '${id}', '${year-1}', '52', '${fromDate}', '${toDate}')"
        </c:if>

        <c:if test="${requestScope.week ne 1}">
            onclick="loadDataTableWeek('${option}', '${id}', '${year}', '${week-1}', '${fromDate}', '${toDate}')"
        </c:if>>



        <c:if test="${requestScope.year > requestScope.minYear or requestScope.week > 1}">
            previous
        </c:if>

    </button>

    <button 
        <c:if test="${requestScope.week eq 52}">
            onclick="loadDataTableWeek('${option}', '${id}', '${year+1}', '1', '${fromDate}', '${toDate}')"
        </c:if>

        <c:if test="${requestScope.week ne 52}">
            onclick="loadDataTableWeek('${option}', '${id}', '${year}', '${week+1}', '${fromDate}', '${toDate}')"
        </c:if>
        >
        <c:if test="${requestScope.week < 52 or requestScope.year < requestScope.maxYear}">
            next
        </c:if>
    </button>
</div>
<div class="table">
    <table style="width: 100%">
        <thead>
            <tr>
                <th rowspan="2">
                    <div class="year">
                        YEAR <select name="year" onchange="loadDataTableWeek('${option}', '${id}', this.value, '${week}', '${fromDate}', '${toDate}')">
                            <c:forEach items="${requestScope.years}" var="y">
                                <option value="${y}"
                                        <c:if test="${requestScope.year eq y}">selected="selected"</c:if>
                                            >
                                        ${y}
                                </option>
                            </c:forEach>
                        </select>
                    </div>    



                    <div class="week">
                        WEEK <select name="week" id="week" onchange="loadDataTableWeek('${option}', '${id}', '${year}', this.value, '${fromDate}', '${toDate}')">
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
