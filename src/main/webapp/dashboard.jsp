<%@ page session="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String user = (String) session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - SMS</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4f6f8;
    min-height: 100vh;
    color: #222831;
}

/* Main */
.main {
    margin-left: 240px;
    padding: 30px;
    min-height: 100vh;
}

/* Top Bar */
.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.page-title {
    font-size: 14px;
    color: #777;
}

.clock {
    background: white;
    padding: 10px 16px;
    border-radius: 7px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    color: #555;
    font-size: 14px;
}

/* Welcome */
.header {
    background: white;
    padding: 30px;
    border-radius: 12px;
    margin-bottom: 30px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
    position: relative;
    overflow: hidden;
    animation: slideDown 0.7s ease;
}

.header::after {
    content: "";
    position: absolute;
    width: 180px;
    height: 180px;
    border-radius: 50%;
    right: -70px;
    top: -70px;
    background: #3498db;
    opacity: 0.08;
}

.header h1 {
    font-size: 30px;
    margin-bottom: 10px;
    color: #222831;
}

.header p {
    color: #777;
    font-size: 15px;
}

#greeting {
    color: #3498db;
}

/* Cards */
.cards {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 22px;
}

.card {
    background: white;
    padding: 28px 22px;
    border-radius: 12px;
    text-align: center;
    min-height: 215px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.07);
    transition: all 0.35s ease;
    opacity: 0;
    transform: translateY(25px);
}

.card.show {
    opacity: 1;
    transform: translateY(0);
}

.card:hover {
    transform: translateY(-7px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
}

.card h3 {
    color: #222831;
    font-size: 19px;
    margin-bottom: 15px;
}

.card p {
    color: #777;
    font-size: 14px;
    line-height: 1.6;
    margin-bottom: 22px;
}

/* Button */
.btn {
    display: inline-block;
    padding: 11px 21px;
    background: #3498db;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s ease;
}

.btn:hover {
    background: #2980b9;
    transform: scale(1.04);
}

/* Footer */
.footer {
    text-align: center;
    color: #999;
    font-size: 13px;
    margin-top: 35px;
}

/* Animation */
@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive */
@media (max-width: 1000px) {
    .cards {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 700px) {
    .main {
        margin-left: 190px;
        padding: 20px;
    }

    .cards {
        grid-template-columns: 1fr;
    }

    .topbar {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }
}
</style>
</head>

<body>

<%@ include file="Sidebar.jsp" %>
<div class="main">

    <div class="topbar">
        <div class="page-title">Admin Panel / Dashboard</div>
        <div class="clock" id="clock">Loading...</div>
    </div>

    <div class="header">
        <h1><span id="greeting">Welcome</span>, <%= user %></h1>
        <p>Student Management System - Admin Dashboard</p>
    </div>

    <div class="cards">

        <div class="card">
            <h3>Student Management</h3>
            <p>Add and manage student records in the system.</p>
            <a class="btn"
               href="${pageContext.request.contextPath}/students/addStudent.jsp">
                Manage Students
            </a>
        </div>

        <div class="card">
            <h3>Course Management</h3>
            <p>Add and manage courses available for students.</p>
            <a class="btn"
               href="${pageContext.request.contextPath}/Course/addCourse.jsp">
                Manage Courses
            </a>
        </div>

        <div class="card">
            <h3>Marks & Grades</h3>
            <p>Assign marks and manage student grades.</p>
            <a class="btn"
               href="${pageContext.request.contextPath}/Grade/assignCourse.jsp">
                Manage Marks
            </a>
        </div>

        <div class="card">
            <h3>Logout</h3>
            <p>Logout securely from the admin account.</p>
            <a class="btn"
               href="${pageContext.request.contextPath}/logout"
               onclick="return confirmLogout();">
                Logout
            </a>
        </div>

    </div>

    <div class="footer">
        Student Management System | Admin Panel
    </div>

</div>

<script>
function updateClock() {
    const now = new Date();

    const date = now.toLocaleDateString('en-IN', {
        day: '2-digit',
        month: 'short',
        year: 'numeric'
    });

    const time = now.toLocaleTimeString('en-IN', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });

    document.getElementById("clock").innerHTML = date + " | " + time;
}

updateClock();
setInterval(updateClock, 1000);

function setGreeting() {
    const hour = new Date().getHours();
    let greeting;

    if (hour < 12) {
        greeting = "Good Morning";
    } else if (hour < 17) {
        greeting = "Good Afternoon";
    } else {
        greeting = "Good Evening";
    }

    document.getElementById("greeting").innerText = greeting;
}

setGreeting();

window.addEventListener("load", function() {
    const cards = document.querySelectorAll(".card");

    cards.forEach(function(card, index) {
        setTimeout(function() {
            card.classList.add("show");
        }, index * 120);
    });
});

const buttons = document.querySelectorAll(".btn");

buttons.forEach(function(button) {
    button.addEventListener("click", function() {
        this.style.transform = "scale(0.96)";

        setTimeout(() => {
            this.style.transform = "";
        }, 150);
    });
});
</script>

</body>
</html>