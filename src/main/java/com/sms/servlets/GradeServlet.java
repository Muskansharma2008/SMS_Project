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

        // Marks validation
        if (marks < 0 || marks > 100) {
            showMessage(resp, "Invalid Marks",
                    "Marks must be between 0 and 100.");
            return;
        }

        // Automatic Grade Generation
        String grade;

        if (marks >= 90)
            grade = "A+";
        else if (marks >= 80)
            grade = "A";
        else if (marks >= 70)
            grade = "B+";
        else if (marks >= 60)
            grade = "B";
        else if (marks >= 50)
            grade = "C";
        else if (marks >= 40)
            grade = "D";
        else
            grade = "F";

        // Create Grade object
        Grade g = new Grade();

        g.setStudentId(studentId);
        g.setCourseId(courseId);
        g.setMarks(marks);
        g.setGrade(grade);

        GradeDAO dao = new GradeDAO();

        // Check Student
        if (!dao.studentExists(studentId)) {

            showMessage(resp, "Student Not Found",
                    "The entered Student ID does not exist.");

            return;
        }

        // Check Course
        if (!dao.courseExists(courseId)) {

            showMessage(resp, "Course Not Found",
                    "The entered Course ID does not exist.");

            return;
        }

        // Add Grade - ONLY ONCE
        String result = dao.addGrade(g);

        if ("success".equals(result)) {

            resp.sendRedirect(req.getContextPath()
                    + "/Grade/SuccessGrade.jsp");

        } else if ("duplicate".equals(result)) {

            showMessage(resp, "Record Already Registered",
                    "This grade record is already registered for this student and course.");

        } else if ("marks".equals(result)) {

            showMessage(resp, "Invalid Marks",
                    "Marks must be between 0 and 100.");

        } else {

            showMessage(resp, "Unable to Add Grade",
                    "Something went wrong while adding the grade.");

        }
    }

    // Direct message page
    private void showMessage(HttpServletResponse resp,
                             String title,
                             String message)
            throws IOException {

        resp.setContentType("text/html;charset=UTF-8");

        resp.getWriter().println(
            "<!DOCTYPE html>" +
            "<html><head>" +
            "<title>" + title + "</title>" +
            "<style>" +
            "body{margin:0;font-family:Arial,sans-serif;" +
            "background:#f4f6f8;display:flex;" +
            "justify-content:center;align-items:center;height:100vh;}" +

            ".box{background:white;padding:35px 45px;" +
            "border-radius:12px;text-align:center;" +
            "box-shadow:0 5px 20px rgba(0,0,0,.10);}" +

            "h2{color:#222831;margin-bottom:10px;}" +
            "p{color:#777;margin-bottom:25px;}" +

            "a{display:inline-block;padding:10px 20px;" +
            "background:#222831;color:white;text-decoration:none;" +
            "border-radius:6px;}" +

            "</style></head><body>" +

            "<div class='box'>" +
            "<h2>" + title + "</h2>" +
            "<p>" + message + "</p>" +
            "<a href='" + resp.encodeRedirectURL("javascript:history.back()") +
            "'>Go Back</a>" +
            "</div>" +

            "</body></html>"
        );
    }
}