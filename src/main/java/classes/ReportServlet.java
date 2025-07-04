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

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReportServlet() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginid") == null) {
			return;
		}

		String id = (String) session.getAttribute("loginid");
		//		System.out.println(id);
		String dbUrl = "jdbc:postgresql://localhost:5432/time_data";
		String dbUserName = "postgres";
		String dbPassword = "password";

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);

			//String sql = "SELECT loginid,details,duration_minutes FROM timer_log where loginid = ? GROUP BY loginid,details,duration_minutes";
			String sql = "SELECT loginid, sum(duration_minutes) as totalWorkTime ,details from timer_log WHERE loginid = ? AND log_date >= CURRENT_DATE - INTERVAL '6 days' GROUP BY loginid,details";
			//
			//			String sql = "SELECT loginid, details, sum(duration_minutes) as totalWorkTime " +
			//					"FROM timer_log WHERE loginid = ? AND log_date >= CURRENT_DATE - INTERVAL '6 days' " +
			//					"GROUP BY loginid, details";
			//			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			//			System.out.println(id);
			//			ArrayList<Integer> sum_list = new ArrayList<>();

			while (rs.next()) {
				String loginidResult = rs.getString("loginid");
				String detailsResult = rs.getString("details");
				int totalResult = rs.getInt("totalWorkTime");
				System.out.println("loginid: " + loginidResult + ",details: " + detailsResult + ",minutes:" + totalResult);

			}

			//			System.out.println(sum_list);
			//			request.setAttribute("sum_list", sum_list);
			request.getRequestDispatcher("/report.jsp").forward(request, response);

			//		String text = "test";
			//		request.setAttribute("text",text);
			//		request.getRequestDispatcher("/report.jsp").forward(request,response);
		} catch (SQLException e) {
			e.printStackTrace();
			out.println("<p>データベースエラー: " + e.getMessage() + "</p>");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			out.println("<p>ドライバが見つかりません: " + e.getMessage() + "</p>");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
