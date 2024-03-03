<%-- 
    Document   : viewRequireChange
    Created on : Mar 2, 2024, 9:47:17 AM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Require Change Group</title>
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
                | <strong>View Require</strong>    
            </div>    

            <div class="logout"><a href="../../home/login">logout</a></span></div>
        </div>
        <div style="font-size: 24px; margin-bottom: 20px">
            Student ${id}
        </div>
        <div style="background-color: #5CB85C; color: white; border-radius: 10px; display: inline-block; padding:  10px; margin-bottom: 10px">
            <a href="../../group/change?id=${id}&month=${month}&year=${year}" style="color: white">Tạo yêu cầu</a>
        </div>
        ${request}
        <c:if test="${request eq null}">

            <table>
                <thead>
                    <tr>
                        <th>
                            <div class="no">
                                No    
                            </div>
                        </th>
                        <th>
                            SubjectId
                        </th>
                        <th>
                            From Group
                        </th>
                        <th>
                            To Student Id
                        </th>
                        <th>
                            To Group
                        </th>
                        <th>
                            Date Request
                        </th>
                        <th>
                            Status
                        </th>
                    </tr>
                </thead>

                <tbody>
                    <c:set var="no" value="1"></c:set>
                    <c:forEach items="${requires}" var="r">
                        <tr>
                            <td>
                                <div class="no">
                                    ${no}
                                </div>
                                <c:set var="no" value="${no + 1}">
                                </c:set>            
                            </td>
                            <td>
                                ${r.subjectId}
                            </td>
                            <td>
                                ${r.groupIdFrom}
                            </td>
                            <td>
                                ${r.idTo}
                            </td>
                            <td>
                                ${r.groupIdTo}
                            </td>
                            <td>
                                ${r.dateRequire}
                            </td>
                            <td>
                                <c:if test="${r.status eq -1}">
                                    Processing...
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
