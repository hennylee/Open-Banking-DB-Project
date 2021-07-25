package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.MemberDAO;
import kr.co.hn.vo.MemberVO;

public class JoinController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		if(session != null) {
			session.removeAttribute("member");
		}
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String residentNum1 = request.getParameter("residentNum1");
		String residentNum2 = request.getParameter("residentNum2");
		String password = request.getParameter("password");
		String emailId = request.getParameter("emailId");
		
		
		String emailDomain = request.getParameter("emailDomain");
		
		/*
		<option value="0">@naver.com</option>
		<option value="1">@daum.net</option>
		<option value="2">@kakao.com</option>
		<option value="3">@google.com</option>
		 */
		
		String[] emailDomains = {"naver.com", "daum.net", "kakao.com", "google.com"};
		
		switch(emailDomain) {
		case "0":
			emailDomain = emailDomains[0];
					break;
		case "1":
			emailDomain = emailDomains[1];
			break;
		case "2":
			emailDomain = emailDomains[2];
			break;
		case "3":
			emailDomain = emailDomains[3];
			break;
		case "4":
			emailDomain = null;
			break;
		}
		
		String tel1 = request.getParameter("tel1");
		String tel2 = request.getParameter("tel2");
		String tel3 = request.getParameter("tel3");
		String post = request.getParameter("post");
		String basicAddr = request.getParameter("basicAddr");
		String detailAddr = request.getParameter("detailAddr");
		
		
		
		MemberVO vo = new MemberVO();
		vo.setId(id);
		vo.setName(name);
		vo.setResidentNum1(residentNum1);
		vo.setResidentNum2(residentNum2);
		vo.setPassword(password);
		vo.setEmailId(emailId);
		vo.setEmailDomain(emailDomain);
		vo.setTel1(tel1);
		vo.setTel2(tel2);
		vo.setTel3(tel3);
		vo.setPost(post);
		vo.setBasicAddr(basicAddr);
		vo.setDetailAddr(detailAddr);
		
		MemberDAO dao = new MemberDAO();
		int result = dao.join(vo);
		
		String msg = "";
		
		if(result > 0) {
			msg = "회원 가입이 완료되었습니다.";
		}
		else {
			msg = "회원 가입이 취소되었습니다.";
		}
		
		request.setAttribute("msg", msg);
		
		return "/";
	}

}
