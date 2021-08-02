<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
      function CloseModal(){
         var CloseModal = document.querySelector(".container");
         CloseModal.classList.add("CloseModal");
         location.href="${url}";
      }
</script>
<style>
.container.CloseModal{
         display:none;
      }
</style>
</head>
<body>
	<div>
	본문입니다.
	</div>
	<div class="container">
	      <div class="modal">
	         <button onclick="CloseModal();">x</button>
	         <h1>${msg }</h1>
	      </div>
	</div>
</body>
</html>