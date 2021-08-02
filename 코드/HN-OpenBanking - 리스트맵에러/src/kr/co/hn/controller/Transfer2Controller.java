package kr.co.hn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.AccountDAO;
import kr.co.hn.vo.BankCodeVO;

public class Transfer2Controller implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 은행 코드 리스트 불러오기
		AccountDAO dao = new AccountDAO();
		List<BankCodeVO> bList = dao.getBankList();
		
		if(bList != null) {
			request.setAttribute("bList", bList);
		}
		
		
		
		
		return "/transfer/transfer2-2.jsp";
	}

}
