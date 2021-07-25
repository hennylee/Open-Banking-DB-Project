<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	let bCheck
	let password

	$(document).ready(function() {
		
		// 비밀번호 입력했을 때
		$('input[type=password]').keyup(function() {
			let length = 4

			let password = $(this).val()
			let pwcheck = $(this).val()

			if (password.length > 4) {
				$('#alert-warning-1').show()
				bCheck = false
			} else {
				$('#alert-warning-1').hide()
			}
			if ($('#password').val() != $('#pwCheck').val()) {
				$('#alert-success').hide()
				$('#alert-danger').show()
				bCheck = false
			} else {
				$('#alert-danger').hide()
				$('#alert-success').show()
				bCheck = true
			}
		})
		
		// 비밀번호 입력안했을 때
		$('#pwCheck').keyup(function() {
			let length = 4

			let password = $(this).val()

			// 4자리 숫자 확인
			if (password.length > 4) {
				$('#alert-warning-2').show()
				bCheck = false
			} else {
				$('#alert-warning-2').hide()
			}
			if ($('#password').val() != $('#pwCheck').val()) {
				$('#alert-success').hide()
				$('#alert-danger').show()
				bCheck = false
			} else {
				$('#alert-danger').hide()
				$('#alert-success').show()
			}

		})

	})

	function complete() {
		if(bCheck){
			alert('완료되었습니다.')
		}
	}
</script>
<header class="major">
	<h2>오픈뱅킹 신청</h2>
</header>

<h3 id="elements">2단계 : 비밀 번호 등록</h3>
<p>오픈뱅킹 서비스에 사용할 비밀번호 4자리를 등록하세요.</p>


						<hr class="major" />
						
						<div class="row gtr-uniform">
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
								<input type="button" value="다음" class="button primary large"
									onclick="complete()" />
							</div>
						
						</div>