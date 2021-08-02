package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.AccountDAO;
import kr.co.hn.util.CreateAcntNum;
import kr.co.hn.vo.AccountVO;

public class AccountOpenStep2Controller implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		String msg = "";
		String url = "";

		String typeCode = request.getParameter("typeCode");
		String alias = request.getParameter("alias");
		String password = request.getParameter("password");

		// 계좌번호 생성
		String[] typeSeq = { "seq_hn_acnt_mid_1", "seq_hn_acnt_mid_2", "seq_hn_acnt_mid_3", "seq_hn_acnt_mid_4" };

		String seqName = typeSeq[Integer.parseInt(typeCode)];
		String account = new CreateAcntNum().totalNum(seqName);

		AccountVO vo = new AccountVO();
		vo.setAccount(account);
		vo.setMemberID((String) session.getAttribute("userId"));
		vo.setTypeCode(typeCode);
		vo.setAlias(alias);
		vo.setPassword(Integer.parseInt(password));
		
		
		AccountDAO dao = new AccountDAO();
		int result = dao.opening(vo);

		if (result < 1) {
			msg = "계좌 개설에 실패하였습니다.";
			url = request.getContextPath() + "/account/open/open2.do";
		} else {
			msg = "계좌 개설이 완료되었습니다.";
			url = request.getContextPath() + "/account/open/open1.do";
		}

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);

		return "/include/modalConfirm.jsp";
	}

}
