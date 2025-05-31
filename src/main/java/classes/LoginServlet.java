package classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//ログインIDの取得//
		HttpSession session = request.getSession(false);
		//セッションが存在する場合は破棄
		if (session != null) {
			session.invalidate();
		}

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String id = request.getParameter("loginID");
		String pw = request.getParameter("loginPw");

		// PostgreSQL DB接続情報
		String dbUrl = "jdbc:postgresql://localhost:5432/time_data";
		String dbUserName = "postgres";
		String dbPassword = "password";

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
		    Class.forName("org.postgresql.Driver");
		    out.println("JDBC Driver ロード成功！");
		} catch (ClassNotFoundException e) {
		    e.printStackTrace();
		    out.println("JDBC Driver が見つかりません！");
		}
		try {
			// JDBCドライバをロード
			Class.forName("org.postgresql.Driver");

			//セッションを新規で作成
			session = request.getSession(true);
			request.setCharacterEncoding("UTF-8");
			//String name = request.getParameter("name");

			// DB接続
			conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);

			// SQL文
			String sql = "SELECT * FROM users WHERE loginId = ? AND loginPw = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			rs = stmt.executeQuery();

			ServletContext sc = this.getServletContext();

			if (rs.next()) {
				// ログイン成功
				//DBからname,loginidを取得  
				String name = rs.getString("name");
				String loginid = rs.getString("loginid");
				//ログイン名,loginidをセッションで保持する
				session.setAttribute("name", name);
				session.setAttribute("loginid", loginid);

				response.sendRedirect("timer.jsp");

			} else {
				// ログイン失敗
				request.setAttribute("error", "ログインIDまたはパスワードが間違えています。");
				RequestDispatcher rd = sc.getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			out.println("データベースエラー: " + e.getMessage());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			out.println("ドライバが見つかりません: " + e.getMessage());
		} finally {
			// クローズ処理
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				out.println("クローズエラー: " + e.getMessage());
			}
		}
	}
}