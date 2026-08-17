<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.sms.util.DBConnection" %>

<%
String user = (String) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("../Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>View Grades - SMS</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4f6f8;
    color: #222831;
}

/* Main Content */

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

/* Header */

.header {
    background: white;
    padding: 25px 30px;
    border-radius: 12px;
    margin-bottom: 22px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
}

.header h1 {
    font-size: 28px;
    margin-bottom: 8px;
}

.header p {
    color: #777;
    font-size: 14px;
}

/* Search */

.toolbar {
    background: white;
    padding: 18px;
    border-radius: 10px;
    margin-bottom: 20px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.06);
}

.search {
    width: 100%;
    max-width: 350px;
    padding: 11px 14px;
    border: 1px solid #ddd;
    border-radius: 7px;
    outline: none;
    font-size: 14px;
}

.search:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52,152,219,0.12);
}

/* Table Card */

.table-card {
    background: white;
    border-radius: 12px;
    padding: 22px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #222831;
    color: white;
    padding: 14px;
    text-align: left;
    font-size: 14px;
}

td {
    padding: 14px;
    border-bottom: 1px solid #eee;
    font-size: 14px;
    color: #555;
}

tr:hover td {
    background: #f7faff;
}

/* Grade */

.grade {
    display: inline-block;
    min-width: 45px;
    text-align: center;
    padding: 6px 10px;
    border-radius: 5px;
    background: #eaf4ff;
    color: #2980b9;
    font-weight: bold;
}

/* Marks */

.marks {
    font-weight: bold;
    color: #222831;
}

/* No Data */

.no-data {
    text-align: center;
    padding: 35px;
    color: #888;
}

/* Footer */

.footer {
    text-align: center;
    color: #999;
    font-size: 13px;
    margin-top: 30px;
}

/* Responsive */

@media (max-width: 700px) {

    .main {
        margin-left: 190px;
        padding: 20px;
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

<%@ include file="../Sidebar.jsp" %>

<div class="main">

    <!-- Top Bar -->

    <div class="topbar">

        <div class="page-title">
            Admin Panel / Marks & Grades / View Grades
        </div>

        <div class="clock" id="clock">
            Loading...
        </div>

    </div>


    <!-- Header -->

    <div class="header">

        <h1>View Grades</h1>

        <p>
            View student marks and grades recorded in the system.
        </p>

    </div>


    <!-- Search -->

    <div class="toolbar">

        <input type="text"
               id="searchBox"
               class="search"
               placeholder="Search student or course..."
               onkeyup="searchGrades()">

    </div>


    <!-- Table -->

    <div class="table-card">

        <table id="gradeTable">

            <thead>

                <tr>
                    <th>Student</th>
                    <th>Course</th>
                    <th>Marks</th>
                    <th>Grade</th>
                </tr>

            </thead>

            <tbody>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

try {

    con = DBConnection.getConnection();

    String q =
    	    "SELECT s.name, c.course_name, g.marks, g.grade "
    	  + "FROM grade g "
    	  + "JOIN student s ON g.student_id = s.student_id "
    	  + "JOIN course c ON g.course_id = c.course_id";

    st = con.createStatement();
    rs = st.executeQuery(q);

    boolean hasData = false;

    while(rs.next()) {

        hasData = true;
%>

                <tr>

                    <td>
                        <%= rs.getString(1) %>
                    </td>

                    <td>
                        <%= rs.getString(2) %>
                    </td>

                    <td class="marks">
                        <%= rs.getInt(3) %>
                    </td>

                    <td>
                        <span class="grade">
                            <%= rs.getString(4) %>
                        </span>
                    </td>

                </tr>

<%
    }

    if (!hasData) {
%>

                <tr>

                    <td colspan="4" class="no-data">
                        No grade records found.
                    </td>

                </tr>

<%
    }

} catch(Exception e) {
%>

                <tr>

                    <td colspan="4" class="no-data">
                        Unable to load grade records.
                    </td>

                </tr>

<%
    e.printStackTrace();

} finally {

    try {
        if(rs != null) rs.close();
        if(st != null) st.close();
        if(con != null) con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }

}
%>

            </tbody>

        </table>

    </div>


    <div class="footer">
        Student Management System | Admin Panel
    </div>

</div>


<script>

/* Clock */

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

    document.getElementById("clock").innerHTML =
        date + " | " + time;
}

updateClock();

setInterval(updateClock, 1000);


/* Search */

function searchGrades() {

    const input =
        document.getElementById("searchBox").value.toLowerCase();

    const rows =
        document.querySelectorAll("#gradeTable tbody tr");

    rows.forEach(function(row) {

        const text =
            row.innerText.toLowerCase();

        row.style.display =
            text.includes(input) ? "" : "none";

    });

}

</script>

</body>

</html>