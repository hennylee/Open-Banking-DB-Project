package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.TransferDAO;
import kr.co.hn.vo.AccountVO;

public class OpenInquiryAccountController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String msg = "";
		HttpSession session = request.getSession();

		/*
				tgtbank : tgtbank,
				tgtaccount : tgtaccount,
				amount : amount,
				myaccount : myaccount,
				myname : myname,
				myaccountPw : myaccountPw
		 */
		
		String tgtbank = request.getParameter("tgtbank"); 
		String tgtaccount = request.getParameter("tgtaccount");
		String amount = request.getParameter("amount");
		String myaccount = request.getParameter("myaccount");
		String myname = request.getParameter("myname");
		
		
		// 1. 상대 계좌 주인 존재하는지 확인하기
		AccountVO vo = new AccountVO();
		vo.setAccount(tgtaccount);
		vo.setBankCode(tgtbank);
		
		TransferDAO dao = new TransferDAO();
		String holder = dao.inquiryHolder(vo);
		
		
		if(holder == "" || holder == null) {
			msg = "계좌번호 입력 오류입니다.";
		}
		else {
			msg = "예금주 : " + holder + "\n이체금액 : " + amount;
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("holder", holder);
			
		return "/openbank/transfer3.jsp";
	}


}
