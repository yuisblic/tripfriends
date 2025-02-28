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
<title>회원가입</title>
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
			$("#checkType").attr("class", "modal-content panel-warning");    
     		$("#myModal").modal("show");
    	}
	});
	function goCate(){
		  event.preventDefault();
		  const cate = event.target.dataset.value;
		  window.location.href = "${cpath}/board/cate?cate="+cate+"&page=1";
	  }
	function userCheck(){
		var userId = $("#userId").val();
		$.ajax({
			url: "${cpath}/user/userCheck",
			type: "get",
			data: {"userId":userId},
			success: function(result){
				if(result==1){
					$("#checkMessage").html("사용할 수 있는 아이디입니다.");
					$("#checkType").attr("class","modal-content panel-success");
					$("#userCheckResult").val("checked");
	    		   }else{
	    			  $("#checkMessage").html("사용할 수 없는 아이디입니다."); 
	    			  $("#checkType").attr("class","modal-content panel-warning");
	    			  $("#userCheckResult").val("unchecked");
	    		   }
	    		   $("#myModal").modal("show");
	    	   },    	   
	    	   error : function(){ alert(result); }    	  
		});
		
	}
	
	function passwordCheck(){
		var userPw1 = $("#userPw1").val();
		var userPw2 = $("#userPw2").val();
		if(userPw1 != userPw2){
			$("#passMessage").html("비밀번호가 일치하지 않습니다.");
		}else{
			$("#passMessage").html("");
			$("#userPw").val(userPw1);
		}
	}
	
	function validateForm(){
        var userCheckResult = $("#userCheckResult").val();
        var passMessage = $("#passMessage").html();
        if(userCheckResult !== "checked" || userCheckResult==null){
            $("#checkMessage").html("아이디 중복 확인을 해주세요.");
            $("#checkType").attr("class","modal-content panel-warning");
            $("#myModal").modal("show");
            return false;
        }else if(passMessage == "비밀번호가 일치하지 않습니다."){
        	$("#checkMessage").html("비밀번호가 일치하지 않습니다.");
            $("#checkType").attr("class","modal-content panel-warning");
            $("#myModal").modal("show");
        	return false;
        }
        return true;
    }
	
</script>
</head>
<body>
	<div class="container">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
    <div class="panel panel-default" align="center">
    <jsp:include page="/WEB-INF/views/nav.jsp"></jsp:include>
		<form class="form" action="${cpath }/user/join" method="post" onsubmit="return validateForm()">
			<input type="hidden" id="userCheckResult" name="userCheckResult" value=""/>
		    <input type="hidden" id="userPw" name="userPw" value=""/>
		    <input type="hidden" id="userProfile" name="userProfile" value="userImage.png">
		    <p class="title">회원가입 </p>
		        <label>
		            <input class="input" type="text" id="userName" name="userName" required>
		            <span>이름</span>
		        </label>
		    <div class="flex">
		    <label>
		            <input class="input" type="text" id="userId" name="userId" required>
		            <span>아이디</span>
		            <button type="button" class="check" onclick="userCheck()">중복확인</button>
		    </label>
		    </div>  
		    <label>
		        <input class="input" type="password" id="userPw1" name="userPw1" onkeyup="passwordCheck()" required>
		        <span>비밀번호</span>
		    </label>
		        
		    <label>
		        <input class="input" type="password" id="userPw2" name="userPw2" onkeyup="passwordCheck()" required>
		        <span>비밀번호 확인</span>
		    </label>
		    <label>
		        <span id="passMessage" style="color:red; font-size: 14px;">
		    </label>
		    <label>
		        <input class="input" type="email" id="userEmail" name="userEmail" required>
		        <span>이메일</span>
		    </label> 
		    </span><button class="submit">회원가입</button>
		    <p class="signin">계정이 이미 존재합니까? <a href="${cpath}/user/login">Login</a> </p>
		    <!-- 스프링 시큐리티 토큰값 전달 -->
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
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
		
</div>
</body>
</html>