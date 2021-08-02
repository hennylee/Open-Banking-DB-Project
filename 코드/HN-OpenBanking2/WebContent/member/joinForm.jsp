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






<!-- modal -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/main.css" />
<script>
function checkForm(){
	let bCheck = false
	
	// id 중복확인
	
	
	// 이메일 중복확인
	
	
	// 전화번호 중복확인
	
	
	// pw 체크
	
	
	
	
	return bCheck
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
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
						<h2>회원가입</h2>
					</header>


					<form method="post" action="<%=request.getContextPath() %>/join.do" onsubmit="return checkForm()">
						<div class="row gtr-uniform">


							<div class="col-12">
								<h3>ID</h3>
							</div>
							<div class="col-4 col-12-small">
								<input type="text" name="id" id="" value=""
									placeholder="아이디" />
							</div>
							
							<!-- 중복확인 -->
							<div class="col-8 col-12-small">
								<!-- Trigger the modal with a button -->
								<button type="button" class="button primary" data-toggle="modal" data-target="#myModal">중복확인</button>
							</div>
							
							

							<div class="col-12">
								<h3>PW</h3>
							</div>
							<div class="col-6 col-12-xsmall">
								<input type="password" name="password" id="" value=""
									placeholder="비밀번호" />
							</div>
							<div class="col-6 col-12-xsmall">
								<input type="password" name="" id="" value=""
									placeholder="비밀번호 확인" />
							</div>
							
							
							
							<div class="col-12">
								<h3>이름</h3>
							</div>
							<div class="col-12-small">
								<input type="text" name="name" id="" value=""
									placeholder="이름" />
							</div>
							
							
							<div class="col-12">
								<h3>주민번호</h3>
							</div>
							<div class="col-6 col-12-xsmall">
								<input type="text" name="residentNum1" id="" value=""
									placeholder="생년월일" />
							</div>
							<div class="col-6 col-12-xsmall">
								<input type="password" name="residentNum2" id="demo-name" value=""
									placeholder="주민번호 뒷자리" />
							</div>
							
							<div class="col-12">
								<h3>이메일</h3>
							</div>
							<div class="col-6 col-12-xsmall">
								<input type="text" name="emailId" id="" value=""
									placeholder="이메일 아이디" />
							</div>
							<div class="col-6 col-12-xsmall">
								<select name="emailDomain" id="">
									<option value="0">@naver.com</option>
									<option value="1">@daum.net</option>
									<option value="2">@kakao.com</option>
									<option value="3">@google.com</option>
								</select>
							</div>
							
							
							<div class="col-12">
								<h3>전화번호</h3>
							</div>
							<div class="col-4 col-12-small">
								<select name="tel1" id="">
									<option value="010">010</option>
									<option value="011">011</option>
								</select>
							</div>
							<div class="col-4 col-12-small">
								<input type="tel" name="tel2" id="" value=""
									placeholder="전화번호 앞자리" />
							</div>
							<div class="col-4 col-12-small">
								<input type="tel" name="tel3" id="" value=""
									placeholder="전화번호 뒷자리" />
							</div>
							
							
							<div class="col-12">
								<h3>우편번호</h3>
							</div>
							<div class="col-4 col-12-small">
								<input type="text" name="post" id="sample6_postcode" placeholder="우편번호" required>
							</div>
							<div class="col-8 col-12-xsmall">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"  class="button primary" ><br>
							</div>
							
							<div class="col-12">
								<h3>주소</h3>
							</div>
							
							
							<div class="col-6 col-12-xsmall">
								<input type="text" name="basicAddr" required id="sample6_address" placeholder="주소">
							</div>
							<div class="col-6 col-12-xsmall">
								<input type="text" id="sample6_extraAddress" placeholder="참고항목">
							</div>
							<div class="col-12">
								<input type="text" name="detailAddr" required id="sample6_detailAddress" placeholder="상세주소">
							</div>
							
							
							
							
							<!-- Break -->
							<div class="col-12">
								<ul class="actions">
									<li><input type="submit" value="확인" class="primary"/></li>
									<li><input type="reset" value="초기화"/></li>
								</ul>
							</div>
						</div>
					</form>
				</section>


			</div>
		</div>

		<!-- Sidebar -->
		<jsp:include page="/include/sidebar.jsp" />

	</div>

	<!-- Scripts -->
	<jsp:include page="/include/script.jsp" />
</body>
</html>