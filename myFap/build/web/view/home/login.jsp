<%-- 
    Document   : login
    Created on : Feb 11, 2024, 1:26:14 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
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
        
        <div class="form_login">
            <div><h3>Người dùng đăng nhập</h3></div>
            <div class="form_input">
                
                <form action="../home/login" id="login" method="post">
                    <div class="input">
                        <label for="user">User</label>
                        <input type="text" name="user" id="user" placeholder="Tên đăng nhập"></br>     
                    </div>

                    <div class="input">
                        <label for="password">Password</label>
                        <input type="password" name="password" id="password" placeholder="Mật khẩu"></br>
                    </div>

                    <input type="submit" value="Đăng nhập" id="button">
                </form>
            </div>
            <div style="color: red; margin: 10px">
                ${requestScope.error}
            </div>    
        </div>
        <div class="footer">
            <p style="text-align: center">
                © Powered by <a href="http://fpt.edu.vn" target="_blank">FPT University</a>&nbsp;|&nbsp;
                <a href="http://cms.fpt.edu.vn/" target="_blank">CMS</a>&nbsp;|&nbsp; <a href="http://library.fpt.edu.vn" target="_blank">library</a>&nbsp;|&nbsp; <a href="http://library.books24x7.com" target="_blank">books24x7</a>
                <span id="ctl00_lblHelpdesk"></span>
            </p>
        </div>


        <script>
            function check() {
                var user = document.getElementById("user").value;
                var pass = document.getElementById("password").value;
                if (user.trim() == '' || pass.trim() == '') {
                    alert("Vui lòng nhập đầy đủ tài khoản mật khẩu!");
                } else {
                    document.getElementById("login").submit();
                }
            }
        </script>
    </body>
</html>
