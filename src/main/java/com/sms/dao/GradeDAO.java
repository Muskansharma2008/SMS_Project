package com.sms.dao;

import java.sql.*;
import com.sms.model.Grade;
import com.sms.util.DBConnection;

public class GradeDAO {

    public void assignCourse(Grade g) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO grade(student_id,course_id,marks,grade) VALUES(?,?,?,?)"
            );

            ps.setInt(1, g.getStudentId());
            ps.setInt(2, g.getCourseId());
            ps.setInt(3, g.getMarks());
            ps.setString(4, g.getGrade());

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
