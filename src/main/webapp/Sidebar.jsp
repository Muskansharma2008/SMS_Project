<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String currentPage = request.getRequestURI();
String menu = request.getParameter("menu");

boolean addCourseActive = "addcourse".equals(menu);

boolean viewCourseActive = "viewcourses".equals(menu);

boolean coursesActive =
        addCourseActive || viewCourseActive;

boolean studentsActive =
currentPage.contains("/students/")
|| currentPage.contains("ViewStudentServlet");

boolean addStudentActive =
currentPage.contains("addStudent.jsp");

boolean viewStudentActive =
"viewstudents".equals(request.getParameter("menu"));
%>

<style>

/* =========================
   Sidebar
========================= */

.sidebar {
    width: 240px;
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    background: #222831;
    color: white;
    padding: 25px 15px;
    z-index: 1000;
}

.logo {
    text-align: center;
    font-size: 25px;
    font-weight: bold;
    margin-bottom: 40px;
    letter-spacing: 1px;
}

.menu-title {
    color: #9ca3af;
    font-size: 12px;
    margin: 20px 15px 10px;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.sidebar a {
    display: block;
    text-decoration: none;
    color: #e5e7eb;
    padding: 13px 15px;
    margin-bottom: 8px;
    border-radius: 7px;
    font-size: 15px;
    transition: all 0.3s ease;
}

.sidebar a:hover {
    background: #393e46;
    padding-left: 20px;
}

.sidebar a.active {
    background: #3498db;
    color: white;
    box-shadow: 0 4px 10px rgba(52,152,219,0.3);
}

.logout-link {
    margin-top: 35px;
    background: #c0392b;
}

.logout-link:hover {
    background: #e74c3c !important;
}


/* =========================
   Courses Dropdown
========================= */

.menu-dropdown {
    margin-bottom: 8px;
}

.dropdown-title {
    display: flex !important;
    justify-content: space-between;
    align-items: center;
}

.submenu {
    display: none;
    margin-left: 10px;
}

.submenu.show {
    display: block;
}

.submenu a {
    font-size: 14px;
    padding: 10px 15px;
    margin-bottom: 3px;
    color: #cfd4da;
}

.submenu a:hover {
    background: #393e46;
    padding-left: 20px;
}

.submenu a.submenu-active {
    background: #393e46;
    color: white;
    padding-left: 20px;
}

#courseArrow {
    font-size: 16px;
    transition: transform 0.3s ease;
}

#courseArrow.open {
    transform: rotate(90deg);
}


/* =========================
   Responsive Sidebar
========================= */

@media (max-width: 700px) {

    .sidebar {
        width: 190px;
    }

}

</style>


<div class="sidebar">

    <div class="logo">SMS Admin</div>

    <div class="menu-title">Main Menu</div>


    <!-- Dashboard -->

    <a href="${pageContext.request.contextPath}/dashboard.jsp"
       class="<%= currentPage.endsWith("dashboard.jsp") ? "active" : "" %>">
        Dashboard
    </a>


    <!-- Students Dropdown -->

<div class="menu-dropdown">

    <a href="javascript:void(0);"
       class="dropdown-title <%= studentsActive ? "active" : "" %>"
       onclick="toggleStudents()">

        Students

        <span id="studentArrow">▸</span>

    </a>


    <div id="studentMenu"
         class="submenu <%= studentsActive ? "show" : "" %>">


        <!-- Add Student -->

        <a href="${pageContext.request.contextPath}/students/addStudent.jsp?menu=addstudent"
           class="<%= addStudentActive ? "submenu-active" : "" %>">
           Add Student
        </a>


        <!-- View Students -->

        <a href="${pageContext.request.contextPath}/ViewStudentServlet?menu=viewstudents"
           class="<%= viewStudentActive ? "submenu-active" : "" %>">
           View Students
        </a>

    </div>

</div>


    <!-- Courses Dropdown -->

    <div class="menu-dropdown">

        <a href="javascript:void(0);"
           class="dropdown-title <%= coursesActive ? "active" : "" %>"
           onclick="toggleCourses()">

            Courses

            <span id="courseArrow">▸</span>

        </a>


        <div id="courseMenu"
             class="submenu <%= coursesActive ? "show" : "" %>">


            <!-- Add Course -->

            <a href="${pageContext.request.contextPath}/Course/addCourse.jsp?menu=addcourse"
               class="<%= addCourseActive ? "submenu-active" : "" %>">
               Add Course
            </a>


            <!-- View Courses -->

            <a href="${pageContext.request.contextPath}/ViewCourseServlet?menu=viewcourses"
               class="<%= viewCourseActive ? "submenu-active" : "" %>">
               View Courses
            </a>

        </div>

    </div>


    <!-- Marks & Grades -->

    <div class="menu-dropdown">

    <a href="javascript:void(0);"
       class="dropdown-title <%= currentPage.contains("/Grade/") ? "active" : "" %>"
       onclick="toggleGrades()">

        Marks & Grades
        <span id="gradeArrow">▸</span>

    </a>

    <div id="gradeMenu"
         class="submenu <%= currentPage.contains("/Grade/") ? "show" : "" %>">

        <a href="${pageContext.request.contextPath}/Grade/assignCourse.jsp"
           class="<%= currentPage.endsWith("assignCourse.jsp") ? "submenu-active" : "" %>">
            Assign Marks
        </a>

        <a href="${pageContext.request.contextPath}/Grade/viewReport.jsp"
           class="<%= currentPage.endsWith("viewReport.jsp") ? "submenu-active" : "" %>">
            View Grades
        </a>

    </div>

</div>


    <!-- Logout -->

    <a href="${pageContext.request.contextPath}/logout"
       class="logout-link"
       onclick="return confirmLogout();">

        Logout

    </a>

</div>


<script>
function toggleStudents() {

    const menu = document.getElementById("studentMenu");
    const arrow = document.getElementById("studentArrow");

    menu.classList.toggle("show");

    if (menu.classList.contains("show")) {
        arrow.innerHTML = "▾";
    } else {
        arrow.innerHTML = "▸";
    }
}

function toggleCourses() {

    const menu = document.getElementById("courseMenu");
    const arrow = document.getElementById("courseArrow");

    menu.classList.toggle("show");
    arrow.classList.toggle("open");

}


window.addEventListener("load", function() {

    const menu = document.getElementById("courseMenu");
    const arrow = document.getElementById("courseArrow");

    if (menu.classList.contains("show")) {
        arrow.classList.add("open");
    }

});

function toggleGrades() {

    const menu = document.getElementById("gradeMenu");
    const arrow = document.getElementById("gradeArrow");

    menu.classList.toggle("show");
    arrow.classList.toggle("open");
}
function confirmLogout() {

    return confirm("Are you sure you want to logout?");

}

</script>