<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	<!-- 날짜포맷팅 라이브러리 -->
<c:set var="cpath" value="${pageContext.request.contextPath }"/>	<!-- contextPath 가져옴 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${cpath }/resources/css/signUp.css"/>
<style type="text/css">

</style>
<script type="text/javascript">
	$(document).ready(function(){
		if(${!empty msg}){
			$("#checkType").attr("class", "modal-content panel-success");    
	  		$("#myModal").modal("show");
	  	}
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
		<form class="form" action="${cpath }/login" method="post">
		    <p class="title">로그인 </p>
		    <div class="flex">
		    <label>
		            <input class="input" type="text" id="userId" name="username" required>
		            <span>아이디</span>
		    </label>
		    </div>  
		    <label>
		        <input class="input" type="password" id="userPw" name="password" required>
		        <span>비밀번호</span>
		    </label>
		    <button class="submit" type="submit">로그인</button>
		    <!-- 스프링 시큐리티 토큰값 전달 -->
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
  </div>
  </div>
  
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
		
</div>
</body>
</html>