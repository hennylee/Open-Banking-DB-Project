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
		
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		String id = "";
		String pw = "";
		String type = "";
		
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
		
		LoginDAO dao = new LoginDAO();
		MemberVO user =  dao.login(vo);
		
		String url = "";
		String msg = "";
		
		// 로그인 실패
		if(user == null) {
			msg = "로그인에 실패하였습니다";
			url = "/login.do";
		}
		// 로그인 성공
		else {
			request.setAttribute("user", user);
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			url = "redirect:/";
		}
		
		request.setAttribute("msg", msg);
		
		
		return url;
	}

}
