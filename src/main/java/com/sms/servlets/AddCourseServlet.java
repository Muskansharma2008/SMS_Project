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

        new CourseDAO().addCourse(c);

        resp.sendRedirect(req.getContextPath() + "/Course/courseAdded.jsp");
        }catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error adding student");
        }
    }
}