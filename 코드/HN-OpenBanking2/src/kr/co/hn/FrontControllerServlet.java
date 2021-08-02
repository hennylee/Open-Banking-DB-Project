package kr.co.hn;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hn.controller.Controller;
import kr.co.hn.controller.HandlerMapping;

public class FrontControllerServlet extends HttpServlet {
	private HandlerMapping mappings;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		// bean.properties 위치를 초기화
		String propLoc = config.getInitParameter("propertyLocation");
				
		if(propLoc != null)
			mappings = new HandlerMapping(propLoc);
		else
			mappings = new HandlerMapping();
	}
	
	
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uri = request.getRequestURI(); // 클라이언트가 요청한 uri (../*.do 패턴 형식)
		String context = request.getContextPath(); // 프로젝트명
		uri = uri.substring(context.length());
		System.out.println("uri : " + uri);
		
		try {
			
			Controller control = mappings.getController(uri);
			
			String callPage = control.handleRequest(request, response);
			
			System.out.println("callPage : " + callPage);
			System.out.println("----------------------------------------------");
			
			if(callPage.startsWith("redirect:")) {
				callPage = callPage.substring("redirect:".length());
				response.sendRedirect(request.getContextPath() + callPage);
				
			} 
			else if(callPage.startsWith("sendRedirect:")) {
				callPage = callPage.substring("sendRedirect:".length());
				response.sendRedirect(callPage);
			}
			else {
				
				RequestDispatcher dispatcher = request.getRequestDispatcher(callPage);
				dispatcher.forward(request, response);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException();
		}
		
	}

	
	
	
	
}
