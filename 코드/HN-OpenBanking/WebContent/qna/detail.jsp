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


<!-- modal -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/main.css" />
	<script>
	$( document ).ready(function() {
		$('#modalTrigger').hide();
		  
		if( '${msg}'){
		 	$('#modalTrigger').trigger("click");
// 			$('#myModal').modal('show')
		}
	});
	</script>

<body class="is-preload">


<!-- 로그인 실패 모달-->
<!-- Trigger the modal with a button -->
	<button id="modalTrigger" type="button" class="button primary" data-toggle="modal" data-target="#myModal">안내</button>


<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close button modalClose" data-dismiss="modal" style="height: 30px">&ensp;&times;&ensp;</button>
        <h4 class="modal-title">안내</h4>
      </div>
      <div class="modal-body">
        <p>${msg }</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn button primary" data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
</div>




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
							<c:if test="${not empty user and user.id ne vo.writer}">
								<li><a href="<%=request.getContextPath()%>/qna/answerForm.do?no=${vo.no}"
									class="button small">답글</a></li>
							</c:if>

							<c:if test="${user.id eq vo.writer}">
								<li><a href="<%=request.getContextPath()%>/qna/updateForm.do?no=${vo.no}"
									class="button small">수정</a></li>
								<li><a href="<%=request.getContextPath()%>/qna/delete.do?no=${vo.no}"
									class="button small">삭제</a></li>
							</c:if>
							<li><a href="<%=request.getContextPath()%>/qna/list.do"
								class="button small">목록</a></li>
						</ul>
					</div>


					<div class="box">

						<h2>
							<c:out value="${vo.subject }" />
						</h2>


						<ul class="icons" style="font-size: 11px;text-align: right">
							<li>작성자 : <c:out value="${vo.writer }" /></li>
							<li>작성일 : <c:out value="${vo.regdate }" /></li>
							<li>조회수 : <c:out value="${vo.viewCnt }" /></li>
						</ul>




						<hr class="major" style="margin-top: 0px;" />
						<p>
							<c:out value="${vo.content }" />
						</p>
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