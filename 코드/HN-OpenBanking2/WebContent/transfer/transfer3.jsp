<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
$(document).ready(function(){
	
	    holder = $('#holder').val()
	    let msg = $('#msg').val()
	    
		// 계좌 주가 존재하면?
		if(holder){
			$('#ajaxTest03').css("display", "block")
			$('#bank_code').attr('disabled', true)
			$('#account_num').attr('readonly', true)
			$('#amount').attr('readonly', true)
			$('#secondStepBtn').css("visibility", "hidden")
		}
		$('#alert-modal-body-msg').text(msg)
		$('#alertModal').modal('show')
})

function nextStep03(){
	
	accountPw = $('#account_pw').val()
	
	$.ajax({
		url : "<%=request.getContextPath()%>/transfer/transfer3.do",
		data : {
			myNum : account,
			myPw : accountPw,
			targetNum : accountNum,
			amount : amount,
			targetBank : typeCode,
			targetName : holder
		},
		type : "post",
		success : callback,
		error : function() {
			alert('error')
		}
	});
}

function callback(result){
	$('#ajaxTest').replaceWith(result)
	
	if(msg){
		$('#myModal').modal("show")
		$('#alertModal').modal("show")
	}
}

</script>
<input type="hidden" id="msg" name="msg" value="${msg }">
<input type="hidden" id="holder" name="holder" value="${holder }">

				<section id="ajaxTest03" hidden>
					<h3 id="elements">3단계 : 비밀번호 입력</h3>
					<p>해당 계좌의 비밀번호를 입력해주세요.</p>


					<hr class="major" />
					
					
					

						<div class="row">
							<div class="col-4 col-12-xsmall">
								<div class="col-12">
									<h4>계좌 비밀번호</h4>
								</div>

								<div class="col-12">
									<input type="password" name="account_pw" id="account_pw" value=""
										placeholder="상대방 계좌번호를 입력하세요(하이픈 포함)" />
								</div>


							</div>


							<!-- Break -->
							<div class="col-12" style="text-align: right; margin-top: 2em">
								<input type="button" value="다음" class="button primary large"
									onclick="nextStep03()" />
							</div>
						</div>
				</section>
				
				
				

	