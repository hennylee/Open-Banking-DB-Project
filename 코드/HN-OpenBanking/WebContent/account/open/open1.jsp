<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
		let bCheck = true

		let agree = $('#openStep1_agree')[0]
		let residentNum1 = $('#residentNum1').val();
		let residentNum2 = $('#residentNum2').val();
		let tel1 = $('#tel1').val();
		let tel2 = $('#tel2').val();
		let tel3 = $('#tel3').val();
		
		let tel1_regex = /^[0-9]{3}$/
		let tel2_regex = /^[0-9]{4}$/
		let tel3_regex = /^[0-9]{4}$/
		let residentNum1_regex = /^[0-9]{6}$/
		let residentNum2_regex = /^[0-9]{7}$/
		// 정보 동의 체크 안했다면?
		if(!agree.checked){
			bCheck = false
			$('#alert-modal-body-msg').text('개인 정보 동의는 필수 체크 항목입니다.')
			$('#alertModal').modal('show')
		}
		// 정보 동의 체크 했다면? 주민번호 검사
		else if(!residentNum1_regex.test(residentNum1)){
			bCheck = false
			$('#alert-modal-body-msg').text('주민번호(생년월일)는 숫자 6자리로 입력하세요.')
			$('#alertModal').modal('show')
		}
		else if(!residentNum2_regex.test(residentNum2)){
			bCheck = false
			$('#alert-modal-body-msg').text('주민번호 뒷자리는 숫자 7자리로 입력하세요.')
			$('#alertModal').modal('show')
		}
		// 전화번호 검사
		else if(!tel1_regex.test(tel1)){
			bCheck = false
			$('#alert-modal-body-msg').text('전화번호 첫번째 번호는 숫자 3자리로 입력하세요')
			$('#alertModal').modal('show')
		}
		else if(!tel2_regex.test(tel2)){
			bCheck = false
			$('#alert-modal-body-msg').text('전화번호 가운데 번호는 숫자 4자리로 입력하세요')
			$('#alertModal').modal('show')
		}
		else if(!tel3_regex.test(tel3)){
			bCheck = false
			$('#alert-modal-body-msg').text('전화번호 마지막 번호는 숫자 4자리로 입력하세요')
			$('#alertModal').modal('show')
		}
		
		return bCheck
	}

	function nextStep(){
		let url = ""
		
		<%-- $.ajax({
			url : "<%=request.getContextPath()%>/include/modalAlert.jsp",
			success : function(result){
				$('#modal-alert-section').html(result)
			},
			error : function() {
				alert('error')
			}
		}); --%>
		
		let residentNum1 = $('#residentNum1').val();
		let residentNum2 = $('#residentNum2').val();
		let tel1 = $('#tel1').val();
		let tel2 = $('#tel2').val();
		let tel3 = $('#tel3').val();
		
		if(checkRegex()){
			
			$.ajax({
				url : "<%=request.getContextPath()%>/account/open/step1.do",
				data : {
					residentNum1 : residentNum1,
					residentNum2 : residentNum2,
					tel1 : tel1,
					tel2 : tel2,
					tel3 : tel3
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
						<h2>비대면 계좌개설</h2>
					</header>
					<h3 id="elements">1단계 : 본인 조회</h3>
					<p>금융 거래 정보 조회를 위해 아래 정보를 입력해주세요</p>


					<hr class="major" />


					<div class="row gtr-uniform">
						<div class="col-12">
							<h4>개인 정보 동의</h4>
							<textarea name="" id="" rows="10" readonly="readonly"
								style="resize: none;">
HN은행은 비대면 계좌개설와 관련하여 아래와 같이 개인정보를 수집‧이용하고자 합니다.

개인정보 수집·이용 내역 (필수사항)
항 목 : 회원ID(이메일주소), 비밀번호, 성명, 주민등록번호, 휴대폰 번호
목 적 : 금융 정보 조회 제공
보유기간 : 탈퇴/해지 신청시까지

※ 상기 개인정보 수집‧이용에 대한 동의를 거부할 권리가 있으며, 동의를 거부할 경우 HN은행 비대면 계좌개 이용에 제한을 받을 수 있습니다.
※ 만 14세 미만 아동에게는 서비스를 제공하지 않습니다. 
       					</textarea>
						</div>
						<div class="col-12" style="text-align: right">
							<input type="checkbox" id="openStep1_agree"
								name="openStep1_agree" required> <label
								for="openStep1_agree">동의합니다.</label>
						</div>





						<div class="col-12">
							<h4>주민번호</h4>
						</div>
						<div class="col-6 col-12-xsmall">
							<input type="text" name="residentNum1" id="residentNum1" value=""
								placeholder="생년월일" />
						</div>
						<div class="col-6 col-12-xsmall">
							<input type="password" name="residentNum2" id="residentNum2"
								value="" placeholder="주민번호 뒷자리" />
						</div>


						<div class="col-12">
							<h4>전화번호</h4>
						</div>
						<div class="col-4 col-12-small">
							<select name="tel1" id="tel1">
								<option value="010">010</option>
								<option value="011">011</option>
							</select>
						</div>
						<div class="col-4 col-12-small">
							<input type="tel" name="tel2" id="tel2" value=""
								placeholder="전화번호 앞자리" />
						</div>
						<div class="col-4 col-12-small">
							<input type="tel" name="tel3" id="tel3" value=""
								placeholder="전화번호 뒷자리" />
						</div>





						<!-- Break -->
						<div class="col-12" style="text-align: right; margin-top: 2em">
							<input type="button" value="다음" class="button primary large"
								onclick="nextStep()" />
						</div>
					</div>








				</section>

				<div id="modal-after-section"></div>
				<!-- <div id="modal-alert-section"></div> -->



				<!-- Modal -->
				<div id="alertModal" class="modal fade" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">

						Modal content
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