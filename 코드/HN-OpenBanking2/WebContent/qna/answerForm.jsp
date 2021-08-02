<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<jsp:include page="/include/head.jsp"/>
	
	
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<jsp:include page="/include/header.jsp"/>






				<section>
					<!-- Table -->
					<header class="major">
						<h2>새글 작성</h2>
					</header>
				
				
				<form method="post" action="<%= request.getContextPath() %>/qna/answer.do?no=${ no }">
					<div class="row gtr-uniform">
					
					<!-- Break -->
						<div class="col-8 col-12-small">
							<select name="demo-category" id="demo-category">
								<option value="">게시판을 선택해주세요</option>
								<option value="1">Q & A</option>
							</select>
						</div>
						<div class="col-4 col-12-small">
							<select name="demo-category" id="demo-category">
								<option value="">말머리를 선택해주세요 </option>
								<option value="1">질문</option>
								<option value="1">답변</option>
							</select>
						</div>
					
					
					<!-- Break -->
						<div class="col-12">
							<input type="text" name="subject" id="demo-name" value="" placeholder="제목을 입력해주세요" />
						</div>
						
						<!-- Break -->
						<div class="col-12">
							<textarea name="content" id="demo-message" placeholder="내용을 입력해주세요" rows="15"></textarea>
						</div>
						
						
						
						<!-- Break -->
						<div class="col-12">
							<ul class="actions">
								<li><input type="submit" value="등록" class="primary" /></li>
								<li><input type="reset" value="초기화" /></li>
							</ul>
						</div>
					</div>
				</form>

				
				</section>
				
				
				
				
				
				

						</div>
					</div>

				<!-- Sidebar -->
					<jsp:include page="/include/sidebar.jsp"/>

			</div>

		<!-- Scripts -->
			<jsp:include page="/include/script.jsp"/>
	</body>
</html>