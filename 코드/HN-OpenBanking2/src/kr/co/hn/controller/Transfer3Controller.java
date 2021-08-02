package kr.co.hn.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.TransferDAO;
import kr.co.hn.vo.AccountVO;
import kr.co.hn.vo.TransactionVO;

public class Transfer3Controller implements Controller {
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String msg = "";
		String url = "";
		String jsp = "";
		
		String myAccount = request.getParameter("myNum");
		String myPassword = request.getParameter("myPw");
		String targetNum = request.getParameter("targetNum");
		String targetBank = request.getParameter("targetBank");
		String amount = request.getParameter("amount");
		String targetName = request.getParameter("targetName");
		
		// 내 계좌 비밀번호 확인
		AccountVO aVo = new AccountVO();
		aVo.setAccount(myAccount);
		aVo.setPassword(Integer.parseInt(myPassword));
		
		TransferDAO dao = new TransferDAO();
		int result = dao.checkPassword(aVo);
		
		
		// 비밀번호 일치
		if(result > 0) {
			TransactionVO tVo = new TransactionVO(); 
			// 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌
			tVo.setTargetAccount(targetNum);
			tVo.setTransAmount(Integer.parseInt(amount));
			tVo.setTargetBank(targetBank);
			tVo.setTargetName(targetName);
			tVo.setMyAccount(myAccount); 
			
			
			
			// 계좌 이체 성공
			if(dao.transfer(tVo)) {
				// 입금처, 출금처, 이체일시, 보낸금액
				jsp = "/transfer/result.do";
				request.setAttribute("tVo", tVo);
				// confirm모달창으로 이동 => 거래내역 안내 페이지로 이동
			}
			// 계좌 이체 실패
			else {
				msg = "이체에 실패하였습니다. ";
				url = request.getContextPath() + "/transfer1.do";
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
