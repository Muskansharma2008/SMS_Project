package com.sms.dao;

import java.sql.*;
import com.sms.model.Course;
import com.sms.util.DBConnection;

public class CourseDAO {

    public void addCourse(Course c) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO course(course_id,course_name,duration) VALUES(?,?,?)"
            );

            ps.setInt(1, c.getCourseId());
            ps.setString(2, c.getCourseName());
            ps.setString(3, c.getDuration());
            int rows = ps.executeUpdate();

            if(rows > 0) {
                System.out.println("Course Added Successfully ✅");
            } else {
                System.out.println("Failed to Add Course ❌");
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}