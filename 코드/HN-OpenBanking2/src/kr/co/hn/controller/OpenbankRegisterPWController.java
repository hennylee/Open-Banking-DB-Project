package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.OpenbankDAO;

public class OpenbankRegisterPWController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		String password = request.getParameter("password");
		
		System.out.println(password);
		
		OpenbankDAO dao = new OpenbankDAO();
		int result = dao.register(id, password);
		
		if(result < 1) {
			request.setAttribute("msg", "등록에 실패하였습니다.");
			request.setAttribute("url", request.getContextPath() + "/openbank/register.do");
		}
		else {
			request.setAttribute("msg", "등록이 완료되었습니다.");
			request.setAttribute("url", request.getContextPath());
		}
		
		return "/include/modalConfirm.jsp";
	}

}
