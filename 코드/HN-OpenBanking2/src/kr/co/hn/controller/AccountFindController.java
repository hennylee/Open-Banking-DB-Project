package kr.co.hn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.AccountDAO;
import kr.co.hn.vo.AccountVO;

public class AccountFindController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AccountVO vo = new AccountVO();
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("userId");
		
		AccountDAO dao = new AccountDAO();
		List<AccountVO> list = dao.findById(memberId);
		
		request.setAttribute("list", list);
		
		return "/account/find/find.jsp";
	}

}