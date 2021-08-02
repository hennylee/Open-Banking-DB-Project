package kr.co.hn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.OpenbankDAO;
import kr.co.hn.dao.TransferDAO;
import kr.co.hn.vo.TransactionVO;

public class OpenbankListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String openAccount = request.getParameter("acc");
		String bankCode = request.getParameter("code");
		
		OpenbankDAO dao = new OpenbankDAO();
		List<TransactionVO> list = dao.selectAll(openAccount, bankCode);
		request.setAttribute("list", list);
		
		return "/openbank/list.jsp";
	}

}
