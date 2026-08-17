<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Student - SMS</title>

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}

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
    from{opacity:0;transform:translateY(25px)}
    to{opacity:1;transform:translateY(0)}
}

@media(max-width:650px){
    .container{width:100%}
    .form-container{padding:25px}
    .form-grid{grid-template-columns:1fr}
}
</style>
</head>

<body>
<%@ include file="../Sidebar.jsp" %>
<div class="container">

    <div class="header">
        <h1>Add Student</h1>
        <p>Student Management System</p>
    </div>

    <div class="form-container">

        <h2 class="form-title">Student Information</h2>

        <form action="${pageContext.request.contextPath}/addStudent"
              method="post"
              onsubmit="return validateForm();">

            <div class="form-grid">

                <div class="form-group">
                    <label for="name">Student Name</label>
                    <input type="text" id="name" name="name"
                           placeholder="Enter student name">
                    <div class="error" id="nameError">
                        Please enter student name.
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email"
                           placeholder="Enter email address">
                    <div class="error" id="emailError">
                        Please enter a valid email.
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone"
                           placeholder="Enter 10-digit phone number"
                           maxlength="10">
                    <div class="error" id="phoneError">
                        Please enter a valid 10-digit phone number.
                    </div>
                </div>

                <div class="form-group">
                    <label for="course_id">Course ID</label>
                    <input type="number" id="course_id" name="course_id"
                           placeholder="Enter course ID" min="1">
                    <div class="error" id="courseError">
                        Please enter a valid Course ID.
                    </div>
                </div>

            </div>

            <div class="buttons">
                <button type="submit" class="btn submit-btn">
                    Add Student
                </button>
                <button type="reset" class="btn reset-btn"
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
    const name=document.getElementById("name");
    const email=document.getElementById("email");
    const phone=document.getElementById("phone");
    const course=document.getElementById("course_id");

    if(name.value.trim()===""){
        showError(name,"nameError");
        valid=false;
    }else showSuccess(name,"nameError");

    const emailPattern=/^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if(!emailPattern.test(email.value.trim())){
        showError(email,"emailError");
        valid=false;
    }else showSuccess(email,"emailError");

    const phonePattern=/^[0-9]{10}$/;

    if(!phonePattern.test(phone.value.trim())){
        showError(phone,"phoneError");
        valid=false;
    }else showSuccess(phone,"phoneError");

    if(course.value.trim()===""||Number(course.value)<=0){
        showError(course,"courseError");
        valid=false;
    }else showSuccess(course,"courseError");

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