package com.sms.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
            username.trim().isEmpty() || password.isEmpty()) {

            response.sendRedirect(
                request.getContextPath() + "/Login.jsp?error=invalid"
            );
            return;
        }

        username = username.trim();

        String sql = "SELECT admin_id, username FROM admin "
                   + "WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    // Create session after successful login
                    HttpSession session = request.getSession(true);

                    session.setAttribute(
                        "user",
                        rs.getString("username")
                    );

                    session.setAttribute(
                        "adminId",
                        rs.getInt("admin_id")
                    );

                    response.sendRedirect(
                        request.getContextPath() + "/dashboard.jsp"
                    );

                } else {

                    response.sendRedirect(
                        request.getContextPath()
                        + "/Login.jsp?error=invalid"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/Login.jsp?error=database"
            );
        }
    }

    protected void doGet1(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        response.sendRedirect(
            request.getContextPath() + "/Login.jsp"
        );
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        response.sendRedirect(
            request.getContextPath() + "/Login.jsp"
        );
    }
}