package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.QNABoardDAO;
import kr.co.hn.vo.QNABoradVO;

public class QNAUpdateController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String strNo = request.getParameter("no");
		int no = Integer.parseInt(strNo);
		
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		QNABoardDAO dao = new QNABoardDAO();
		QNABoradVO vo = new QNABoradVO();
		
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setNo(no);
		
		dao.update(vo);
		
		
		return "redirect:/qna/detail.do?no=" + no;
	}

}
