<%-- 
    Document   : editGrade
    Created on : Feb 24, 2024, 1:04:45 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Grade</title>
        <link rel="stylesheet" href="../../css/style.css">
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
                <form action="../../home/login" method="post">
                    <input type="hidden" name="user" value="${account.user}">
                    <input type="hidden" name="password" value="${account.password}">
                    <input type="submit" value="Home">
                </form>
                | <strong>View Grade</strong>    
            </div>    

            <div class="logout"><a href="../../home/login">logout</a></span></div>
        </div>

        <div style="display: flex">
            <div class="term" style="width: 13%">
                <h4>TERM</h4>
                <c:forEach items="${requestScope.terms}" var="t">
                    <div class="term_item">
                        <a href="../../student/grade?id=${requestScope.id}&termId=${t.id}&year=${t.year}">
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

            <div class="course" style="width: 47%">
                <h4>COURSE</h4>
                <c:forEach items="${requestScope.subjects}" var="s">
                    <div class="course_item">
                        <a href="../../student/grade?id=${requestScope.id}&termId=${requestScope.termId}
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

            <form action="../../student/grade/edit" method="post">
                <input type="hidden" name="termId" value="${requestScope.termId}">
                <input type="hidden" name="year" value="${requestScope.year}">
                <input type="hidden" name="subjectId" value="${requestScope.subjectId}">
                <input type="hidden" name="id" value="${requestScope.id}">
                <div class="score">
                    <div style="display: flex">
                        <div class="grade_category">
                            <h4>GRADE CATEGORY</h4>
                        </div>
                        <div class="grade_item">
                            <h4>GRADE ITEM</h4>
                        </div>
                        <div class="grade_weight">
                            <h4>GRADE WEIGHT</h4>
                        </div>
                        <div class="grade_value">
                            <h4>GRADE VALUE</h4>
                        </div>
                    </div>
                    <c:forEach items="${requestScope.grades}" var="g">
                        <c:if test="${g.assessment.id ne 'FE' and g.assessment.id ne 'FER'}">
                            <input type="hidden" name="assessmentId" value="${g.assessment.id}">
                        </c:if>
                        <div style="display: flex">
                            <div class="grade_category">
                                ${g.assessment.name}
                            </div>
                            <div>
                                <c:forEach items="${requestScope.scores}" var="s">
                                    <c:if test="${s.assessment.id eq g.assessment.id}">
                                        <c:if test="${g.assessment.id eq 'FE' or g.assessment.id eq 'FER'}">
                                            <input type="hidden" name="assessmentId" value="${s.assessment.name}">
                                        </c:if>
                                        <div style="display: flex">
                                            <div class="grade_item">
                                                ${s.assessment.name}
                                            </div>
                                            <div class="grade_weight">
                                                <fmt:formatNumber value="${s.weight*100}" pattern="#.#" />%
                                            </div>
                                            <div class="grade_value">
                                                <input type="text" name=
                                                       <c:if test="${g.assessment.id eq 'FE' or g.assessment.id eq 'FER'}">
                                                           "${s.assessment.name}Score"
                                                       </c:if>
                                                       <c:if test="${g.assessment.id ne 'FE' and g.assessment.id ne 'FER'}">
                                                           "${s.assessment.id}Score"
                                                       </c:if>
                                                       value="${s.value}">
                                            </div>    
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <div style="display:flex">
                                    <div class="grade_item">
                                        Total
                                    </div>
                                    <div class="grade_weight">
                                        <c:set var="totalWeight" value="0"/>
                                        <c:forEach items="${requestScope.scores}" var="s">
                                            <c:if test="${s.assessment.id eq g.assessment.id}">
                                                <c:set var="totalWeight" value="${totalWeight + s.weight}"/>
                                            </c:if>

                                        </c:forEach>
                                        <div class="grade_value">
                                            <fmt:formatNumber value="${totalWeight*100}" pattern="#.#" />%    
                                        </div>
                                    </div>

                                    <c:set var="check" value="true"/>
                                    <c:set var="totalValue" value="0"/>
                                    <c:forEach items="${requestScope.scores}" var="s">
                                        <c:if test="${s.assessment.id eq g.assessment.id}">
                                            <c:if test="${s.value eq null}">
                                                <c:set var="check" value= "false"/>
                                            </c:if>
                                            <c:if test="${check}">
                                                <c:set var="totalValue" value="${totalValue + s.value*s.weight}"/>    
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${g.assessment.id eq 'FE' and check}">
                                        <c:set var="totalFinal" value="${totalValue}"></c:set>
                                        <c:set var="totalFinalWeight" value="${totalWeight}"/>
                                    </c:if>
                                    <c:if test="${g.assessment.id eq 'FER' and check}">
                                        <c:set var="totalFinalResit" value="${totalValue}"></c:set>
                                    </c:if>
                                </div>
                            </div>
                        </div>    
                    </c:forEach>

                    <c:if test="${requestScope.subjectId ne null}">
                        <div style="display: flex">
                            <div class="grade_category">
                                <b>COURSE TOTAL</b>
                            </div>
                            <div>
                                <div style="display: flex">
                                    <div class="grade_item"><b>AVERAGE</b></div>
                                    <c:if test="${requestScope.dateEnd.compare(now) < 0}">
                                        <div class="grade_weight">
                                            <c:set var="sum" value="0"/>
                                            <c:forEach items="${requestScope.scores}" var="s">
                                                <c:set var="sum" value="${sum + s.value*s.weight}"/>
                                            </c:forEach>
                                            <c:if test="${totalFinalResit ne null}">
                                                <c:set var="sum" value="${sum - totalFinal}"/>
                                            </c:if>
                                            <c:if test="${totalFinal ne null}">
                                                <b><fmt:formatNumber value="${sum}" pattern="#.#"/></b>
                                            </c:if>
                                        </div>    
                                    </c:if>

                                </div>
                                <div style="display: flex">
                                    <div class="grade_item"><b>STATUS</b></div>
                                    <c:if test="${requestScope.dateEnd.compare(now) >= 0}">
                                        <div class="grade_weight">
                                            <b style="color: green">STUDYING</b>
                                        </div>
                                    </c:if>

                                    <c:if test="${!(requestScope.dateBegin.compare(now) <= 0 and requestScope.dateEnd.compare(now) >= 0)}">
                                        <div class="grade_weight">
                                            <c:if test="${finalTotalResit eq null}">
                                                <c:if test="${sum >= 5 and finalTotal >= 4}">
                                                    <b style="color: green">PASSED</b>
                                                </c:if>    
                                                <c:if test="${sum < 5 or finalTotal < 4}">
                                                    <b style="color: red">NOT PASSED</b>
                                                </c:if> 
                                            </c:if>

                                            <c:if test="${finalTotalResit ne null}">
                                                <c:if test="${sum >= 5 and finalTotalResit >= 4}">
                                                    <b style="color: green">PASSED</b>
                                                </c:if>    
                                                <c:if test="${sum < 5 or finalTotalResit < 4}">
                                                    <b style="color: red">NOT PASSED</b>
                                                </c:if> 
                                            </c:if>
                                        </div>
                                    </c:if>    
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
                <input type="submit" value="Save">
            </form>

        </div>
    </body>
</html>
