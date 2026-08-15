<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Grade Error</title>

<style>

    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #eef2f7, #dce6f1);
        text-align: center;
        margin: 0;
        padding-top: 100px;
    }

    .error-box {
        width: 450px;
        margin: auto;
        padding: 35px 30px;
        background-color: white;
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        border-top: 5px solid #e74c3c;
    }

    .icon {
        font-size: 48px;
        margin-bottom: 10px;
    }

    .error {
        color: #e74c3c;
        font-size: 22px;
        font-weight: bold;
    }

    .error p {
        color: #666;
        font-size: 15px;
        font-weight: normal;
        margin-top: 10px;
    }

    a {
        display: inline-block;
        margin-top: 25px;
        padding: 11px 22px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 7px;
        font-size: 15px;
        transition: 0.3s;
    }

    a:hover {
        background-color: #217dbb;
        transform: translateY(-2px);
    }

</style>

</head>

<body>

<%
String error = request.getParameter("error");
%>

<div class="error-box">

<div class="icon">⚠️</div>

<div class="error">

<%
if ("student".equals(error)) {
%>

    Student ID does not exist!
    <p>Please enter a valid Student ID.</p>

<%
} else if ("course".equals(error)) {
%>

    Course ID does not exist!
    <p>Please enter a valid Course ID.</p>

<%
} else if ("marks".equals(error)) {
%>

    <h2>Invalid Marks</h2>
    <p>Marks must be between 0 and 100.</p>

<%
} else if ("both".equals(error)) {
%>

    Student ID and Course ID do not exist!
    <p>Please enter valid Student ID and Course ID.</p>

<% 
} else {
%>

    Unable to add grade!
    <p>Please try again.</p>

<%
}
%>

</div>

<a href="assignCourse.jsp">← Back to Grade Form</a>

</div>

</body>

</html>
