package kr.co.hn.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.OpenbankDAO;
import kr.co.hn.dao.TransferDAO;
import kr.co.hn.vo.AccountVO;
import kr.co.hn.vo.TransactionVO;

public class OpenbankTransfer3Controller implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		String msg = "";
		String url = "";
		String jsp = "";
		
		String tgtbank = request.getParameter("tgtbank");
		String tgtaccount = request.getParameter("tgtaccount");
		String amount = request.getParameter("amount");
		String tgtholder = request.getParameter("tgtholder");
		String myaccount = request.getParameter("myaccount");
		String myname = request.getParameter("myname");
		String mybank = request.getParameter("mybank");
		
		String myaccountPw = request.getParameter("myaccountPw");
		String myId = (String) session.getAttribute("userId");
		
		
		// 내 계좌 비밀번호 확인
		OpenbankDAO dao = new OpenbankDAO();
		int result = dao.checkPassword(myId, myaccountPw);
		
		// 비밀번호 일치
		if(result > 0) {
			TransactionVO tVo = new TransactionVO(); 
			
			tVo.setTargetAccount(tgtaccount);
			tVo.setTransAmount(Integer.parseInt(amount));
			tVo.setTargetBank(tgtbank);
			tVo.setTargetName(tgtholder);
			tVo.setMyAccount(myaccount); 
			tVo.setMyBank(mybank); 
			tVo.setMyName(myname); 
			
			
			boolean bCheck = dao.transfer(tVo);
			
			System.out.println("bCheck : " + bCheck);
			
			// 계좌 이체 성공
			if(bCheck) {
				// 입금처, 출금처, 이체일시, 보낸금액
				jsp = "/openbank/result.do";
				request.setAttribute("tVo", tVo);
				// confirm모달창으로 이동 => 거래내역 안내 페이지로 이동
			}
			// 계좌 이체 실패
			else {
				msg = "이체에 실패하였습니다. ";
				url = request.getContextPath() + "/openbank/transfer.do";
				jsp = "/include/modalConfirm.jsp";
				// confirm모달창으로 이동 => 계좌이체 첫 페이지로 이동
			}
			
		}
		// 비밀번호 불일치
		else {
			msg = "비밀번호가 일치하지 않습니다. ";
			jsp = "/include/modalAlert.jsp";
			// alert모달창으로 이동
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return jsp;
	}

}
