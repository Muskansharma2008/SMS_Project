<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Student" %>

<%
String user = (String) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(request.getContextPath() + "/Login.jsp");
    return;
}

List<Student> students =
    (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>View Students - SMS</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    min-height:100vh;
    background:linear-gradient(135deg,#222831,#3498db);
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
}

.main{
    margin-left:240px;
    padding:30px;
    min-height:100vh;
}

/* Top Bar */
.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.page-title{
    font-size:14px;
    color:#777;
}


/* Main Card */
.content-card{
    background:white;
    border-radius:12px;
    overflow:hidden;
    box-shadow:0 3px 12px rgba(0,0,0,.07);
    animation:slideUp .7s ease-out;
}

/* Dark Header */
.card-header{
    background:#222831;
    color:white;
    padding:25px 35px;
}

.card-header h1{
    font-size:28px;
    margin-bottom:7px;
}

.card-header p{
    font-size:14px;
    color:#ddd;
}

/* Content */
.card-body{
    padding:30px 40px;
}

.section-title{
    font-size:20px;
    font-weight:bold;
    margin-bottom:20px;
    color:#222831;
}

/* Search */
.search-box{
    width:100%;
    max-width:350px;
    padding:11px 14px;
    border:1px solid #ddd;
    border-radius:6px;
    outline:none;
    font-size:14px;
    margin-bottom:20px;
}

.search-box:focus{
    border-color:#3498db;
    box-shadow:0 0 0 3px rgba(52,152,219,.12);
}

/* Table */
.table-wrapper{
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#3498db;
    color:white;
    padding:13px 12px;
    text-align:center;
    font-size:14px;
}

td{
    padding:12px;
    border-bottom:1px solid #ddd;
    text-align:center;
    font-size:14px;
    color:#333;
}

tr{
    transition:.2s;
}
tr:hover td{
    background:#f7faff;
}

.student-id{
    font-weight:bold;
    color:#222831;
}

.course{
    color:#2980b9;
    font-weight:500;
}

.no-data{
    text-align:center;
    padding:30px;
    color:#888;
}

/* Back */
.back{
    margin-top:22px;
}

.back a{
    color:#3498db;
    text-decoration:none;
    font-size:14px;
}

.back a:hover{
    text-decoration:underline;
}

/* Footer */
.footer{
    text-align:center;
    color:#999;
    font-size:13px;
    margin-top:30px;
}
@keyframes slideUp{
    from{
        opacity:0;
        transform:translateY(25px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

@media(max-width:700px){

    .main{
        margin-left:190px;
        padding:20px;
    }

    .topbar{
        flex-direction:column;
        align-items:flex-start;
        gap:10px;
    }

    .card-body{
        padding:20px;
    }

    .card-header{
        padding:22px;
    }
}

</style>

</head>

<body>

<%@ include file="../Sidebar.jsp" %>

<div class="main">

    <!-- Top Bar -->
    <div class="topbar">

        <div class="page-title">
            Admin Panel / Students / View Students
        </div>

    </div>

    <!-- Main Card -->
    <div class="content-card">

        <!-- Dark Header -->
        <div class="card-header">

            <h1>Registered Students</h1>

            <p>
                Student Management System
            </p>

        </div>

        <!-- White Content -->
        <div class="card-body">

            <div class="section-title">
                Student Information
            </div>

            <!-- Search -->
            <input type="text"
                   id="searchBox"
                   class="search-box"
                   placeholder="Search student or course..."
                   onkeyup="searchStudents()">

            <!-- Table -->
            <div class="table-wrapper">

                <table id="studentTable">

                    <thead>

                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Course</th>
                        </tr>

                    </thead>

                    <tbody>

<%
if (students != null && !students.isEmpty()) {

    for (Student s : students) {
%>

                        <tr>

                            <td class="student-id">
                                <%= s.getId() %>
                            </td>

                            <td>
                                <%= s.getName() %>
                            </td>

                            <td>
                                <%= s.getEmail() %>
                            </td>

                            <td>
                                <%= s.getPhone() %>
                            </td>

                            <td class="course">
                                <%= s.getCourseName() %>
                            </td>

                        </tr>

<%
    }

} else {
%>

                        <tr>
                            <td colspan="5" class="no-data">
                                No student records found.
                            </td>
                        </tr>

<%
}
%>
                    </tbody>

                </table>

            </div>

            
        <div class="back">
            <a href="${pageContext.request.contextPath}/dashboard.jsp">
                Back to Dashboard
            </a>
        </div>

</div>

<script>

function searchStudents(){

    const input =
        document.getElementById("searchBox").value.toLowerCase();

    const rows =
        document.querySelectorAll("#studentTable tbody tr");

    rows.forEach(function(row){

        const text =
            row.innerText.toLowerCase();

        row.style.display =
            text.includes(input) ? "" : "none";
    });
}

</script>

</body>
</html>