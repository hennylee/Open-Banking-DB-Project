<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


							<!-- Header -->
								<header id="header">
									<a href="<%= request.getContextPath() %>/" class="logo"><img src="<%= request.getContextPath() %>/images/HN_logo.png" style="width: 60%"></a>
									
									<c:choose>
										<c:when test="${ empty sessionScope.userId }">
											<ul class="icons">
												<li><a href="<%= request.getContextPath() %>/login.do" class="button small">Login</a></li>
												<li><a href="<%= request.getContextPath() %>/joinForm.do" class="button small">Join</a></li>
											</ul>
										</c:when>
										<c:otherwise>
											<ul class="icons">
												<li>${sessionScope.userName } 님, 안녕하세요!</li>
												<li><a href="<%= request.getContextPath() %>/logout.do" class="button small">Logout</a></li>
											</ul>
										</c:otherwise>
									</c:choose>
								</header>

				
				
				
				
				