package kr.co.hn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.dao.QNABoardDAO;
import kr.co.hn.util.PagingUtil;
import kr.co.hn.vo.QNABoradVO;

public class QNAListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QNABoardDAO dao = new QNABoardDAO();
		
		
		// 총 게시글 수
		int totalRow = dao.getTotalRowCnt();
		
		
		// 현재 페이지
		int curPage = 1;
		
		if(request.getParameter("page") != null) {
			curPage = Integer.parseInt(request.getParameter("page"));
		}
		
		PagingUtil util = new PagingUtil(totalRow, curPage);

		// 총 페이지 수
		int totalPage = util.getTotalPage();
		
		// 시작 글번호, 끝 글번호
		int startRow = util.getStartRow();
		int endRow = util.getEndRow();
		List<QNABoradVO> list = dao.selectAll(startRow, endRow);
		
		
		// 시작 페이지, 끝 페이지
		int startPage = util.getStartPage();
		int endPage = util.getEndPage();
		
		request.setAttribute("list", list);
		request.setAttribute("curPage", curPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		
		return "/qna/list.jsp";
	}

}