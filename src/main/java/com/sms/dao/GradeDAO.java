package com.sms.dao;

import java.sql.*;
import com.sms.model.Grade;
import com.sms.util.DBConnection;

public class GradeDAO {

// =========================
// Check Student Exists
// =========================
public boolean studentExists(int studentId) {

    boolean exists = false;

    try {
        Connection con = DBConnection.getConnection();

        String sql =
                "SELECT student_id FROM student WHERE student_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, studentId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            exists = true;
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return exists;
}


// =========================
// Check Course Exists
// =========================
public boolean courseExists(int courseId) {

    boolean exists = false;

    try {
        Connection con = DBConnection.getConnection();

        String sql =
                "SELECT course_id FROM course WHERE course_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, courseId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            exists = true;
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return exists;
}


// =========================
// Add Grade
// =========================
public String addGrade(Grade g) {

    try {
        // Check Marks
        if (g.getMarks() < 0 || g.getMarks() > 100) {
             System.out.println("Marks must be between 0 and 100 ❌");
             return "marks";
            }
        
        // Check Student
        boolean studentExists =
                studentExists(g.getStudentId());

        // Check Course
        boolean courseExists =
                courseExists(g.getCourseId());


        // Both are invalid
        if (!studentExists && !courseExists) {

            System.out.println(
                    "Student and Course do not exist ❌");

            return "both";
        }


        // Student is invalid
        if (!studentExists) {

            System.out.println(
                    "Student does not exist ❌");

            return "student";
        }


        // Course is invalid
        if (!courseExists) {

            System.out.println(
                    "Course does not exist ❌");

            return "course";
        }


        // =========================
        // Insert Grade
        // =========================

        Connection con = DBConnection.getConnection();

        String sql =
                "INSERT INTO grade(student_id, course_id, marks, grade) "
                + "VALUES (?, ?, ?, ?)";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(1, g.getStudentId());
        ps.setInt(2, g.getCourseId());
        ps.setInt(3, g.getMarks());
        ps.setString(4, g.getGrade());

        int rows = ps.executeUpdate();

        ps.close();
        con.close();


        if (rows > 0) {

            System.out.println(
                    "Grade Added Successfully ✅");

            return "success";

        } else {

            System.out.println(
                    "Failed to Add Grade ❌");

            return "error";
        }

    } catch (Exception e) {

        e.printStackTrace();

        return "error";
    }
}

}

