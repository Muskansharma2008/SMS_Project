package com.sms.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.sms.dao.GradeDAO;
import com.sms.model.Grade;

@WebServlet("/GradeServlet")
public class GradeServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

    int studentId = Integer.parseInt(req.getParameter("studentId"));
    int courseId = Integer.parseInt(req.getParameter("courseId"));
    int marks = Integer.parseInt(req.getParameter("marks"));

    String grade;
    // Marks validation
    if (marks < 0 || marks > 100) {
        resp.sendRedirect(req.getContextPath() + "/Grade/GradeError.jsp?error=marks");
        return;
    }
    
    // Automatic Grade Generation
    if (marks >= 90) {
        grade = "A+";
    } else if (marks >= 80) {
        grade = "A";
    } else if (marks >= 70) {
        grade = "B+";
    } else if (marks >= 60) {
        grade = "B";
    } else if (marks >= 50) {
        grade = "C";
    } else if (marks >= 40) {
        grade = "D";
    } else {
        grade = "F";
    }

    // Create Grade object
    Grade g = new Grade();

    g.setStudentId(studentId);
    g.setCourseId(courseId);
    g.setMarks(marks);
    g.setGrade(grade);

    // Create DAO object
    GradeDAO dao = new GradeDAO();

    // Check Student and Course
    boolean studentExists = dao.studentExists(studentId);
    boolean courseExists = dao.courseExists(courseId);

    // Both Student and Course invalid
    if (!studentExists && !courseExists) {

        resp.sendRedirect(req.getContextPath() + "/Grade/GradeError.jsp?error=both");
        return;
    }
    String result = dao.addGrade(g);
    if ("marks".equals(result)) {

        resp.sendRedirect(req.getContextPath() + "/Grade/GradeError.jsp?error=marks");
        return;
    }

    // Student invalid
    if (!studentExists) {

        resp.sendRedirect(req.getContextPath() + "/Grade/GradeError.jsp?error=student");
        return;
    }

    // Course invalid
    if (!courseExists) {

        resp.sendRedirect(req.getContextPath() + "/Grade/GradeError.jsp?error=course");
        return;
    }

    // Both valid → Add Grade
    String result1 = dao.addGrade(g);

    if ("success".equals(result1)) {

        resp.sendRedirect(req.getContextPath() + "/Grade/SuccessGrade.jsp");

    } else {

        resp.sendRedirect(req.getContextPath() + "/Grade/GradeError.jsp?error=error");
    }
}

}
