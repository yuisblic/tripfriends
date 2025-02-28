<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	<!-- 날짜포맷팅 라이브러리 -->
<c:set var="cpath" value="${pageContext.request.contextPath }"/>	<!-- contextPath 가져옴 -->

<!DOCTYPE html>
<html lang="en">
<head>
  <title>여행동행 구하기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style type="text/css">
  body{
  background-color: #2c3e50;
  }
  </style>
  <script type="text/javascript">
	  $(document).ready(function(){
			if(${!empty msg}){
				$("#checkType").attr("class", "modal-content panel-success");    
		  		$("#myModal").modal("show");
		  	}
		});
  </script>

</head>
<body>
	<div class="container">
		<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
		<div class="panel panel-default">
    	<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="#">여행동행</a>
		    </div>
		    <ul class="nav navbar-nav navbar-right">
		      <li class="active"><a href="#">Best</a></li>
		      <li><a href="#">일본</a></li>
		      <li class="dropdown">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">유럽
		        <span class="caret"></span></a>
		        <ul class="dropdown-menu">
		          <li><a href="#">서유럽</a></li>
		          <li><a href="#">동유럽</a></li>
		          <li><a href="#">그 외 유럽</a></li>
		        </ul>
		      </li>
		      <li class="dropdown">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">동남아
		        <span class="caret"></span></a>
		        <ul class="dropdown-menu">
		          <li><a href="#">태국</a></li>
		          <li><a href="#">베트남</a></li>
		          <li><a href="#">필리핀</a></li>
		          <li><a href="#">그 외 동남아</a></li>
		        </ul>
		      </li>
		      <li><a href="#">몽골</a></li>
		      <li><a href="#">그 외 국가</a></li>
		      <form class="navbar-form navbar-left" action="/action_page.php">
				  <div class="input-group">
				    <input type="text" class="form-control" placeholder="Search">
				    <div class="input-group-btn">
				      <button class="btn btn-default" type="submit">
				        <i class="glyphicon glyphicon-search"></i>
				      </button>
				    </div>
				  </div>
				</form>
		    </ul>
		  </div>
		</nav>
    <div class="panel-body">
		<div class="col-lg-3">
			<jsp:include page="left.jsp"/>
		</div>
		<div class="col-lg-9">
			<table class="table table-bordered table-hover">
			 <thead>
				<tr>
					<th>여행지</th>
					<th>제목</th>
					<th>작성자</th>
					<th>찜수</th>
				</tr>
			 </thead>
			 <tbody>
				<tr>
					<td>여행지</td>
					<td>제목</td>
					<td>작성자</td>
					<td>찜수</td>
				</tr>
			 </tbody>
				
			</table>
		</div>
    </div>
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