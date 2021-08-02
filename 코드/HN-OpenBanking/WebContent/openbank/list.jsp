<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
					<!-- Table -->
					<header class="major">
						<h2>이체 내역</h2>
					</header>






					<div>
						<div class="table-wrapper" style="overflow-x: initial;">

							<table>
								<thead>
									<tr>
										<th style="width: 20%;">거래일자</th>
										<th style="width: 15%;">거래 대상</th>
										<th>거래액</th>
										<th>내 잔액</th>
										<th style="width: 10%;">거래 유형</th>
									</tr>
								</thead>
								<tbody>

									<c:if test="${empty list }">
										<tr>
											<td colspan="5" style="text-align: center;">거래 내역이 없습니다.</td>
										</tr>
									</c:if>


									<c:forEach items="${list }" var="trans">

										<tr>
											<td><c:out value="${trans.transDate }" /></td>
											<td><c:out value="${trans.targetName }" /></td>
											<td><fmt:formatNumber value="${trans.transAmount }" type="number"/>원</td>
											<td><fmt:formatNumber value="${trans.myBalance }" type="number"/>원</td>
											<td>
												<c:if test="${trans.transType eq '입금'}">
													<strong style="color: red;"><c:out value="${trans.transType }" /></strong>
												</c:if>
												<c:if test="${trans.transType eq '출금'}">
													<strong style="color: blue;"><c:out value="${trans.transType }" /></strong>
												</c:if>
											
											</td>
										</tr>


									</c:forEach>


								</tbody>
							</table>

						</div>

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