<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	<!-- 날짜포맷팅 라이브러리 -->
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="u" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
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

  </style>
  <script type="text/javascript">
	  $(document).ready(function(){
		  	loadList();
			if(${!empty msg}){
				$("#checkType").attr("class", "modal-content panel-success");    
		  		$("#myModal").modal("show");
		  	}
		});
	  
	  function loadList(){
		  $.ajax({
			 url : "board/best",
			 type : "get",
			 dataType : "json",
			 success : makeView,
			 error : function(){alert("error");}
		  });
	  }
	  
	  function makeView(list){
		  var listHtml = "";
		  if (list && list.length > 0) {
		        // list에 항목이 있을 때
		        $.each(list, function(index, obj) {
		            listHtml += "<tr>";
		            listHtml += "<td>" + obj.idx + "</td>";
		            listHtml += "<td><a href='${cpath }/board/content?idx=" + obj.idx + "'>" + obj.title + "</a></td>";
		            listHtml += "<td>" + obj.userId + "</td>";
		            listHtml += "<td>" + obj.indate.split(' ')[0] + "</td>";
		            listHtml += "<td id='cnt" + obj.idx + "'>" + obj.count + "</td>";
		            listHtml += "</tr>";
		        });
		    } else {
		        // list가 비어 있을 때
		        listHtml += "<tr><td colspan='5' align='center'>아직 인기게시글이 없습니다.</td></tr>";
		    }
		  
		  $("#view").html(listHtml);
			
	  }
	  
	  function goCate(){
		  event.preventDefault();
		  const cate = event.target.dataset.value;
		  window.location.href = "${cpath}/board/cate?cate="+cate+"&page=1";
	  }
	  
	  function goContent(event,idx){
		  event.preventDefault();
		  $.ajax({
				 url : "board/count/"+idx,
				 type : "put",
				 dataType : "json",
				 beforeSend : function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				 },
				 success : function(){
					 window.location.href = "${cpath}/board/content?idx="+idx;
				 },
			  	 error : function(){
			  		 alert("error");
			  	 }
			  });
	  }
	  
  </script>

</head>
<body>
	<div class="container">
		<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
		<div class="panel panel-default">
    	<jsp:include page="/WEB-INF/views/nav.jsp"></jsp:include>
    <div class="panel-body">
		<div class="col-lg-3">
			<jsp:include page="/WEB-INF/views/left.jsp"/>
		</div>
		<div class="col-lg-9">
			<table id="content" class="table table-bordered table-hover">
			 <thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			 </thead>
			 <tbody id="view">
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