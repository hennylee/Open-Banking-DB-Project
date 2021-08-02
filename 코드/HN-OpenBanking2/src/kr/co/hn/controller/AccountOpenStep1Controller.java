package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.AccountDAO;
import kr.co.hn.dao.MemberDAO;
import kr.co.hn.vo.MemberVO;

public class AccountOpenStep1Controller implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String msg = "";
		String url = "";
		
		String residentNum1 = request.getParameter("residentNum1");
		String residentNum2 = request.getParameter("residentNum2");
		String tel1 = request.getParameter("tel1");
		String tel2 = request.getParameter("tel2");
		String tel3 = request.getParameter("tel3");
		
		MemberVO vo = new MemberVO();
		vo.setId((String)session.getAttribute("userId"));
		vo.setResidentNum1(residentNum1);
		vo.setResidentNum2(residentNum2);
		vo.setTel1(tel1);
		vo.setTel2(tel2);
		vo.setTel3(tel3);
		
		MemberDAO mDao = new MemberDAO();
		int authResult = mDao.selfAuth(vo);
		
		AccountDAO aDao = new AccountDAO();
		String possibleDate = aDao.checkOpeningDate(vo);
		
		System.out.println("possibleDate : " +possibleDate);
		
		if(authResult < 1) {
			msg = "개인정보가 일치하지 않습니다.";
			url = request.getContextPath() + "/account/open/open1.do";
		}
		else if(possibleDate == null) {
			msg = "다음 단계를 진행해주세요.";
			url = request.getContextPath() + "/account/open/open2.do";
		}
		else {
			msg = "한달 내 계좌 개설 건이 있습니다. " + possibleDate + "까지 계좌 개설이 제한됩니다.";
			url = request.getContextPath() + "/account/open/open1.do";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return "/include/modalConfirm.jsp";
	}

}
