<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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



					<div style="text-align: right;">
						<ul class="icons">

							<c:if test="${not empty user }">
								<li><a
									href="<%=request.getContextPath()%>/qna/insertForm.do"
									class="button small">새글등록</a></li>
							</c:if>
						</ul>
					</div>


					<div>
						<div class="table-wrapper" style="overflow-x: initial;">

							<table>
								<thead>
									<tr>
										<th style="width: 10%;">거래일자</th>
										<th style="width: 50%;">거래 대상</th>
										<th>거래액</th>
										<th>내 잔액</th>
										<th style="width: 10%;">거래 유형</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list }" var="trans">

										<tr>
											<td><c:out value="${trans.transDate }" /></td>
											<td><c:out value="${trans.targetName }" /></td>
											<td><c:out value="${trans.transAmount }" /></td>
											<td><c:out value="${trans.myBalance }" /></td>
											<td><c:out value="${trans.transType }" /></td>
										</tr>


									</c:forEach>

								</tbody>
							</table>

						</div>



						<ul class="pagination" style="float: none;">

							<c:choose>
								<c:when test="${ startPage le 5 }">
									<li><span class="button disabled">Prev</span></li>
								</c:when>
								<c:otherwise>
									<li><a href="<%=request.getContextPath() %>/qna/list.do?page=${ startPage - 5}" class="button">Prev</a></li>
								</c:otherwise>
							</c:choose>





							<c:forEach begin="${ startPage }" end="${ endPage }" var="i">
								<c:choose>
									<c:when test="${ curPage eq i }">
										<li><a
											href="<%=request.getContextPath() %>/qna/list.do?page=${i}"
											class="page active">${i }</a></li>
									</c:when>
									<c:otherwise>
										<li><a
											href="<%=request.getContextPath() %>/qna/list.do?page=${i}"
											class="page">${i }</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>




							<c:choose>
								<c:when test="${ endPage ge totalPage }">
									<li><span class="button disabled">Next</span></li>
								</c:when>
								<c:otherwise>
									<li><a href="<%=request.getContextPath() %>/qna/list.do?page=${ startPage + 5}" class="button">Next</a></li>
								</c:otherwise>
							</c:choose>
						
						
						</ul>









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