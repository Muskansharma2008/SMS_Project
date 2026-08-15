<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px gray;
    }

    .form-group {
        display: flex;
        align-items: center;
        margin: 10px 0;
    }

    .form-group label {
        width: 100px;   /* same width for all labels */
    }

    .form-group input {
        flex: 1;
        padding: 5px;
    }

    button {
        margin-top: 10px;
        width: 100%;
    }
</style>

<div class="container">
<h2 style="text-align:center;">Grade Calculator</h2>

<form action="${pageContext.request.contextPath}/GradeServlet" method="post">
    <div class="form-group">
            <label>Student ID:</label>
            <input type="text" name="studentId" required>
        </div>
  <div class="form-group">
            <label>Course ID:</label>
            <input type="text" name="courseId" required>
        </div>
   <div class="form-group">
            <label> Marks:</label>
            <input type="text" name="marks" required>
        </div>
    
    <button type="submit">Add</button>
</form>

</div>
</body>
</html>
