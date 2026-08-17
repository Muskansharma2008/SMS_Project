<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Grade Calculator - SMS</title>

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
    padding:25px;
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

.form-container{
    padding:32px 40px;
}

.form-title{
    color:#222831;
    font-size:20px;
    margin-bottom:22px;
}

.form-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
}

.form-group label{
    display:block;
    font-size:14px;
    font-weight:bold;
    color:#333;
    margin-bottom:7px;
}

.form-group input{
    width:100%;
    padding:12px 14px;
    border:1px solid #d5d8dc;
    border-radius:7px;
    outline:none;
    font-size:14px;
    transition:.3s;
}

.form-group input:focus{
    border-color:#3498db;
    box-shadow:0 0 0 3px rgba(52,152,219,.12);
}

.form-group input.valid{
    border-color:#27ae60;
}

.form-group input.invalid{
    border-color:#e74c3c;
}

.error{
    color:#e74c3c;
    font-size:12px;
    margin-top:5px;
    display:none;
}

.buttons{
    margin-top:27px;
    display:flex;
    gap:12px;
}

.btn{
    padding:11px 24px;
    border:none;
    border-radius:7px;
    font-size:14px;
    cursor:pointer;
    transition:.3s;
}

.submit-btn{
    background:#3498db;
    color:white;
}

.submit-btn:hover{
    background:#2980b9;
    transform:translateY(-2px);
}

.reset-btn{
    background:#e5e7eb;
    color:#333;
}

.reset-btn:hover{
    background:#d5d8dc;
}

.back{
    margin-top:20px;
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

    .form-container{
        padding:25px;
    }

    .form-grid{
        grid-template-columns:1fr;
    }
}
</style>
</head>

<body>
<%@ include file="../Sidebar.jsp" %>
<div class="container">

    <div class="header">
        <h1>Grade Calculator</h1>
        <p>Student Management System</p>
    </div>

    <div class="form-container">

        <h2 class="form-title">Grade Information</h2>

        <form action="${pageContext.request.contextPath}/GradeServlet"
              method="post"
              onsubmit="return validateForm();">

            <div class="form-grid">

                <div class="form-group">
                    <label for="studentId">Student ID</label>
                    <input type="number"
                           id="studentId"
                           name="studentId"
                           placeholder="Enter student ID"
                           min="1">

                    <div class="error" id="studentError">
                        Please enter a valid Student ID.
                    </div>
                </div>

                <div class="form-group">
                    <label for="courseId">Course ID</label>
                    <input type="number"
                           id="courseId"
                           name="courseId"
                           placeholder="Enter course ID"
                           min="1">

                    <div class="error" id="courseError">
                        Please enter a valid Course ID.
                    </div>
                </div>

                <div class="form-group">
                    <label for="marks">Marks</label>
                    <input type="number"
                           id="marks"
                           name="marks"
                           placeholder="Enter marks (0-100)"
                           min="0"
                           max="100">

                    <div class="error" id="marksError">
                        Marks must be between 0 and 100.
                    </div>
                </div>

            </div>

            <div class="buttons">
                <button type="submit" class="btn submit-btn">
                    Calculate Grade
                </button>

                <button type="reset"
                        class="btn reset-btn"
                        onclick="resetForm()">
                    Reset
                </button>
            </div>

        </form>

        <div class="back">
            <a href="${pageContext.request.contextPath}/dashboard.jsp">
                Back to Dashboard
            </a>
        </div>

    </div>
</div>

<script>
function validateForm(){
    let valid=true;

    const student=document.getElementById("studentId");
    const course=document.getElementById("courseId");
    const marks=document.getElementById("marks");

    if(student.value.trim()==="" || Number(student.value)<=0){
        showError(student,"studentError");
        valid=false;
    }else{
        showSuccess(student,"studentError");
    }

    if(course.value.trim()==="" || Number(course.value)<=0){
        showError(course,"courseError");
        valid=false;
    }else{
        showSuccess(course,"courseError");
    }

    if(marks.value.trim()==="" ||
       Number(marks.value)<0 ||
       Number(marks.value)>100){

        showError(marks,"marksError");
        valid=false;
    }else{
        showSuccess(marks,"marksError");
    }

    return valid;
}

function showError(input,errorId){
    input.classList.add("invalid");
    input.classList.remove("valid");
    document.getElementById(errorId).style.display="block";
}

function showSuccess(input,errorId){
    input.classList.remove("invalid");
    input.classList.add("valid");
    document.getElementById(errorId).style.display="none";
}

function resetForm(){
    document.querySelectorAll("input").forEach(input=>{
        input.classList.remove("valid","invalid");
    });

    document.querySelectorAll(".error").forEach(error=>{
        error.style.display="none";
    });
}
</script>

</body>
</html>