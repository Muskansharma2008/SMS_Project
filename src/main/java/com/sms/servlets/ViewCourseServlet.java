package com.sms.servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.sms.dao.CourseDAO;
import com.sms.model.Course;

public class ViewCourseServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        CourseDAO dao = new CourseDAO();

        List<Course> courses = dao.getAllCourses();

        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/Course/viewCourse.jsp")
               .forward(request, response);
    }
}
