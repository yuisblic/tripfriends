<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	<!-- 날짜포맷팅 라이브러리 -->
<c:set var="cpath" value="${pageContext.request.contextPath }"/>	<!-- contextPath 가져옴 -->
<link rel="stylesheet" href="${cpath }/resources/css/left.css">

<style>
	/* 모바일 환경에서만 좌측 정렬로 변경 */
	@media (max-width: 767px) {
	    .navbar-center {
	        text-align: left;  /* 모바일에서는 좌측 정렬 */
	    }
}
	
</style>
<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="#">여행동행</a>
		    </div>
		    <div id="navbar-collapse" class="collapse navbar-collapse">
			    <ul class="nav navbar-nav navbar-center">
			      <li class="${empty cate ? 'active' : ''}"><a href="${cpath }/">Best 10</a></li>
			      <li class="${cate == 'jp' ? 'active' : ''}"><a href="#" data-value="jp" onclick="goCate()">일본</a></li>
			      <li class="${cate == 'eu' ? 'active' : ''}"><a href="#" data-value="eu" onclick="goCate()">유럽</a></li>
			      <li class="${cate == 'sa' ? 'active' : ''}"><a href="#" data-value="sa" onclick="goCate()">동남아</a></li>
			      <li class="${cate == 'mg' ? 'active' : ''}"><a href="#" data-value="mg" onclick="goCate()">몽골</a></li>
			      <li class="${cate == 'etc' ? 'active' : ''}"><a href="#" data-value="etc" onclick="goCate()">그 외 국가</a></li>
			      <li class="${cate == 'notice' ? 'active' : ''}"><a href="#" data-value="notice" onclick="goCate()">공지사항</a></li>
			    </ul>
		    </div>
		  </div>
		</nav>