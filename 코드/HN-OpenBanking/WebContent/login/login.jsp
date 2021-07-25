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


<script>
	$(document).ready(function() {
		if ('${msg}') {
			$('#myModal').modal("show")
		}
	});
</script>

<body class="is-preload">

	<!-- Modal -->
	<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close button modalClose"
						data-dismiss="modal" style="box-shadow: none;">&times;</button>
					<h4 class="modal-title">로그인 결과</h4>
				</div>
				<div class="modal-body">
					<p>${msg }</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn button primary"
						data-dismiss="modal">닫기</button>
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



				<!-- Login -->

				<section>
					<header class="major">
						<h2>로그인</h2>
					</header>

					<!-- Lists -->
					<div class="row">
						<div class="col-6 col-12-small">

							<h3>다른 서비스로 로그인</h3>
							<a href="http://localhost:9999/HN-OpenBanking/auth/naver.do"
								onclick="window.open(this.href, '_blank', 'width=500px,height=800px,toolbars=no,scrollbars=no'); return false;">
								<img src="images/naver_login.png" style="width: 50%">
							</a> <br> <a href="#"><img src="images/naver_login.png"
								style="width: 50%"></a> <br>




						</div>
						<div class="col-6 col-12-small">

							<h3>일반 로그인</h3>
							<form method="post"
								action="<%=request.getContextPath()%>/loginProcess.do">
								<div class="row gtr-uniform">

									<div class="col-6 col-12-small">
										<input type="radio" id="user-type-u" name="user-type"
											value="U" checked> <label for="user-type-u">일반회원</label>
									</div>
									<div class="col-6 col-12-small">
										<input type="radio" id="user-type-s" name="user-type"
											value="S"> <label for="user-type-s">관리자</label>
									</div>

									<!-- Break -->
									<div class="col-12">
										<ul class="actions stacked">
											<li><input type="text" name="id" id="id" value=""
												placeholder="Id" /></li>
											<li><input type="password" name="pw" id="pw" value=""
												placeholder="Password" /></li>
										</ul>
									</div>


									<!-- Break -->
									<div class="col-12">
										<ul class="actions stacked">
											<li><input type="submit" value="Login"
												class="button primary fit" /></li>
										</ul>
									</div>
								</div>
							</form>


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