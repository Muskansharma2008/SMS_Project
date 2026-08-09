<%@ page import="java.sql.*" %>
<%@ page import="com.sms.util.DBConnection" %>

<table border="1">
<tr>
<th>Student</th>
<th>Course</th>
<th>Marks</th>
<th>Grade</th>
</tr>

<%
Connection con = DBConnection.getConnection();

String q = "SELECT s.name,c.course_name,g.marks,g.grade FROM grade g "
         + "JOIN student s ON g.student_id=s.id "
         + "JOIN course c ON g.course_id=c.id";

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(q);

while(rs.next()){
%>

<tr>
<td><%=rs.getString(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getInt(3)%></td>
<td><%=rs.getString(4)%></td>
</tr>

<% } %>
</table>