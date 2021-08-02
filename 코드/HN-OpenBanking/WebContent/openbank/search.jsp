<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<jsp:include page="/include/head.jsp" />


<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<jsp:include page="/include/header.jsp" />




				<section>
					<header class="major">
						<h2>전체 계좌 조회</h2>
					</header>



					<!-- Section -->
					<section>
						<div class="posts">

							<c:forEach items="${list }" var="account">
								<c:forEach items="${map }" var="bankCode">
									<c:if test="${account.bankCode eq bankCode.key }">
										<article>
											<p>[${account.bankName }] ${account.account }</p>
											<h3>
												<fmt:formatNumber value="${account.balance }"
													type="Currency" />
												원
											</h3>
											<p>${account.typeCode }</p>
											<ul class="actions" style="place-content: baseline">
												<li><a
													href="<%=request.getContextPath() %>/openbank/list.do?acc=${account.account }&code=${ bankCode.key}"
													class="button fit">상세보기</a></li>
											</ul>
										</article>
									</c:if>
								</c:forEach>
							</c:forEach>
							<c:if test="${fn:length(list) % 3 ne 0}">
								<c:forEach begin="0" end="${fn:length(list) % 3}">
									<article>
										<h3>&nbsp;</h3>
										<p>&nbsp;</p>
										<ul class="actions">
										</ul>
									</article>
								</c:forEach>
							</c:if>
							<c:if test="${empty list }">
								<article>
									<h3>존재하는 계좌가 없습니다.</h3>
								</article>
							</c:if>


						</div>
					</section>
			</div>
		</div>

		<!-- Sidebar -->
		<jsp:include page="/include/sidebar.jsp" />

	</div>

	<!-- Scripts -->
	<jsp:include page="/include/script.jsp" />
</body>
</html>