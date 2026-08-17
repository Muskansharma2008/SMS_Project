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
        
           StudentDAO dao = new StudentDAO();

           String result = dao.addStudent(s);

           if ("success".equals(result)) {

               resp.sendRedirect(
                   req.getContextPath() + "/students/successAdd.jsp"
               );

           } else if ("duplicate".equals(result)) {

               resp.setContentType("text/html;charset=UTF-8");

               resp.getWriter().println(
                   "<div style='text-align:center;margin-top:100px;font-family:Arial'>" +
                   "<h2>Student Already Registered</h2>" +
                   "<p>This student is already registered in the system.</p>" +
                   "<button onclick='history.back()'>Go Back</button>" +
                   "</div>"
               );

           } else {

               resp.getWriter().println(
                   "<h2>Unable to Add Student</h2>"
               );
           }
        }catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error adding student");
        }
    }
}