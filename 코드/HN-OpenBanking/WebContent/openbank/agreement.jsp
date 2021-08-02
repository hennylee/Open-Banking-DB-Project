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

/* String[] fileNames = {"information", "personal" , "service", "transaction"}; */


function checkRegex(){
		let bCheck = true

		let information = $('#information')[0]
		let personal = $('#personal')[0]
		let service = $('#service')[0]
		let transaction = $('#transaction')[0]
		
		// 정보 동의 체크 안했다면?
		if(!information.checked || !personal.checked  || !service.checked || !transaction.checked ){
			bCheck = false
			
			$.get("<%=request.getContextPath()%>/include/modalAlert.jsp", function(data){
				$('#modal-alert-section').html(data)
				$('#alert-modal-body-msg').text('필수 동의 항목을 체크하세요.')
				$('#alertModal').modal("show")
			})
			
		}
		
		return bCheck
	}

	function nextStep(){
		
		if(checkRegex()){
			
			$.ajax({
				url : "<%=request.getContextPath()%>/openbank/register/pw.do",
				success : callback,
				error : function() {
					alert('error')
				}
			});

		}

	}

	function callback(result) {
		alert('성공')
// 		$('#modal-after-section').html(result)
// 		$('#myModal').modal("show")
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
					<!-- Table -->
					<header class="major">
						<h2>오픈뱅킹 신청</h2>
					</header>

					<h3 id="elements">1단계 : 본인 조회</h3>
					<p>오픈뱅킹 서비스 신청을 위해선 정보 동의가 필요합니다.</p>


					<hr class="major" />

					<div class="row gtr-uniform">
					<!-- 
						<c:forEach items="${list }" var="policy">
							
							<div class="col-12">
								<h4>${policy.title }</h4>
								<textarea name="" id="" rows="10" readonly="readonly"
									style="resize: none;">
									${policy.content }
       							</textarea>
							</div>
							<div class="col-12" style="text-align: right">
								<input type="checkbox" id="${policy.name }"
									name="${policy.name }" required> <label
									for="${policy.name }">(필수) 동의합니다.</label>
							</div>
						</c:forEach>
 -->
 
 
 

							
							<div class="col-12">
								<h4>${policy.key }</h4>
								<textarea name="" id="" rows="10" readonly="readonly"
									style="resize: none;">
									${policy.content }
       							</textarea>
							</div>
							<div class="col-12" style="text-align: right">
								<input type="checkbox" id="${policy.name }"
									name="${policy.name }" required> <label
									for="${policy.name }">(필수) 동의합니다.</label>
							</div>
 
 
 

						<!-- Break -->
						<div class="col-12" style="text-align: right; margin-top: 2em">
							<input type="button" value="다음" class="button primary large"
								onclick="nextStep()" />
						</div>

					</div>

				</section>
				
				<div id="modal-alert-section"></div>
			</div>
		</div>

		<!-- Sidebar -->
		<jsp:include page="/include/sidebar.jsp" />

	</div>

	<!-- Scripts -->
	<jsp:include page="/include/script.jsp" />
</body>
</html>