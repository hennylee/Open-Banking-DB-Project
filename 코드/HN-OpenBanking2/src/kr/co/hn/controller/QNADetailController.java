package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.QNABoardDAO;
import kr.co.hn.vo.QNABoradVO;

public class QNADetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		QNABoardDAO dao = new QNABoardDAO();

		int no = Integer.parseInt(request.getParameter("no"));
		
		String type = request.getParameter("type");
		
		// 조회수 증가
		if(type != null) {
			dao.incrementViewCnt(no);
		}
		
		// 게시물 조회
		QNABoradVO vo = dao.selectByNo(no);
		
		
		request.setAttribute("vo", vo);
		
		return "/qna/detail.jsp";
	}

}
