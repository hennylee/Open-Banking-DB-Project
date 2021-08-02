package kr.co.hn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.QNABoardDAO;
import kr.co.hn.vo.MemberVO;
import kr.co.hn.vo.QNABoradVO;

public class QNAInsertController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("userId");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		QNABoradVO vo = new QNABoradVO();
		vo.setWriter(writer);
		vo.setSubject(subject);
		vo.setContent(content);
		
		QNABoardDAO dao = new QNABoardDAO();
		int result = dao.insertQ(vo);
		String url = "";
		
		if(result != -1) {
			url = "redirect:/qna/list.do";
		}
		
		return url;
	}

}
