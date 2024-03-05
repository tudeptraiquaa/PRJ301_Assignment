<%-- 
    Document   : grade
    Created on : Feb 12, 2024, 11:40:28 AM
    Author     : tu
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grade Student</title>
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
                | <strong>View Grade</strong>    
            </div>    

            <div class="logout"><a href="../home/login">logout</a></span></div>
        </div>
        <h3>Grade student ${id}</h3>
        <div style="display: flex">
            <div class="term" style="width: 13%">
                <h4>TERM</h4>
                <c:forEach items="${requestScope.terms}" var="t">
                    <div class="term_item">
                        <a href="../student/grade?id=${requestScope.id}&termId=${t.id}&year=${t.year}">
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
                        <a href="../student/grade?id=${requestScope.id}&termId=${requestScope.termId}
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

            <c:if test="${scores ne null}">
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
                    <div>
                        <c:forEach items="${requestScope.grades}" var="g">
                            <div style="display: flex">
                                <div class="grade_category">
                                    ${g.assessment.name}
                                </div>
                                <div>
                                    <c:forEach items="${requestScope.scores}" var="s">
                                        <c:if test="${s.assessment.id eq g.assessment.id}">
                                            <div style="display: flex">
                                                <div class="grade_item">
                                                    ${s.assessment.name}
                                                </div>
                                                <div class="grade_weight">
                                                    <fmt:formatNumber value="${s.weight*100}" pattern="#.#" />%
                                                </div>
                                                <div class="grade_value">
                                                    <c:if test="${s.value ne null}">
                                                        ${s.value}    
                                                    </c:if>
                                                </div>    
                                            </div>
                                        </c:if>

                                    </c:forEach>

                                    <div style="display:flex; background-color: #f5f5f5" class="total">
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
                                        <c:if test="${check}">
                                            <div class="grade_value">
                                                <fmt:formatNumber value="${totalValue/totalWeight}" pattern="#.#"/>        
                                            </div>
                                        </c:if>

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
                    </div>


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



                                    <c:if test="${requestScope.dateEnd.compare(now) < 0}">
                                        <div class="grade_weight">
                                            <c:if test="${totalFinalResit eq null}">
                                                <c:if test="${sum >= 5 and totalFinal/totalWeight >= 4}">
                                                    <b style="color: green">PASSED</b>
                                                </c:if>    
                                                <c:if test="${sum < 5 or totalFinal/totalWeight < 4}">
                                                    <b style="color: red">NOT PASSED</b>
                                                </c:if> 
                                            </c:if>

                                            <c:if test="${totalFinalResit ne null}">
                                                <c:if test="${sum >= 5 and totalFinalResit/totalWeight >= 4}">
                                                    <b style="color: green">PASSED</b>
                                                </c:if>    
                                                <c:if test="${sum < 5 or totalFinalResit/totalWeight < 4}">
                                                    <b style="color: red">NOT PASSED</b>
                                                </c:if> 
                                            </c:if>       
                                        </div>
                                    </c:if> 

                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${requestScope.subjectId ne null and account.role eq 3}">
                        <form action="../student/grade/edit">
                            <input type="hidden" name="id" value="${requestScope.id}">
                            <input type="hidden" name="termId" value="${requestScope.termId}">
                            <input type="hidden" name="year" value="${requestScope.year}">
                            <input type="hidden" name="subjectId" value="${requestScope.subjectId}">
                            <input type="submit" value="Edit">
                        </form>
                    </c:if>
                </div>
            </c:if>
        </div>
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
