<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	<!-- 날짜포맷팅 라이브러리 -->
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="u" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>	<!-- contextPath 가져옴 -->
<link rel="stylesheet" href="${cpath }/resources/css/left.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
/* 모바일 화면에서 숨기기 */
  @media (max-width: 767px) {
    .card, #exchangeWidget {
      display: none; /* 모바일 화면에서는 이 div가 보이지 않음 */
    }
  }
  

 
</style>
<script type="text/javascript">
	
</script>

<div class="card" style="margin-bottom: 20px;">
  <div class="card-border-top">
  </div>
  <div>
  	<security:authorize access="isAnonymous()">
  		<span><img class="img-circle" src="${cpath}/resources/images/profile/userImage.png" style="width: 70px; height: 80px"/></span>
  	</security:authorize>
    <security:authorize access="isAuthenticated()">
	  	<span>
	  		<c:if test="${empty u.user.userProfile}"><img class="img-circle" src="${cpath}/resources/images/profile/userImage.png" style="width: 70px; height: 80px"/></c:if>
	  		<c:if test="${!empty u.user.userProfile}"><img class="img-circle" src="${cpath}/resources/images/upload/${u.user.userProfile }" style="width: 70px; height: 80px"/></c:if>
	  	</span>
    </security:authorize>
  </div>
  <security:authorize access="isAnonymous()">
	  <span> 로그인이 필요합니다.</span>
	  <p class="job"> 로그인 후 서비스를 이용해보세요!</p>
	  <div class="button-container">
		<button onclick="location.href='${cpath}/user/login'"> 로그인</button>
	  	<button onclick="location.href='${cpath}/user/signUp'"> 회원가입</button>
	  </div>
  </security:authorize>
  <security:authorize access="isAuthenticated()">
	  <span>${u.user.userName }</span>
	  <p class="job"> ${u.user.userId }님 환영합니다!</p>
	  <div class="button-container">
		<button onclick="location.href='${cpath}/board/register'"> 글쓰기</button>
	  	<button onclick="location.href='${cpath}/user/wishList'"> 찜목록</button>
	  </div>
  </security:authorize>
</div>
  
<!-- 환율 위젯 -->
<div id="exchangeWidget" style="width:100%;border:3px solid #D1C8FF;border-radius:5px; ">
	<div style="text-align:center;background-color:#D1C8FF;font-size:13px;font-weight:bold;height:22px;">
		<a href="https://www.exchangeratewidget.com/" style="color:#000000;text-decoration:none;" rel="nofollow">환율 계산기</a>
	</div>
	<script type="text/javascript" src="https://www.exchangeratewidget.com/converter.php?l=en&f=USD&t=KRW&a=1&d=FFFFFF&n=FFFFFF&o=000000&v=3"></script>
</div>
