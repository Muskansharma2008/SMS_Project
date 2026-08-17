package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.Student;
import com.sms.util.DBConnection;

public class StudentDAO {

    // =========================
    // Check Duplicate Student
    // =========================
    public boolean studentExists(String email) {

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT 1 FROM student WHERE email = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            boolean exists = rs.next();

            rs.close();
            ps.close();
            con.close();

            return exists;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================
    // Add Student
    // =========================
    public String addStudent(Student s) {

        // Duplicate check
        if (studentExists(s.getEmail())) {
            System.out.println("Student Already Registered ❌");
            return "duplicate";
        }

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO student(name,course_id,email,phone) VALUES(?,?,?,?)"
            );

            ps.setString(1, s.getName());
            ps.setInt(2, s.getCourse_id());
            ps.setString(3, s.getEmail());
            ps.setString(4, s.getPhone());

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) {
                System.out.println("Student Added Successfully ✅");
                return "success";
            } else {
                System.out.println("Failed to Add Student ❌");
                return "error";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }


    // =========================
    // View All Students
    // =========================
    public List<Student> getAllStudents() {

        List<Student> students = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT s.student_id, s.name, s.email, s.phone, " +
                "c.course_name " +
                "FROM student s " +
                "LEFT JOIN course c ON s.course_id = c.course_id";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Student s = new Student();

                s.setId(rs.getInt("student_id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setCourseName(rs.getString("course_name"));

                students.add(s);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }
}