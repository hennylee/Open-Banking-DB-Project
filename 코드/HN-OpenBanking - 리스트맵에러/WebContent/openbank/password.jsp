<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
let bCheck = false

	function checkLength(){
		let password = $('#password').val()
		let pwcheck = $('#pwCheck').val()
		
		if ($('#password').val().length > 4 || $('#pwCheck').val().length > 4) {
			$('#alert-warning').show()
			return false
		} else {
			$('#alert-warning').hide()
			return true
		}
		return false
		
	}
	function checkEqual(){
		let password = $('#password').val()
		let pwcheck = $('#pwCheck').val()
		
		if (password != pwcheck) {
			$('#alert-danger').show()
			$('#alert-success').hide()
			return false
		} else {
			$('#alert-success').show()
			$('#alert-danger').hide()
			return true
		}
		return false
	}
	
	
	$(document).ready(function() {
		
		let password = $('#password').val()
		let pwcheck = $('#pwCheck').val()
		
		// 비밀번호 입력했을 때
		$('input[type=password]').keyup(function() {
			
			if(checkLength() == true && checkEqual() == true ){
				//alert('둘다 일치함')
				// 둘다 일치함
				bCheck = true
			}
			
		})

	})

	function submitCheck() {
		if (bCheck == true) {
			return true
		}
		return false
	}
</script>
<header class="major">
	<h2>오픈뱅킹 신청</h2>
</header>

<h3 id="elements">2단계 : 비밀 번호 등록</h3>
<p>오픈뱅킹 서비스에 사용할 비밀번호 4자리를 등록하세요.</p>


<hr class="major" />

<div class="row gtr-uniform">

<form action="<%= request.getContextPath() %>/openbank/register.do" method="post" onsubmit="return submitCheck()">
	<div class="col-6 col-12-xsmall">
		<input type="password" name="password" id="password" value=""
			placeholder="패스워드" style="margin-bottom: 20" />

	</div>
	<div class="col-6 col-12-xsmall">
		<input type="password" name="pwCheck" id="pwCheck" value=""
			placeholder="패스워드 확인" />
	</div>

	<div class="col-12">
		<div class="alert alert-warning" id="alert-warning" hidden>숫자
			4자리로 입력해주세요.</div>
		<div class="alert alert-success" id="alert-success" hidden>비밀번호가
			일치합니다.</div>
		<div class="alert alert-danger" id="alert-danger" hidden>비밀번호가
			일치하지 않습니다.</div>
	</div>

	<!-- Break -->
	<div class="col-12" style="text-align: right; margin-top: 2em">
		<input type="button" value="다음" class="button primary large"/>
	</div>
</form>
</div>