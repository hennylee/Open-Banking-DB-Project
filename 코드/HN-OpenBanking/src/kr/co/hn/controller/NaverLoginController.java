package kr.co.hn.controller;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


// api명세 : https://developers.naver.com/docs/login/api/api.md
// 코드 출처 : https://devtansan-s-tocking.tistory.com/16

public class NaverLoginController implements Controller{

	public final static String CLIENT_ID = "h5b3O54T4arCVZ7EKFSR";
	public final static String CLIENT_SECRET = "itSPnyhzQ6";
	public final static String CALLBACK_URL = "http://localhost:9999/HN-OpenBanking/auth/naver/callback.do";
	
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String clientId = CLIENT_ID;//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode(CALLBACK_URL, "UTF-8");
	    
	    
	    // CSRF 방지를 위한 상태 토큰 생성 코드
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    
	    // 상태 토큰은 추후 검증을 위해 세션에 저장되어야 한다.
	    session.setAttribute("state", state);
		
	    System.out.println("apiURL : " + apiURL);
	    
		return "sendRedirect:" + apiURL;
	}

}
