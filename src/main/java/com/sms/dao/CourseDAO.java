package com.sms.dao;

import java.util.*;
import java.sql.*;
import com.sms.model.Course;
import com.sms.util.DBConnection;

public class CourseDAO {

    // Add Course
    public void addCourse(Course c) {

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO course(course_id, course_name, duration) VALUES(?,?,?)"
            );

            ps.setInt(1, c.getCourseId());
            ps.setString(2, c.getCourseName());
            ps.setString(3, c.getDuration());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Course Added Successfully ✅");
            } else {
                System.out.println("Failed to Add Course ❌");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // View All Courses
    public List<Course> getAllCourses() {

        List<Course> courses = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM course";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            System.out.println("getAllCourses() called");

            while (rs.next()) {

                Course c1 = new Course();

                c1.setCourseId(rs.getInt("course_id"));
                c1.setCourseName(rs.getString("course_name"));
                c1.setDuration(rs.getString("duration"));

                courses.add(c1);
                System.out.println(
                        "Course: " +
                        c1.getCourseId() + " | " +
                        c1.getCourseName() + " | " +
                        c1.getDuration()
                    );
            }
            System.out.println("Total courses: " + courses.size());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return courses;
    }
}