package kr.co.hn.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class HandlerMapping {
	
	// 멤버변수
	private Map<String, Controller> mappings;

	// 생성자
	public HandlerMapping() {
		this("C:\\kopo\\Open-Banking-DB-Project\\코드\\HN-OpenBanking\\bean.properties"); // propLoc
	}

	public HandlerMapping(String propLoc) {
		
		// bean.properties 파일에서 등록된 controller 불러오기
		mappings = new HashMap<String, Controller>();
		Properties prop = new Properties();
		
		try {
			InputStream is = new FileInputStream(propLoc);
			prop.load(is); // load : properties 확장자 파일 내용 불러오는 메소드
			
			Set<Object> keys = prop.keySet(); // properties key 내용을 Set으로 받기
			// properties의 value를 인스턴스화해서 매핑하기
			for(Object key : keys) {
				String className = prop.getProperty(key.toString());
				Class<?> clz = Class.forName(className);
				mappings.put(key.toString(), (Controller)clz.newInstance());

			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public Controller getController(String uri) {
		return mappings.get(uri);
	}
	
	
	
	
	
	

}
