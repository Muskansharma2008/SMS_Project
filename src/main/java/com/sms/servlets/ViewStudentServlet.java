package com.sms.servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

@WebServlet("/ViewStudentServlet")
public class ViewStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        StudentDAO dao = new StudentDAO();

        List<Student> students = dao.getAllStudents();

        req.setAttribute("students", students);

        req.getRequestDispatcher("/students/viewStudent.jsp")
           .forward(req, resp);
    }
}