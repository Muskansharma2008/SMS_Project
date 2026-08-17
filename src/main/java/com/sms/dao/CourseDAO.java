package com.sms.dao;

import java.util.*;
import java.sql.*;
import com.sms.model.Course;
import com.sms.util.DBConnection;

public class CourseDAO {

	public boolean courseExists(String courseName) {

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql =
	            "SELECT 1 FROM course WHERE course_name = ?";

	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, courseName);

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
    // Add Course
	public String addCourse(Course c) {

	    // Duplicate Course Check
	    if (courseExists(c.getCourseName())) {
	        System.out.println("Course already exists ❌");
	        return "duplicate";
	    }

	    try {
	        Connection con = DBConnection.getConnection();

	        PreparedStatement ps = con.prepareStatement(
	            "INSERT INTO course(course_id, course_name, duration) VALUES(?,?,?)"
	        );

	        ps.setInt(1, c.getCourseId());
	        ps.setString(2, c.getCourseName());
	        ps.setString(3, c.getDuration());

	        int rows = ps.executeUpdate();

	        ps.close();
	        con.close();

	        if (rows > 0) {
	            System.out.println("Course Added Successfully ✅");
	            return "success";
	        }

	        return "error";

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
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