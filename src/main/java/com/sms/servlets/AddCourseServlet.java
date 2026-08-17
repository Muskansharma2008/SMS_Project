package com.sms.servlets;

import java.io.IOException;

import com.sms.dao.CourseDAO;
import com.sms.model.Course;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/addCourse")
public class AddCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws IOException {
        try {
    	int course_id = Integer.parseInt(req.getParameter("course_id"));
        String course_name = req.getParameter("course_name");
        String duration = req.getParameter("duration");
        
        Course c = new Course();
        c.setCourseId(course_id);
        c.setCourseName(course_name);
        c.setDuration(duration);

        CourseDAO dao = new CourseDAO();

        String result = dao.addCourse(c);

        if ("success".equals(result)) {

            resp.sendRedirect(
                req.getContextPath() + "/Course/courseAdded.jsp"
            );

        } else if ("duplicate".equals(result)) {

            resp.setContentType("text/html;charset=UTF-8");

            resp.getWriter().println(
                "<!DOCTYPE html>" +
                "<html><head>" +
                "<title>Course Already Exists</title>" +
                "<style>" +
                "body{font-family:Arial;background:#f4f6f8;" +
                "display:flex;justify-content:center;align-items:center;" +
                "height:100vh;}" +
                ".box{background:white;padding:35px 45px;" +
                "border-radius:12px;text-align:center;" +
                "box-shadow:0 5px 20px rgba(0,0,0,.1);}" +
                "h2{color:#222831;}" +
                "p{color:#777;}" +
                "button{padding:10px 20px;background:#222831;" +
                "color:white;border:0;border-radius:6px;" +
                "cursor:pointer;}" +
                "</style></head><body>" +

                "<div class='box'>" +
                "<h2>Course Already Exists</h2>" +
                "<p>This course is already registered in the system.</p>" +
                "<button onclick='history.back()'>Go Back</button>" +
                "</div>" +

                "</body></html>"
            );

        } else {

            resp.getWriter().println("Unable to add course.");
        }
        }catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error adding student");
        }
    }
}