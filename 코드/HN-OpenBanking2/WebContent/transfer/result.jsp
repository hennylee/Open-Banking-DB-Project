<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
   $(document).ready(function() {
 $('#sendLinkDefault').click(function() {
	 
	 const sharedUrl = location.href;
	 console.log(sharedUrl)
          Kakao.init("c5ff3159ca4276b8547139e0ff97e0e5")
          Kakao.Link.sendDefault({
            objectType: 'feed',
            content: {
              title: '${tVo.targetName }고객님 입금 확인하세요.',
              description: '${tVo.targetName }고객님 계좌로 ${tVo.targetAccount }원이 입금되었습니다.',
              imageUrl: 'http://localhost:9998/HN-OpenBanking/images/HN_logo.png',
              link: {
                mobileWebUrl: sharedUrl,
                webUrl: sharedUrl,
              },
            },
            social: {
              likeCount: 999,
            },
            buttons: [
              {
                title: '자세히 보기',
                link: {
                  mobileWebUrl: 'http://localhost:9998/HN-OpenBanking/',
                  webUrl: 'http://localhost:9998/HN-OpenBanking/',
                },
              },
            ],
          })
        })
      ; window.kakaoDemoCallback && window.kakaoDemoCallback()
})
</script>

				
				<section>
					<header class="major">
						<h2>계좌 이체</h2>
					</header>
					<h3 id="elements">이체 결과 안내</h3>
					<p>계좌 이체가 아래와 같이 완료되었습니다.</p>


					<hr class="major" />
				
				
					<h4>${userName }의 이체 내역</h4>
													<div class="row">
														<div class="col-6 col-12-small">

															<ul class="alt">
															
															
															
																<li>입금처  : ${tVo.targetName }&nbsp;${tVo.targetAccount }</li>
																<li>이체액  : ${tVo.transAmount }원</li>
																<li>출금처  : ${userName }&nbsp;${tVo.myAccount }</li>
															</ul>

														</div>
				
				
				</section>
				
				<input type="button" class="btn btn-default" id="sendLinkDefault" value="카카오톡 보내기"/>
				
				
				
			