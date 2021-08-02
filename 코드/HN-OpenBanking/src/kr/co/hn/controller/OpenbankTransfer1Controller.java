package kr.co.hn.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hn.dao.AccountDAO;
import kr.co.hn.dao.MemberDAO;
import kr.co.hn.dao.OpenbankDAO;
import kr.co.hn.vo.AccountVO;

public class OpenbankTransfer1Controller implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		AccountVO vo = new AccountVO();
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		
		
		// 회원 전화번호 검색
		MemberDAO mDao = new MemberDAO();
		String tel = mDao.searchMyTel(id);
		
		// 회원 전화번호로 검색		
		OpenbankDAO oDao = new OpenbankDAO();
		List<AccountVO> list = oDao.searchBytel(tel);

		AccountDAO aDao = new AccountDAO();
		Map<String, String> map = aDao.getBankMap();
		
		for(AccountVO a : list) {
			a.setbankName(map.get(a.getBankCode()));
		}
		
		request.setAttribute("list", list);
		request.setAttribute("map", map);
		
		
		return "/openbank/transfer1.jsp";
	}

}
