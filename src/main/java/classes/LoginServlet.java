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

//ログイン画面でpost送信されたとき、以下を実行
@WebServlet("/auth")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	//post送信の時、以下を実行
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//セッションがある場合、セッションを取得false を指定することで、
		//もしセッションが存在しない場合には新たにセッションを作成しない//
		HttpSession session = request.getSession(false);
		//セッションが存在する場合は破棄
		if (session != null) {
			session.invalidate();
		}

		//レスポンスの形式は、htmlのtext形式（文字コード:UTF-8）
		response.setContentType("text/html;charset=UTF-8");
		//文字出力用のストリームの取得	
		PrintWriter out = response.getWriter();

		//入力されたログインIDをセット
		String id = request.getParameter("loginID");
		//入力されたパスワードをセット
		String pw = request.getParameter("loginPw");

		// PostgreSQL DB接続情報
		String dbUrl = "jdbc:postgresql://localhost:5432/time_data";
		String dbUserName = "postgres";
		String dbPassword = "password";

		//connectionメソッドの宣言（DBとの接続するメソッド）
		Connection conn = null;
		//PreparedStatementオブジェクトの宣言、SQL文を宣言するオブジェクト
		PreparedStatement stmt = null;
		//検索結果のセット
		ResultSet rs = null;
		//try-catch構文で、jcbcドライバーの読み込みが成功しているか確認
		try {
			// JDBCドライバをロード
			Class.forName("org.postgresql.Driver");
			//ドライバの読み込み成功時
			out.println("JDBC Driver ロード成功！");
		} catch (ClassNotFoundException e) {
			//読み込み失敗時、読み込み失敗でエラーを受け取った時、
			e.printStackTrace();
			out.println("JDBC Driver が見つかりません！");
		}
		try {

			Class.forName("org.postgresql.Driver");

			//セッションを新規で作成
			session = request.getSession(true);
			request.setCharacterEncoding("UTF-8");
			//String name = request.getParameter("name");

			// DB接続
			conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);

			// SQL文の宣言
			String sql = "SELECT * FROM users WHERE loginId = ? AND loginPw = ?";
			//上記SQL分の準備
			stmt = conn.prepareStatement(sql);
			//SQL分の１つ目の？に入力したloginIDをセット
			stmt.setString(1, id);
			//SQL分の２つ目の？に入力したパスワードをセット
			stmt.setString(2, pw);
			//SQL分の実行
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