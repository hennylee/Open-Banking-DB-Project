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
<script type="text/javascript">
	
let balance // 내 잔액
let myaccount // 내 계좌
let myname = '${sessionScope.userName}' // 내이름
let mybank // 내 은행
let myaccountPw // 내 계좌 비밀번호

let tgtaccount // 상대계좌
let tgtholder // 상대 계좌주
let tgtbank // 보낼 은행

let amount // 보낼 금액

	function checkRegex(){
		let bCheck = false
		balance = $("input[name='select_account']:checked").val()
		myaccount = $("input[name='select_account']:checked").attr("id");
		mybank =  $("input[name='select_account']:checked").attr('mybank')
		
		// 비밀번호 검사
		if(!myaccount){
			bCheck = false
			$('#alert-modal-body-msg').text('1개 이상의 계좌를 체크하세요.')
			$('#alertModal').modal('show')
		}
		else if(balance <= 1000){
			bCheck = false
			$('#alert-modal-body-msg').text('잔액이 1000원 미만 시, 이체 불가합니다.')
			$('#alertModal').modal('show')
		}
		else{
			bCheck = true
		}
		return bCheck
	}

	function nextStep(){
		
		if(checkRegex()){
			
			$("input[name='select_account']").attr('disabled', true)
			$('#firstStepBtn').hide()
			
				$.ajax({
					url : "<%=request.getContextPath()%>/openbank/transfer2.do",
					type : "post",
					success : callback,
					error : function() {
						alert('error')
					}
				});
				
		}

	}
	
	function callback(result) {
		$('#ajaxTest').append(result)
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






				<section id="ajaxTest">
					<header class="major">
						<h2>계좌 이체</h2>
					</header>
					<h3 id="elements">1단계 : 출금 계좌 선택</h3>
					<p>출금하실 계좌를 선택해주세요</p>


					<hr class="major" />
					
					
					
					


					<!-- Section -->
					<section>
						<div class="row">
							<c:forEach items="${list }" var="account">
							<c:forEach items="${map }" var="bankCode">
								<c:if test="${account.bankCode eq bankCode.key }">
								<div class="col-4 col-12-medium">

									<div class="box">
										<p>
											<input type="radio" id="${account.account }"
												name="select_account" value="${account.balance }" mybank="${bankCode.key }"> 
											<label for="${account.account }"></label>
										</p>
										<h3>
											<fmt:formatNumber value="${account.balance }" type="Currency" />
											원
										</h3>
										<p>[${account.bankName }] ${account.account }</p>
										<p>${not empty account.alias? account.alias: "" }</p>
									</div>
								</div>
							</c:if>
							</c:forEach>
							</c:forEach>


							<c:if test="${empty list }">
								<article>
									<h3>존재하는 계좌가 없습니다.</h3>
									<article>
							</c:if>


						</div>
					</section>











					<div class="row">
						<c:if test="${not empty list }">
							<!-- Break -->
							<div class="col-12" style="text-align: right; margin-top: 2em">
								<input type="button" value="다음" class="button primary large"
									onclick="nextStep()" id="firstStepBtn" />
							</div>
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