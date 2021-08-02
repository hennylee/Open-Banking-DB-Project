<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
let msg
$(document).ready(function(){
	
	    tgtholder = $('#holder').val()
	    msg = $('#msg').val()
		
		// 계좌 주가 존재하면?
		if(tgtholder){
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
	
	myaccountPw = $('#account_pw').val()
	
	$.ajax({
		url : "<%=request.getContextPath()%>/openbank/transfer3.do",
		data : {
			tgtbank : tgtbank,
			tgtaccount : tgtaccount,
			amount : amount,
			tgtholder : tgtholder,
			myaccount : myaccount,
			myname : myname,
			mybank : mybank,
			myaccountPw : myaccountPw
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
					<p>오픈뱅킹 신청 시 등록한 비밀번호를 입력해주세요.</p>


					<hr class="major" />
					
					
					

						<div class="row">
							<div class="col-4 col-12-xsmall">
								<div class="col-12">
									<h4>비밀번호</h4>
								</div>

								<div class="col-12">
									<input type="password" name="account_pw" id="account_pw" value=""
										placeholder="비밀번호 4자리를 입력하세요" />
								</div>


							</div>


							<!-- Break -->
							<div class="col-12" style="text-align: right; margin-top: 2em">
								<input type="button" value="다음" class="button primary large"
									onclick="nextStep03()" />
							</div>
						</div>
				</section>
				
				
				

	