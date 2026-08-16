<%@ page session="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Student Management System</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    min-height: 100vh;
    background: linear-gradient(135deg, #222831, #3498db);
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

.shape {
    position: absolute;
    border-radius: 50%;
    background: rgba(255,255,255,0.08);
}

.shape-one {
    width: 300px;
    height: 300px;
    top: -100px;
    left: -80px;
}

.shape-two {
    width: 400px;
    height: 400px;
    bottom: -180px;
    right: -100px;
}

.login-container {
    width: 900px;
    min-height: 520px;
    display: flex;
    background: white;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 20px 50px rgba(0,0,0,0.25);
    position: relative;
    z-index: 2;
    animation: appear 0.7s ease;
}

.login-info {
    width: 48%;
    background: #222831;
    color: white;
    padding: 55px 45px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.login-info h1 {
    font-size: 34px;
    margin-bottom: 18px;
}

.login-info h1 span {
    color: #3498db;
}

.login-info p {
    color: #cfd3d8;
    line-height: 1.7;
    font-size: 15px;
}

.info-line {
    width: 60px;
    height: 4px;
    background: #3498db;
    margin: 22px 0;
    border-radius: 5px;
}

.features {
    margin-top: 25px;
}

.features p {
    margin: 12px 0;
    color: #e5e7eb;
}

.login-box {
    width: 52%;
    padding: 55px 60px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.login-box h2 {
    color: #222831;
    font-size: 30px;
    margin-bottom: 8px;
}

.subtitle {
    color: #777;
    font-size: 14px;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    color: #333;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 8px;
}

.input-box {
    position: relative;
}

.input-box input {
    width: 100%;
    padding: 13px 15px;
    border: 1px solid #d5d8dc;
    border-radius: 7px;
    outline: none;
    font-size: 14px;
    transition: 0.3s;
}

.input-box input:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52,152,219,0.12);
}

.password-toggle {
    position: absolute;
    right: 12px;
    top: 12px;
    cursor: pointer;
    color: #777;
    font-size: 13px;
}

.login-btn {
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 7px;
    background: #3498db;
    color: white;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

.login-btn:hover {
    background: #2980b9;
    transform: translateY(-2px);
    box-shadow: 0 5px 12px rgba(52,152,219,0.3);
}

.error-message {
    background: #fdecea;
    color: #c0392b;
    padding: 10px 12px;
    border-radius: 6px;
    margin-bottom: 18px;
    font-size: 13px;
    border-left: 4px solid #c0392b;
}

.login-footer {
    text-align: center;
    color: #999;
    font-size: 12px;
    margin-top: 25px;
}

@keyframes appear {
    from {
        opacity: 0;
        transform: translateY(25px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@media (max-width: 750px) {

    .login-container {
        width: 90%;
    }

    .login-info {
        display: none;
    }

    .login-box {
        width: 100%;
        padding: 45px 35px;
    }
}

</style>
</head>

<body>

<div class="shape shape-one"></div>
<div class="shape shape-two"></div>

<div class="login-container">

    <div class="login-info">

        <h1>Student <span>Management</span> System</h1>

        <div class="info-line"></div>

        <p>
            Manage students, courses, marks and grades
            efficiently from one centralized system.
        </p>

        <div class="features">
            <p>Student Management</p>
            <p>Course Management</p>
            <p>Marks & Grade Management</p>
            <p>Secure Admin Access</p>
        </div>

    </div>

    <div class="login-box">

        <h2>Admin Login</h2>

        <p class="subtitle">
            Sign in to access your dashboard
        </p>

        <%
    String error = request.getParameter("error");

    if ("invalid".equals(error)) {
%>

<div class="error-message">
    Invalid username or password.
</div>

<%
    } else if ("database".equals(error)) {
%>

<div class="error-message">
    Unable to connect to database. Please try again.
</div>

<%
    }
%>
        <form action="${pageContext.request.contextPath}/LoginServlet"
              method="post"
              onsubmit="return validateLogin();">

            <div class="form-group">

                <label for="username">Username</label>

                <div class="input-box">

                    <input type="text"
                           id="username"
                           name="username"
                           placeholder="Enter username">

                </div>

            </div>

            <div class="form-group">

                <label for="password">Password</label>

                <div class="input-box">

                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter password">

                    <span class="password-toggle"
                          onclick="togglePassword()">
                        Show
                    </span>

                </div>

            </div>

            <button type="submit" class="login-btn">
                Login
            </button>

        </form>

        <div class="login-footer">
            Student Management System | Admin Panel
        </div>
        
    </div>
</div>

<script>

function togglePassword() {

    const password = document.getElementById("password");
    const toggle = document.querySelector(".password-toggle");

    if (password.type === "password") {
        password.type = "text";
        toggle.innerText = "Hide";
    } else {
        password.type = "password";
        toggle.innerText = "Show";
    }
}

function validateLogin() {

    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    if (username === "") {
        alert("Please enter your username.");
        document.getElementById("username").focus();
        return false;
    }
    if (password === "") {
        alert("Please enter your password.");
        document.getElementById("password").focus();
        return false;
    }
    return true;
}

</script>

</body>
</html>
