package classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 public ReportServlet() {
  super();
 }

 @Override
 protected void doGet(HttpServletRequest request, HttpServletResponse response)
   throws ServletException, IOException {

  response.setContentType("text/html;charset=UTF-8");
  PrintWriter out = response.getWriter();

  HttpSession session = request.getSession(false);
  if (session == null || session.getAttribute("loginid") == null) {
   out.println("ログインしていません。");
   return;
  }

  String id = (String) session.getAttribute("loginid");

  String dbUrl = "jdbc:postgresql://localhost:5432/time_date";
  String dbUserName = "postgres";
  String dbPassword = "password";

  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;

  try {
   conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);

   String sql = "SELECT duration_minutes FROM timer_log WHERE loginId = ?";
   stmt = conn.prepareStatement(sql);
   stmt.setString(1, id);
   rs = stmt.executeQuery();

   int totalWorkTime = 0;
   while (rs.next()) {
    totalWorkTime += rs.getInt("duration_minutes");
   }

   out.println("<h1>合計作業時間: " + totalWorkTime + " 分</h1>");

  } catch (SQLException e) {
   e.printStackTrace();
   out.println("<p>データベースエラー: " + e.getMessage() + "</p>");
  } finally {
   try {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
   } catch (SQLException e) {
    e.printStackTrace();
   }
  }
 }
}