<%@ page import="java.util.*, java.sql.*" %>
<HTML>
<BODY>
<h1>Registration Successfully Done!</h1>
<p>Our Patient Details</p>
<%
  try {
    String p_name = request.getParameter("p_name");
    String p_disease = request.getParameter("p_disease");
    String p_address = request.getParameter("p_address");

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hospital", "root", "tiger");

    PreparedStatement pstmt = con.prepareStatement("INSERT INTO patients (p_name, p_disease, p_address) VALUES (?, ?, ?)");
    pstmt.setString(1, p_name);
    pstmt.setString(2, p_disease);
    pstmt.setString(3, p_address);
    pstmt.executeUpdate();
    pstmt.close();

    PreparedStatement selectStmt = con.prepareStatement("SELECT * FROM patients");
    ResultSet rs = selectStmt.executeQuery();

%>
<table border="5px">
<tr>
<th>Patient ID</th>
<th>Patient Name</th>
<th>Patient Disease</th>
<th>Patient Address</th>
</tr>
<% while(rs.next()) { %>
<tr>
<td><%= rs.getInt("p_id") %></td>
<td><%= rs.getString("p_name") %></td>
<td><%= rs.getString("p_disease") %></td>
<td><%= rs.getString("p_address") %></td>
</tr>
<%
  }
  rs.close();
  selectStmt.close();
  con.close();
} catch(Exception e) {
  out.println(e);
}
%>
</table>
</BODY>
</HTML>
