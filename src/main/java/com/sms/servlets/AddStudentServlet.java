package com.sms.servlets;

import java.io.IOException;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/addStudent")
public class AddStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws IOException {
        try {
           String name = req.getParameter("name");
           int courseId = Integer.parseInt(req.getParameter("course_id"));
           String email = req.getParameter("email");
           String phone = req.getParameter("phone");
           
           Student s = new Student();
           s.setName(name);
           s.setCourse_id(courseId);
           s.setEmail(email);
           s.setPhone(phone);
        
           new StudentDAO().addStudent(s);
           resp.sendRedirect(req.getContextPath() + "/students/successAdd.jsp");
        }catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error adding student");
        }
    }
}