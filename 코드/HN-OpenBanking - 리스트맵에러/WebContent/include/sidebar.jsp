<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
												<li><a href="<%=request.getContextPath()%>/transfer1.do">계좌이체</a></li>
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
												<li><a href="<%= request.getContextPath()%>/open/register.do">서비스 등록</a></li>
												<li><a href="#">오픈뱅킹 조회</a></li>
												<li><a href="#">오픈뱅킹 이체</a></li>
												<li><a href="#">오픈뱅킹 이체내역조회</a></li>
												<li><a href="#">자금 하나로 모으기</a></li>
												<li><a href="#">계좌관리</a></li>
												<li><a href="#">오픈뱅킹 전용비밀번호 재등록</a></li>
												<li><a href="#">서비스 해지</a></li>
												<li><a href="<%=request.getContextPath()%>/openbank/registerForm.do">서비스 신청</a></li>
											</ul>
										</li>
										<li><a href="<%=request.getContextPath()%>/qna/list.do">Q & A</a></li>
										<li><a href="<%=request.getContextPath()%>/generic.html">회사 소개</a></li>
										<li><a href="<%=request.getContextPath()%>/elements.html">상품 소개</a></li>
										<li><a href="<%=request.getContextPath()%>/index.html">홈페이지</a></li>
										<li><a href="#">디자인 예시</a></li>
										<li><a href="#">나만의 색상 분석</a></li>
									</ul>
								</nav>

							<!-- Section -->
								<section>
									<header class="major">
										<h2>색상 소개</h2>
									</header>
									<div class="mini-posts">
										<article>
											<a href="#" class="image"><img src="<%=request.getContextPath() %>/images/pic07.jpg" alt="" /></a>
											<p>오늘의 쿨톤 의상 컨셉에 대해서 소개합니다.</p>
										</article>
										<article>
											<a href="#" class="image"><img src="<%=request.getContextPath() %>/images/pic08.jpg" alt="" /></a>
											<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
										</article>
										<article>
											<a href="#" class="image"><img src="<%=request.getContextPath() %>/images/pic09.jpg" alt="" /></a>
											<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
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
