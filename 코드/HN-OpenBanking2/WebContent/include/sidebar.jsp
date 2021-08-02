<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
				<!-- Sidebar -->
					<div id="sidebar">
						<div class="inner">

							<!-- Search -->
								<section id="search" class="alt">
									<form method="post" action="#">
										<input type="text" name="query" id="query" placeholder="Search" />
									</form>
								</section>

							<!-- Menu -->
								<nav id="menu">
									<header class="major">
										<h2>메뉴</h2>
									</header>
									<ul>
										<li>
											<span class="opener">계좌 관리</span>
											<ul>
												<li><a href="<%=request.getContextPath()%>/account/find.do">계좌 조회</a></li>
												<li><a href="<%=request.getContextPath()%>/transfer/transfer1.do">계좌이체</a></li>
												<li><a href="#">이체 결과 조회</a></li>
											</ul>
										</li>
										<li>
											<span class="opener">비대면계좌개설</span>
											<ul>
												<li><a href="<%= request.getContextPath()%>/account/open/open1.do">신청하기</a></li>
											</ul>
										</li>
										<li>
											<span class="opener">오픈뱅킹</span>
											<ul>
											<c:if test="${not empty openbanking}">
												<li><a href="<%= request.getContextPath()%>/openbank/search.do">오픈뱅킹 계좌조회</a></li>
												<li><a href="<%= request.getContextPath()%>/openbank/transfer.do">오픈뱅킹 계좌이체</a></li>
												<li><a href="#">오픈뱅킹 전용비밀번호 재등록</a></li>
												<li><a href="#">서비스 해지</a></li>
											</c:if>
											<c:if test="${empty openbanking}">
												<li><a href="<%= request.getContextPath()%>/openbank/register.do">서비스 등록</a></li>
											</c:if>
											</ul>
										</li>
										<li><a href="<%=request.getContextPath()%>/qna/list.do">Q & A</a></li>
										<li><a href="<%=request.getContextPath()%>/generic.html">회사 소개</a></li>
										<li><a href="<%=request.getContextPath()%>/elements.html">상품 소개</a></li>
										<li><a href="<%=request.getContextPath()%>/index.html">홈페이지</a></li>
										<li><a href="#">착오 송금 신고</a></li>
										<li><a href="#">나의 소비 분석</a></li>
									</ul>
								</nav>

							<!-- Section -->
								<section>
									<header class="major">
										<h2>카드 소개</h2>
									</header>
									<div class="mini-posts">
										<article>
											<a href="#" class="image"><img src="<%=request.getContextPath() %>/images/pic07.jpg" alt="" /></a>
											<p>쇼핑을 좋아하는 20대를 위한 HN 체크 카드</p>
										</article>
										<article>
											<a href="#" class="image"><img src="<%=request.getContextPath() %>/images/pic08.jpg" alt="" /></a>
											<p>규칙적인 소비를 하는 고객을 위한 맞춤 카드</p>
										</article>
										<article>
											<a href="#" class="image"><img src="<%=request.getContextPath() %>/images/pic09.jpg" alt="" /></a>
											<p>여행을 좋아하는 고객들을 위한 여행 제휴 카드</p>
										</article>
									</div>
									<ul class="actions">
										<li><a href="#" class="button">More</a></li>
									</ul>
								</section>

							<!-- Section -->
								<section>
									<header class="major">
										<h2>Get in touch</h2>
									</header>
									<p>Sed varius enim lorem ullamcorper dolore aliquam aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin sed aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									<ul class="contact">
										<li class="icon solid fa-envelope"><a href="#">information@untitled.tld</a></li>
										<li class="icon solid fa-phone">(000) 000-0000</li>
										<li class="icon solid fa-home">1234 Somewhere Road #8254<br />
										Nashville, TN 00000-0000</li>
									</ul>
								</section>

							<!-- Footer -->
								<footer id="footer">
									<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
								</footer>

						</div>
					</div>
