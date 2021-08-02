package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.LoginDAO;
import kr.co.hn.vo.MemberVO;

public class LoginProcessController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String id = "";
		String pw = "";
		String type = "";

		String url = "";
		String msg = "";
		
		// 로그인 중인지 확인
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		if(member == null) {
			id = request.getParameter("id");
			pw = request.getParameter("pw");
			type = request.getParameter("user-type");
		}
		else {
			id = member.getId();
			pw = member.getPassword();
			type = member.getType();
			session.removeAttribute("member");
		}
		
		MemberVO vo = new MemberVO();
		vo.setId(id);
		vo.setPassword(pw);
		vo.setType(type);
		
		// 로그인 처리
		LoginDAO dao = new LoginDAO();
		MemberVO user =  dao.login(vo);
		
		
		// 로그인 실패
		if(user == null) {
			msg = "로그인에 실패하였습니다";
			url = "/login.do";
		}
		// 로그인 성공
		else {
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			url = "redirect:/";
		}
		
		// 오픈뱅킹 등록 확인
		int result = dao.checkOpenBank(id);
		
		if(result > 0) {
			session.setAttribute("openbanking", "Y");
		}
		request.setAttribute("msg", msg);
		
		
		return url;
	}

}
