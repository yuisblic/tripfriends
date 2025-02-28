<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="u" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>

<link rel="stylesheet" href="${cpath }/resources/css/header.css">

<style>
/* 네비게이션 링크의 텍스트 색상과 아이콘 색상을 검정색으로 설정 */
.navbar-nav .btn-12 {
    color: #000000; /* 텍스트 색상: 검정색 */
    font-size: 12px;
}

.navbar-nav .btn-12 .glyphicon {
    color: #000000; /* 이모티콘 색상: 검정색 */
    font-size: 14px;
}

/* 활성화된 상태일 때의 색상 */
.navbar-nav .btn-12:hover {
    color: #000000; /* 마우스를 올렸을 때 텍스트 색상: 검정색 */
}


</style>

<script>
    
    var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
    
	function logout() {
			$.ajax({
			url : "${cpath}/user/logout",
			type : "post", //insert
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			success : function(){
				location.href="${cpath}/";
			},
			error : function(){alert("error");}
		});
    }
</script>

<div class="navbar-container">
	<button align="left" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false" aria-controls="navbar-collapse">
	        	<span class="glyphicon glyphicon-menu-hamburger"></span>
	 </button>
	<button align="right" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-user" aria-expanded="false" aria-controls="navbar-collapse-user">
        <span class="glyphicon glyphicon-user"></span>
    </button>
	<div id="navbar-collapse-user" class="collapse navbar-collapse">
		<security:authorize access="isAnonymous()">
	  		<ul class="nav navbar-nav navbar-right">
		      	<li><a href="${cpath}/" class="btn-12"><span class="glyphicon glyphicon-home"></span> Home</a></li>
		      	<li><a href="${cpath}/user/signUp" class="btn-12"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
		      	<li><a href="${cpath}/user/login" class="btn-12"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
	    	</ul>
		</security:authorize>
		<security:authorize access="isAuthenticated()">
	  		<ul class="nav navbar-nav navbar-right">
		      	<li><a href="${cpath}/" class="btn-12"><span class="glyphicon glyphicon-home"></span> Home</a></li>
		      	<li><a href="${cpath }/user/editPage" class="btn-12"><span class="glyphicon glyphicon-user"></span> Edit</a></li>
		      	<li><a href="javascript:logout()" class="btn-12"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
	    	</ul>
		</security:authorize>
	</div>
</div>
<div class="map">
		<div class="plane"></div>
		<div>Trip Friends</div>
</div>
  	
  	