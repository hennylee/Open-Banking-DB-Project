package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.QNABoardDAO;
import kr.co.hn.vo.QNABoradVO;

public class QNADeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strNo = request.getParameter("no");
		int no = Integer.parseInt(strNo);
		String msg = "";
		String url = "";
		
		QNABoardDAO dao = new QNABoardDAO();
		
		if(!dao.existChild(no)) {
			dao.delete(no);
			url = "redirect:/qna/list.do";
		}
		else {
			msg = "답글이 달린 글은 삭제가 불가합니다.";
			url = "/qna/detail.do?no" + no;
		}
		
		request.setAttribute("msg", msg);
		return url;
	}

}
