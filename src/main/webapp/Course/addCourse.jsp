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

    <h2 style="text-align:center;">Add Course</h2>

    <form action="${pageContext.request.contextPath}/addCourse" method="post">

        <div class="form-group">
            <label>Course ID:</label>
            <input type="number" name="course_id" required>
        </div>

        <div class="form-group">
            <label>Course:</label>
            <input type="text" name="course_name">
        </div>
        
        <div class="form-group">
            <label>Course duration:</label>
            <input type="text" name="duration">
        </div>

        <button>Add</button>

    </form>

</div>