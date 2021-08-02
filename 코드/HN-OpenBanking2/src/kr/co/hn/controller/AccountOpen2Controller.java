package kr.co.hn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.AccountDAO;
import kr.co.hn.vo.AccountTypeVO;
import kr.co.hn.vo.BankCodeVO;

public class AccountOpen2Controller implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AccountDAO dao = new AccountDAO();
		List<AccountTypeVO> aList = dao.getAccountTypeList();
		
		if(aList != null) {
			request.setAttribute("aList", aList);
		}
		
		return "/account/open/open2.jsp";
	}

}
