<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login Page</h2>

<form action="LoginServlet" method="post">
    Username: <input type="text" name="username"><br><br>
    Password: <input type="password" name="password"><br><br>
    <input type="submit" value="Login">
</form>

<%
    String error = request.getParameter("error");
    if (error != null) {
%>
    <p style="color:red;">Invalid Username or Password</p>
<%
    }
%>

</body>
</html>