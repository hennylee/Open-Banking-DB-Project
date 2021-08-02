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
<style>

/* Pagination */
ul.pagination  {
  text-align: center !important; 
  cursor: default !important;
  list-style: none !important;
  padding-left: 0 !important; }
  ul.pagination li {
    display: inline-block !important;
    padding-left: 0 !important;
    vertical-align: middle !important; }
    ul.pagination li > .page {
      -moz-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out !important;
      -webkit-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out !important;
      -ms-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out !important;
      transition: background-color 0.2s ease-in-out , color 0.2s ease-in-out !important;
      border-bottom: 0 !important;
      border-radius: 0.375em !important;
      display: inline-block !important;
      font-size: 0.8em !important;
      font-weight: 600 !important;
      height: 2em !important;
      line-height: 2em !important;
      margin: 0 0.125em !important;
      min-width: 2em !important;
      padding: 0 0.5em !important;
      text-align: center !important; 
      color: #f56a6a !important;
      }
      ul.pagination li > .page.active {
        background-color: #f56a6a !important;
        color: #ffffff !important; }
        ul.pagination li > .page.active:hover {
          background-color: #f67878 !important; }
        ul.pagination li > .page.active:active {
          background-color: #f45c5c !important; }
    ul.pagination li:first-child {
      padding-right: 0.75em !important; }
    ul.pagination li:last-child {
      padding-left: 0.75em !important; }
  @media screen and (max-width: 480px) {
    ul.pagination li:nth-child(n+2):nth-last-child(n+2) {
      display: none !important; }
    ul.pagination li:first-child {
      padding-right: 0 !important; } }

</style>
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
						<h2>Q & A</h2>
					</header>



					<div style="text-align: right;">
						<ul class="icons">

							<c:if test="${not empty userId }">
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
										<th style="width: 10%;">글번호</th>
										<th style="width: 50%;">글제목</th>
										<th>글쓴이</th>
										<th>등록일</th>
										<th style="width: 10%;">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list }" var="qna">

										<tr>
											<td><c:out value="${qna.no }" /></td>
											<td><c:if test="${qna.type eq 'A' }">
													<c:forEach begin="0" end="${qna.groupDepth - 1}" var="i">
													&nbsp;&nbsp;
												</c:forEach>
													<img
														src="<%=request.getContextPath()%>/images/reply_icon.png"
														width="13px">
												</c:if> <a
												href="<%=request.getContextPath()%>/qna/detail.do?no=${qna.no }&type=list">
													<c:out value="${qna.subject }" />
											</a></td>
											<td><c:out value="${qna.writer }" /></td>
											<td><c:out value="${qna.regdate }" /></td>
											<td><c:out value="${qna.viewCnt }" /></td>
										</tr>


									</c:forEach>

								</tbody>
							</table>

						</div>


						<div style="text-align: center">
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