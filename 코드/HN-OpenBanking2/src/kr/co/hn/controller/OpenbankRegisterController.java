package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import kr.co.hn.dao.OpenbankDAO;
import kr.co.hn.util.ShaPasswordEncoder;
import kr.co.hn.vo.OpenResigterVO;

public class OpenbankRegisterController implements Controller{

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String msg = "";
		String url = request.getContextPath();
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		String password = request.getParameter("password");
		
		if(id != null && password != null) {
			password = new ShaPasswordEncoder().passwordEncode(password);
		}
		
		OpenResigterVO vo = new OpenResigterVO();
		vo.setMemberId(id);
		vo.setPassword(password);
		
		OpenbankDAO dao = new OpenbankDAO();
		int result = dao.register(vo);
		
		if(result > 0) {
			msg = "서비스 신청이 완료되었습니다";
		}
		else {
			msg = "신청이 실패되었습니다.";
		}
		
		System.out.println(msg);
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url );
		
		return "/openbank/registerResult.jsp";
	}
	
	
}
