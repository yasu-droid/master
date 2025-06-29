package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginModel {

    public void checkLogin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);  // 既存のセッションを取得（なければ null）
        if (session != null) {
            String loginId = (String) session.getAttribute("loginid");
            System.out.println("ログインID: " + loginId);
        } else {
            System.out.println("セッションがありません。");
        }
    }
}
