<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Course" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Courses - SMS</title>

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

.container{
    width:800px;
    background:white;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 18px 40px rgba(0,0,0,.25);
    animation:slideUp .6s ease;
}

.header{
    background:#222831;
    color:white;
    padding:25px 35px;
}

.header h1{
    font-size:27px;
    margin-bottom:6px;
}

.header p{
    color:#cfd3d8;
    font-size:14px;
}

.table-container{
    padding:32px 40px;
}

.table-title{
    color:#222831;
    font-size:20px;
    margin-bottom:22px;
}

.table-wrapper{
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
}

th,td{
    padding:13px 15px;
    text-align:center;
    border-bottom:1px solid #e5e7eb;
    font-size:14px;
}

th{
    background:#3498db;
    color:white;
    font-size:14px;
}

tr{
    transition:.2s;
}

tbody tr:hover{
    background:#f1f8fd;
    transform:scale(1.005);
}

td{
    color:#333;
}

.no-course{
    padding:20px;
    color:#777;
    text-align:center;
}

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

@media(max-width:650px){
    .container{
        width:100%;
    }

    .table-container{
        padding:25px;
    }

    th,td{
        padding:11px 10px;
    }
}
</style>
</head>

<body>
<%@ include file="../Sidebar.jsp" %>
<div class="container">

    <div class="header">
        <h1>Available Courses</h1>
        <p>Student Management System</p>
    </div>

    <div class="table-container">

        <h2 class="table-title">Course Information</h2>

        <div class="table-wrapper">

            <table>
                <thead>
                    <tr>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Duration</th>
                    </tr>
                </thead>

                <tbody>

<%
    List<Course> courses =
        (List<Course>) request.getAttribute("courses");

    if(courses != null && !courses.isEmpty()){

        for(Course c : courses){
%>

                    <tr>
                        <td><%= c.getCourseId() %></td>
                        <td><%= c.getCourseName() %></td>
                        <td><%= c.getDuration() %></td>
                    </tr>

<%
        }

    }else{
%>

                    <tr>
                        <td colspan="3" class="no-course">
                            No Courses Available
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
</div>

</body>
</html>