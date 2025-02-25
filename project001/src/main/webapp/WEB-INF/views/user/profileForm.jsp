<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	<!-- 날짜포맷팅 라이브러리 -->
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="u" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>	<!-- contextPath 가져옴 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${cpath }/resources/css/signUp.css"/>
<style>
	.file-input::file-selector-button {
	  color: black;
	}
	
	.file-input {
	  color: black;
	}
	
	.profile-image {
	  width: 70px;
	  height: 80px;
	  background: #d1c8ff;
	  border-radius: 15px;
	  margin: auto;
	  margin-top: 25px;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  overflow: hidden;
	}
	
	.profile-image img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	  object-position: center;
	}

	
</style>  

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
	    const fileInput = document.getElementById('file-input');
	    const imagePreview = document.getElementById('imagePreview');
	    
	    fileInput.addEventListener('change', function(event) {
	        const file = event.target.files[0];
	        if (file) {
	            const reader = new FileReader();
	            
	            reader.onload = function(e) {
	                imagePreview.src = e.target.result;
	                imagePreview.style.display = 'block';
	            }
	            
	            reader.readAsDataURL(file);
	        }
	    });
	});

	function goCate(){
		  event.preventDefault();
		  const cate = event.target.dataset.value;
		  window.location.href = "${cpath}/board/cate?cate="+cate+"&page=1";
	}
	
</script>
</head>

<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
    <div class="panel panel-default" align="center">
    <jsp:include page="/WEB-INF/views/nav.jsp"></jsp:include>
		<form class="form" action="${cpath}/user/profileUpdate?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		    <p class="title">프로필사진수정</p>
		    <div class="profile-image">
		        <img id="imagePreview" src="${cpath}/resources/images/upload/${u.user.userProfile}">  
		    </div><br/>
		    <input type="file" name="userProfile" class="file-input" id="file-input" accept="image/*">
		    <button class="submit" type="submit">사진변경</button>
		    <input type="hidden" name="userId" id="userId" value="${u.user.userId}">
		</form>

	</div>
</div>
  	
  
  <!--  다이얼로그창(모달) -->
    <!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog" >
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메세지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage">${msg }</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>	
	  </div>
	</div> 
</body>
</html>