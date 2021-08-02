package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.QNABoardDAO;
import kr.co.hn.vo.QNABoradVO;

public class QNAUpdateFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String strNo = request.getParameter("no");
		
		int no = Integer.parseInt(strNo);
		
		QNABoardDAO dao = new QNABoardDAO();
		QNABoradVO vo = dao.selectByNo(no);
		
		request.setAttribute("no", no);
		request.setAttribute("subject", vo.getSubject());
		request.setAttribute("content", vo.getContent());
		
		return "/qna/updateForm.jsp";
	}

}
