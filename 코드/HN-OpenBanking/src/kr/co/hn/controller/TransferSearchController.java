package kr.co.hn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.TransferDAO;
import kr.co.hn.vo.TransactionVO;

public class TransferSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String myAccount = request.getParameter("acc");
		
		TransferDAO dao = new TransferDAO();
		List<TransactionVO> list = dao.selectAll(myAccount);
		request.setAttribute("list", list);
		
		return "/transfer/search.jsp";
	}

}
