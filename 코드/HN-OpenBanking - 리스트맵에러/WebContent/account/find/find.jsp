<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<jsp:include page="/include/head.jsp" />
<script type="text/javascript">
	
	function checkRegex(){
		let bCheck = false

		let alias = $('#alias').val();
		let password = $('#password').val();
		
		let alias_regex = /^[가-힣]{1,10}/
		let pw_regex = /^[0-9]{4}$/
		
		// 비밀번호 검사
		if(!pw_regex.test(password)){
			bCheck = false
			$('#alert-modal-body-msg').text('비밀번호는 숫자 4자리로 입력해주세요.')
			$('#alertModal').modal('show')
		}
		// 계좌 별칭 검사
		else if(!alias_regex.test(alias)){
			bCheck = false
			$('#alert-modal-body-msg').text('별칭은 10글자 이내의 한글로 입력해주세요.')
			$('#alertModal').modal('show')
		}
		else{
			bCheck = true
		}
		return bCheck
	}

	function nextStep(){
		
		
		let url = ""

		let typeCode = $("select[name='account_type'] option:selected").val();
		let alias = $('#alias').val();
		let password = $('#password').val();
		
		if(checkRegex()){
			
			$.ajax({
				url : "<%=request.getContextPath()%>/account/open/step2.do",
				data : {
					typeCode : typeCode,
					alias : alias,
					password : password
				},
				type : "post",
				success : callback,
				error : function() {
					alert('error')
				}
			});

		}

	}

	function callback(result) {
		$('#modal-after-section').html(result)
		$('#myModal').modal("show")
	}

</script>

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
									
										<article>
											<p>[${account.typeVO.type }] ${account.account }</p>
											<h3><fmt:formatNumber value="${account.balance }" type="Currency"/> 원</h3>
											<p>${not empty account.alias? account.alias: "" }</p>
											<ul class="actions" style="place-content: baseline">
												<li><a href="<%=request.getContextPath() %>/transfer/search.do?acc=${account.account }" class="button fit">상세보기</a></li>
											</ul>
										</article>
										
									</c:forEach>
									<c:if test="${fn:length(list) % 2 ne 0}">
										<article>
											<h3>&nbsp;</h3>
											<p>&nbsp;</p>
											<ul class="actions">
											</ul>
										</article>
									</c:if>
									<c:if test="${empty list }">
									<article>
										<h3>존재하는 계좌가 없습니다.</h3>
										<article>
									</c:if>
										
									</div>
								</section>
					
					
					
					
					
					



				<div id="modal-after-section"></div>



				<!-- Modal -->
				<div id="alertModal" class="modal fade" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close button modalClose"
									data-dismiss="modal" style="box-shadow: none;">&times;</button>
								<h4 class="modal-title">알림</h4>
							</div>
							<div class="modal-body">
								<p id="alert-modal-body-msg"></p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn button primary"
									data-dismiss="modal">닫기</button>
							</div>
						</div>

					</div>
				</div>




			</div>
		</div>

		<!-- Sidebar -->
		<jsp:include page="/include/sidebar.jsp" />

	</div>

	<!-- Scripts -->
	<jsp:include page="/include/script.jsp" />
</body>
</html>