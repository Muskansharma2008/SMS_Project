<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>

<h2>Welcome <%= user %></h2>

<a href="students/addStudent.jsp">Add Student</a><br>
<a href="Course/addCourse.jsp">Add Course</a><br>
<a href="Grade/assignCourse.jsp">Assign Course</a><br>
<br>

<a href="logout">Logout</a>

</body>
</html>