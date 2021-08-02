<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%-- ${script } --%>
<input type="hidden" id="hiddenValue" value=${hiddenValue }>
<!-- Modal -->
	<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close button modalClose"
						data-dismiss="modal" style="box-shadow: none;">&times;</button>
					<h4 class="modal-title">알림</h4>
				</div>
				<div class="modal-body">
					<p id="modal-body-msg">${msg }</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn button primary"
						data-dismiss="modal">닫기</button>
					<a href="${url }" class="btn button">확인</a>
				</div>
			</div>

		</div>
	</div>

