<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>

function checkRegex_02(){
	let bCheck = false

	tgtaccount = $('#account_num').val();
	amount = $('#amount').val();

	let accnt_regex = /\d\-\d|\d/
	let amount_regex = /\d/
	
	// 계좌번호 정규식 검사
	if(!accnt_regex.test(tgtaccount)){
		bCheck = false
		$('#alert-modal-body-msg').text('계좌번호는 하이픈을 포함한 숫자만 입력 가능합니다.')
		$('#alertModal').modal('show')
	}
	else if(!amount_regex.test(amount)){
		bCheck = false
		$('#alert-modal-body-msg').text('이체할 금액은 숫자만 입력 가능합니다. ')
		$('#alertModal').modal('show')
	}
	else if(Number(amount)>Number(balance)){
		bCheck = false
		$('#alert-modal-body-msg').text('잔액이 부족합니다. ')
		$('#alertModal').modal('show')
	}
	else{
		bCheck = true
	}
	return bCheck
}

function nextStep_02(){
	
	tgtbank = $("select[name='bank_code'] option:selected").val();
	
	if(checkRegex_02()){
		
		
		
		
		/*
		
		let balance // 내 잔액
		let myaccount // 내 계좌
		let myname = '${sessionScope.userName}' // 내이름
		let mybank // 내 은행
		let myaccountPw // 내 계좌 비밀번호
		
		let tgtaccount // 상대계좌
		let tgtholder // 상대 계좌주
		let tgtbank // 보낼 은행
		
		let amount // 보낼 금액
		
		
		*/
		
		$.ajax({
			url : "<%=request.getContextPath()%>/openbank/inquiry/account.do",
			data : {
				tgtbank : tgtbank,
				tgtaccount : tgtaccount,
				amount : amount,
				myaccount : myaccount,
				myname : myname
			},
			type : "post",
			success : callback_02,
			error : function() {
				alert('error')
			}

		});
	
	}

}

function callback_02(result) {
	$('#ajaxTest02').append(result)
}

</script>
				<section id=ajaxTest02>
					<h3 id="elements">2단계 : 입금 계좌 입력</h3>
					<p>입금하실 계좌 정보를 선택해주세요</p>


					<hr class="major" />
					
					
					

						<div class="row">
							<div class="col-4 col-12-medium">

								<div class="col-12">
									<h4>은행 선택</h4>
								</div>
								<div class="col-12-small">
									<select name="bank_code" id="bank_code">
										<c:forEach items="${bList }" var="bank">
											<option value="${bank.code }">${bank.name }</option>
										</c:forEach>
									</select>
								</div>

							</div>
							<div class="col-8 col-12-medium">
								<div class="col-12">
									<h4>계좌 번호 입력</h4>
								</div>

								<div class="col-12">
									<input type="text" name="account_num" id="account_num" value=""
										placeholder="상대방 계좌번호를 입력하세요(하이픈 포함)" />
								</div>


								<br>

								<div class="col-12">
									<h4>이체할 금액</h4>
								</div>
								<div class="col-12">
									<input type="text" name="amount" id="amount" value=""
										placeholder="이체할 금액을 입력하세요." />
								</div>


							</div>


							<!-- Break -->
							<div class="col-12" style="text-align: right; margin-top: 2em">
								<input type="button" value="다음" class="button primary large" onclick="nextStep_02()"
								 id="secondStepBtn"/>
							</div>
						</div>
				</section>

