package kr.co.hn.controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import kr.co.hn.vo.PolicyVO;

public class OpenbankRegisterFormController implements Controller{

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String line = "";
		String directoy = "C:\\kopo\\kopo-05-web\\code\\HN-OpenBanking\\WebContent\\policy\\";		
		
		List<PolicyVO> list = new ArrayList<PolicyVO>();
		
		String[] fileNames = {"information", "personal" , "service", "transaction"};
		String[] policyNames = {"오픈뱅킹 서비스 이용약관", "오픈뱅킹공동업무 금융정보조회 약관", "금융거래정보 제공동의", "개인(신용)정보수집/이용/제공 동의"};
		
		// 약관 파일 내용 불러오기
		for (int i = 0; i < fileNames.length; i ++) {
			String text = "";
			FileReader fr = new FileReader(directoy + fileNames[i] + ".txt");
			BufferedReader br = new BufferedReader(fr);
			
			while((line = br.readLine()) != null) {
				text += line + "\n";
			}
			
			// vo변수에 담아주기
			PolicyVO vo = new PolicyVO();
			vo.setName(fileNames[i]);
			vo.setTitle(policyNames[i]);
			vo.setContent(text);
			
			list.add(vo);
		}
		
		request.setAttribute("list", list);
		
		return "/openbank/registerForm.jsp";
	}
	
}
