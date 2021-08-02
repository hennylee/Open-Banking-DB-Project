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
let agree1
let agree2
let agree3
let agree4
	function checkRegex(){
		let bCheck = false

		let agree1 = $('#open_policy_1')[0] // 오픈뱅킹 서비스 이용약관
		let agree2 = $('#open_policy_2')[0] // 오픈뱅킹공동업무 금융정보조회 약관
		let agree3 = $('#open_policy_3')[0] // 오픈뱅킹 서비스 금융거래정보제공 동의
		let agree4 = $('#open_policy_4')[0] // 오픈뱅킹용 개인(신용)정보 수집·이용 동의
		
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
		if(!agree1.checked){
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
		else{
			bCheck = true
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
						<h2>오픈뱅킹 등록</h2>
					</header>
					<h3 id="elements">1단계 : 정보 동의</h3>
					<p>오픈뱅킹 이용을 위한 정보 약관에 동의해주세요.</p>


					<hr class="major" />


					<div class="row gtr-uniform">
						<div class="col-12">
							<h4>오픈뱅킹 서비스 이용약관</h4>
							<textarea name="" id="" rows="10" readonly="readonly"
								style="resize: none;">
제1조 (목적)
본 약관은 웰컴페이먼츠 주식회사(이하 “회사”라 합니다)가 이용자에게 오픈뱅킹서비스 (이하 “서비스” 라 합니다)를 제공하는 것과 관련하여 입출금이체, 잔액조회, 계좌실명조회, 거래내역조회 등 서비스에 대해 금융기관과의 직접적인 연결을 통해 제공하던 기존 서비스에 더하여, 금융결제원의 오픈뱅킹 시스템을 이용해 고객 여러분들께 더욱 편리한 서비스를 제공하고, 회사와 이용자 간의 권리 및 의무 등 기본적인 사항을 규정함을 목적으로 합니다.

제2조(용어의 정의)
① 본 약관에서 사용하는 용어의 정의는 다음 각 호와 같습니다.

1. “오픈뱅킹서비스”란 오픈뱅킹공동업무를 활용하여 이용자에게 제공되는 조회, 이체 등의 금융거 래 서비스를 총칭합니다.

2. “이용자”란 본 약관에 의하여 회사와 체결한 계약에 따라 회사가 제공하는 서비스를 이용하는 자를 말합니다.

3. “어플리케이션”이란 스마트폰, 태블릿PC 등 휴대용 단말기에 설치되어 회사가 제공하는 서비스 를 이용할 수 있게 하는 앱을 말합니다.

4. “지급인”이란 “출금계좌”의 명의인을 말합니다.

5. “수취인”이란 “입금계좌”의 명의인을 말합니다.

6. “출금계좌”란 서비스 이용을 위해 연결하는 계좌로서 자금 출금이 가능한 계좌를 말합니다.

7. “입금계좌”란 서비스를 이용하여 자금이 입금되는 계좌를 말합니다.

8. “운영기관”이란 오픈뱅킹공동업무를 운영 제공하는 사단법인 금융결제원을 말합니다.

9. “금융회사”란 ‘전자금융거래법’ 제2조 제3호 각목에 해당하는 기관이나 단체 또는 사업자를 말합니다.

10. “오픈뱅킹공동업무”란 회사가 금융회사와 별도 제휴 없이 운영기관을 통하여 API 형태로 운영 ∙제공하는 다음 각 목의 업무를 말합니다.

가. “출금이체”란 회사의 출금에 동의한 이용자의 출금계좌에서 자금을 출금하여 회사의 계정 또는 계좌로 실시간 입금하는 업무를 말합니다.

나. “입금이체”란 회사의 계정 또는 계좌에서 자금을 출금하여 수취인의 계좌로 실시간 입금하는 업무를 말합니다.

다. “잔액조회”란 이용자가 회사가 제공하는 서비스를 통해 본인 계좌의 잔액을 실시간 조회하는 업무를 말합니다.

라. “거래내역조회”란 이용자가 회사가 제공하는 서비스를 통해 본인 계좌의 거래내역을 실시간 조회하는 업무를 말합니다.

마. “계좌실명조회”란 회사가 수취인 또는 출금이체 신청을 한 이용자 계좌의 정상여부 및 실명을 실시간으로 조회하는 업무를 말합니다.

② 본 약관에서 별도로 정의하지 않은 용어는 회사의 서비스 이용약관 및 ‘전자금융거래법’ 등 관계 법령에서 정하는 바를 따릅니다.

제3조(약관의 변경)
① 회사는 본 약관의 내용을 이용자가 쉽게 알 수 있도록 어플리케이션 또는 홈페이지 등에 게시하는 방법 등으로 제공합니다.

② 회사는 관계 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있으며, 변경과 관련된 사항은 회사의 전자금융거래 이용약관을 준용합니다.

제4조(적용의 우선순위)
① 회사는 개별 서비스에 적용될 사항의 규정을 위해 개별 이용정책을 구분하여 개별 서비스를 운영할 수 있으며, 해당 내용이 본 약관과 상충되는 경우 개별 서비스에 대한 개별 이용정책이 우선합니다.

② 본 약관에서 정하지 않은 사항에 대해서는 ‘전자금융거래법’ 등 관계 법령과 회사가 제공하는 약관을 적용합니다.

제5조(출금이체의 동의 및 철회)
① 이용자는 관계 법령에 따라 회사가 제공하는 방식으로 추심이체의 출금 동의를 제공하여야 합니다.

② 이용자는 회사의 거래지시에 따라 이용자의 계좌 원장에 출금기록이 기입되기 전까지는 회사에 대하여 전항의 규정에 따른 동의의 철회를 요청할 수 있습니다. 다만, 회사에 대한 철회의 의사표시 이전에 발생한 출금에 대해서는 이의를 제기할 수 없습니다.

③ 이용자는 서비스에 연결된 출금계좌를 삭제(연결 해지)하는 방법으로 출금이체 동의를 철회할 수 있습니다.

제6조(이용계약의 체결)
① 회사와 이용자 사이의 서비스이용계약(이하 “이용계약”이라 합니다)은 이용자가 되고자 하는 자(이하 “이용신청자”라고 합니다)가 회사가 정한 방법에 따라 가입신청을 하고 회사가 이에 대해 승낙함으로써 체결됩니다.

② 이용계약의 대상은 만 14세 이상의 고객으로 합니다.

③ 이용신청자가 동의 의사를 회사에 전달하게 되면, 본 약관에 동의하고 회사의 서비스 이용을 신청한 것으로 봅니다.

④ 회사는 회사가 정하는 이용계약의 해지사유에 해당하는 경우 이용신청자의 신청을 승낙하지 않을 수 있습니다.

       					</textarea>
						</div>
						<div class="col-12" style="text-align: right">
							<input type="checkbox" id="open_policy_1"
								name="open_policy_1" required> <label
								for="open_policy_1">동의합니다.</label>
						</div>
						
						
						
						<div class="col-12">
							<h4>오픈뱅킹공동업무 금융정보조회 약관</h4>
							<textarea name="" id="" rows="10" readonly="readonly"
								style="resize: none;">
제1조 (약관의 적용)
오픈뱅킹공동업무를 기반으로 이용기관이 제공하는 서비스를 통해 본인의 금융정보를 확인하고자 하는 개인(이하 “사용자”라 한다)과 웰컴페이먼츠 주식회사(이하 “회사”)에 대하여 본 약관을 적용합니다.

제2조 (용어의 정의)
① “오픈뱅킹공동업무”란 이용기관이 핀테크 서비스를 원활하게 제공할 수 있도록 금융권 및 전자금융업권에서 공동으로 구축하여 운영하는 표준화된 오픈API 플랫폼에 대한 제반 업무를 말합니다.
② “이용기관”이란 금융결제원과 오픈뱅킹공동업무 이용계약을 체결하고 이용승인을 받은 기업을 말합니다.
③ “금융정보조회”란 사용자가 이용기관 서비스를 통해 제5조에 명시하는 본인의 금융정보조회 요청 시 회사가 금융정보를 제공하는 업무를 말합니다.
④ “오픈뱅킹중계센터”란 오픈뱅킹공동업무 시스템을 구축하고 운영하며, 회사와 이용기관을 서로 중계하는 곳으로 금융결제원이 운영합니다.

제3조 (금융정보조회 신청)
① 사용자는 본인의 금융정보를 조회하기 위해서는 이용기관 또는 오픈뱅킹중계센터가 제공하는 웹페이지 또는 앱에서 금융정보조회 신청을 하며, 관련 정보는 회사로 전달됩니다.
② 사용자는 회사가 오픈뱅킹중계센터를 통해 이용기관에게 금융정보를 제공할 수 있도록 금융정보조회 신청 시 「신용정보의 이용 및 보호에 관한 법률」 제32조 제1항에 따라 회원 단위로 서면(전자서명이 있는 전자문서 포함), ARS, 통화녹취 등에 의하여 동의를 하여야 합니다.
③ 사용자는 자신의 정보를 보호받고 관리하기 위해 금융정보제공 동의를 1년 단위로 재동의하여야 합니다.
④ 회사는 「개인정보보호법」 및 「신용정보의 이용 및 보호에 관한 법률」 등에서 정한 바에 따라 사용자의 정보를 관리하여야 하며, 이에 대한 세부적인 내용은 회사의 개인정보처리(취급) 방침에 정한 바에 의합니다. 회사는 개인정보처리(취급) 방침에 대한 세부내용을 홈페이지에 게시하여 사용자가 확인할 수 있도록 합니다.

제4조 (금융정보조회 이용시간)
금융정보조회 이용시간은 연중무휴로 00시10분부터 23시50분까지로 합니다.

제5조 (금융정보 종류)
회사에서 제공하는 금융정보의 종류는 다음 각 호와 같습니다.
1. 선불목록조회 : 사용자 본인이 보유한 선불전자지급수단의 권면 식별자 (웰컴머니, 웰컴머니상품권 등) 및 상태정보(신청/가입일자 등) 실시간 조회
2. 선불연계정보조회 : 사용자 본인이 보유한 선불전자지급수단의 충전을 위해 연결된 계좌 정보(추심이체 출금동의를 받은 은행명/계좌번호, 충전 기준정보 등) 실시간 조회
3. 선불잔액조회 : 사용자 본인이 보유한 선불전자지급수단 보유 잔액의 구분별(사용자 충전금액, 회사 적립금액, 소멸예정금액 등) 정보 실시간 조회
4. 선불거래내역조회 : 사용자 본인이 보유한 선불전자지급수단의 거래 정보(건별 거래금액, 거래 후 잔액, 거래 상대정보 등) 실시간 조회
       					</textarea>
						</div>
						<div class="col-12" style="text-align: right">
							<input type="checkbox" id="open_policy_2"
								name="open_policy_2" required> <label
								for="open_policy_2">동의합니다.</label>
						</div>
						
						
						
						
						
						
						<div class="col-12">
							<h4>오픈뱅킹 서비스 금융거래정보제공 동의</h4>
							<textarea name="" id="" rows="10" readonly="readonly"
								style="resize: none;">
본인(이용자)은 회사의 오픈뱅킹서비스를 이용하기 위하여 다음과 같이 본인의 금융거래에 관한 정보 등을 웰컴페이먼츠 주식회사가 제공받는 것에 대하여 아래와 같이 동의합니다.

오픈뱅킹서비스 금융거래정보제공 동의서

ㅇ 제공받는자
: 웰컴페이먼츠 주식회사 / 사업자번호 : 526-87-00842

ㅇ 제공기관
: 오픈뱅킹 제공 회사
- 금융결제원
: 오픈뱅킹공동업무 참여 금융회사
- 신한은행, KB국민은행, 우리은행, KEB하나은행, 농협은행, 기업은행 SC제일은행, 수협은행, 산 업은행, 케이뱅크, 카카오뱅크, 한국씨티은행, 경남은행, 전북은행, 광주은행, 부산은행, 대구은행, 제주은행

ㅇ 제공받는 항목
: 잔액조회 – 계좌번호, 계좌잔액, 출금가능금액, 계좌종류, 상품명
: 거래내역조회 – 계좌잔액, 거래내역(거래일자, 거래시간, 입출금 구분, 거래구분, 통장인자내용, 거래금액, 거래 후 잔액, 거래점명)

ㅇ 보유 및 이용기간
: 본 동의서에 동의한 날로부터 5년
(단, 관련법령에 따라 보존할 필요가 있는 경우 해당 보존기간을 따릅니다)

ㅇ 제공받는 자의 목적
: 오픈뱅킹 서비스(출금이체, 입금이체, 계좌실명조회, 거래내역조회, 잔액조회 등)의 제공

ㅇ 동의를 거부할 권리 및 동의를 거부할 경우의 불이익
: 이용자는 본 정보제공에 대하여 거부할 권리가 있습니다. 다만, 서비스 이용을 위하여 필수적인 정보제공이므로, 서비스 이용에 제한이 있을 수 있습니다.
       					</textarea>
						</div>
						<div class="col-12" style="text-align: right">
							<input type="checkbox" id="open_policy_3"
								name="open_policy_3" required> <label
								for="open_policy_3">동의합니다.</label>
						</div>



						<div class="col-12">
							<h4>오픈뱅킹용 개인(신용)정보 수집·이용 동의</h4>
							<textarea name="" id="" rows="10" readonly="readonly"
								style="resize: none;">
오픈뱅킹 서비스와 상품서비스 안내 등을 위하여 귀사가 본인의 개인(신용)정보를 수집, 이용하는 경우에는 「신용정보의 이용 및 보호에 관한 법률」 제15조 제2항, 제32조 제1항, 제33조 및 제34조, 「개인정보 보호법」 제15조 제1항 제1호, 제22조 제3항에 따라 본인의 동의가 필요합니다.
* 필수사항에 대한 동의만으로 서비스 이용 계약 체결이 가능합니다.

수집·이용 목적
-. 오픈뱅킹 (금융)거래관계의 설정 여부 판단
-. 오픈뱅킹 (금융)거래관계의 설정, 유지, 이행, 관리
-. 오픈뱅킹 금융사고 조사, 분쟁해결, 민원처리
-. 법령상 의무이행
*** 금융실명거래 및 비밀보장에 관한 법률 제4조의2에 따른 법령상 의무이행
-. 상품, 서비스 안내 등을 위한 타행 계좌의 (금융)거래정보의 분석

수집·이용할 항목
-. 공통정보 : 생년월일, 성명, 휴대전화번호, 이메일
-. 오픈뱅킹 서비스 이용을 위하여 등록한 은행 계좌의 (금융)거래정보 : 상품종류, 거래조건(이자율, 만기 등), 거래일시, 금액 등 거래 설정·내역정보 및 오픈뱅킹 서비스의 설정·유지·이행·관리를 위한 상담 등을 통해 생성되는 정보

보유·이용 기간
-. 위 개인(신용)정보는 (금융)거래종료일* 또는 동의 철회 시까지 보유, 이용할 수 있습니다.
-. 단, (금융)거래 종료일 후에는 금융사고 조사, 분쟁해결, 민원처리, 법령상 의무이행을 위해서만 보유, 이용됩니다.
* (금융)거래 종료일이란 오픈뱅킹과 통해 거래중인 계약이 종료한 날을 뜻합니다.

동의를 거부할 권리 및 동의를 거부할 경우의 불이익
-. 위 개인(신용)정보의 수집·이용에 대한 동의를 거부할 수 있으며, 동의 후에도 언제든지 철회 가능합니다. 다만 서비스 이용을 위하여 필수적이므로, 동의하지 않는 경우 상품 및 서비스 안내 등의 편의는 제공받을 수 없습니다.

개인정보 수집·이용 동의
-. 귀사가 위 목적으로 본인의 개인(신용)정보를 수집·이용하는 것에 동의합니다.
* 본 동의 이후 동일한 목적 또는 이용범위 내에서 개인(신용)정보의 정확성, 최신성을 유지하기 위해 제공하는 경우에는 별도의 추가 동의가 필요하지 않습니다.

       					</textarea>
						</div>
						<div class="col-12" style="text-align: right">
							<input type="checkbox" id="open_policy_4"
								name="open_policy_4" required> <label
								for="open_policy_4">동의합니다.</label>
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