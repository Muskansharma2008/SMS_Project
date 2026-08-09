package com.sms.dao;

import java.sql.*;
import com.sms.model.Student;
import com.sms.util.DBConnection;

public class StudentDAO {

    public void addStudent(Student s) {
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

            if(rows > 0) {
                System.out.println("Student Added Successfully ✅");
            } else {
                System.out.println("Failed to Add Student ❌");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}