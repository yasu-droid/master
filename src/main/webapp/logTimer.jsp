<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");


String durationStr = request.getParameter("duration");
String startStr = request.getParameter("start");
String endStr = request.getParameter("end");
String loginid =(String) session.getAttribute("loginid");
String details = request.getParameter("details");

if (durationStr == null || startStr == null || endStr == null || loginid == null || details == null) {
    out.println("必要なデータが送信されていません。");
    return;
}

int duration = Integer.parseInt(durationStr);
String formattedStart = startStr.replace("T", " ").substring(0, 19);
String formattedEnd = endStr.replace("T", " ").substring(0, 19);
String formattedDate = formattedStart.substring(0, 10); // yyyy-MM-dd

Connection conn = null;
PreparedStatement stmt = null;

try {
    String dbUrl = "jdbc:postgresql://localhost:5432/time_data";
    String dbUserName = "postgres";
    String dbPassword = "password";

    Class.forName("org.postgresql.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);

    String sql = "INSERT INTO timer_log(duration_minutes, log_date, start_time, end_time ,loginid, details) VALUES (?, ?, ?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, duration);
    stmt.setDate(2, java.sql.Date.valueOf(formattedDate));
    stmt.setTimestamp(3, Timestamp.valueOf(formattedStart));
    stmt.setTimestamp(4, Timestamp.valueOf(formattedEnd));
    stmt.setString(5,loginid);
    stmt.setString(6,details);
    stmt.executeUpdate();

    out.println("記録に成功しました!");

} catch (Exception e) {
    out.println("エラー発生: " + e.getMessage());
    e.printStackTrace();
} finally {
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
%>