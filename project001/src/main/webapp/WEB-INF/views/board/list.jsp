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
   #content th, #content td {
        word-wrap: break-word; /* 내용이 길어지면 자동으로 줄 바꿈 */
        overflow: hidden; /* 넘치는 내용 숨기기 */
    }

    /* 각 열의 너비를 고정 */
    #content th:nth-child(1), #content td:nth-child(1) {
        width: 10%; 
    }

    #content th:nth-child(2), #content td:nth-child(2) {
        width: 40%; 
    }

    #content th:nth-child(3), #content td:nth-child(3) {
        width: 20%; 
    }

    #content th:nth-child(4), #content td:nth-child(4) {
        width: 15%; 
    }

    #content th:nth-child(5), #content td:nth-child(5) {
        width: 15%; 
    }
  </style>
  <script type="text/javascript">
	  $(document).ready(function(){
		  	//페이지 번호 클릭시 이동 하기
		  	var pageFrm=$("#pageFrm");
		  	$(".paginate_button a").on("click", function(e){
		  		e.preventDefault(); 			// a tag의 기능을 막는 부분
		  		var page = $(this).attr("href").split("page=")[1].split("&")[0];  // 페이지 번호 추출
		  	    var cate = new URLSearchParams(window.location.search).get("cate");  // URL에서 cate 추출
		  	    
		  	    var newUrl = "${cpath}/board/cate?cate=" + cate + "&page=" + page;
		  	    window.location.href = newUrl;	
		  	});
		  
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
	  
	  function goContent(event,idx){
		  event.preventDefault();
		  $.ajax({
				 url : "board/count/"+idx,
				 type : "put",
				 dataType : "json",
				 success : function(){
					 window.location.href = "${cpath}/board/content?idx="+idx;
				 },
			  	 error : function(){
			  		 alert("error");
			  	 }
			  });
	  }
	  
	  function goWish(idx){
		  $.ajax({
				 url : "board/wish/"+idx,
				 type : "put",
				 dataType : "json",
				 success : function(data){
					 $("#wish"+idx).text(data.wish);
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
			 	<c:if test="${empty list }">
			 		<tr>
			 			<td align="center" colspan="5">게시글이 없습니다.</td>
			 		</tr>
			 	</c:if>
				<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.idx}</td>					
						<td><a href="${cpath }/board/content?idx=${list.idx}">${list.title}</a></td>					
						<td>${list.userId}</td>					
						<td>${list.indate.split(" ")[0]}</td>					
						<td id="cnt${list.idx }">${list.count}</td>					
					</tr>
				</c:forEach>
			 </tbody>
			</table>
			<!-- 검색창 -->
			<div align="center">
			    <form class="form" action="${cpath}/board/cate?cate=${cate}&page=${cri.page}" method="post" style="text-align: center;">
			        <div style="display: inline-block; margin-right: 10px;">
			            <select name="type" class="form-control">
			                <option value="writer" ${pageMaker.cri.type == 'writer' ? 'selected' : ''}>이름</option>
			                <option value="title" ${pageMaker.cri.type == 'title' ? 'selected' : ''}>제목</option>
			                <option value="content" ${pageMaker.cri.type == 'content' ? 'selected' : ''}>내용</option>
			            </select>
			        </div>
			        <div style="display: inline-block; margin-right: 10px;">
			            <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
			        </div>
			        <button class="btn btn-success" type="submit">Search</button>
			    </form>
			</div>

			<!-- 페이징 START -->
			<div align="center">
			      <ul class="pagination justify-content-center">
				    <!-- 이전처리 -->
				    <c:if test="${pageMaker.prev}">
				        <li class="paginate_button previous page-item">
				            <a class="page-link" href="${cpath}/board/cate?cate=${cate}&page=${pageMaker.startPage-1}">Previous</a>
				        </li>
				    </c:if>
				
				    <!-- 페이지번호 처리 -->
				    <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				        <li class="paginate_button ${pageMaker.cri.page == pageNum ? 'active' : ''} page-item">
				            <a class="page-link" href="${cpath}/board/cate?cate=${cate}&page=${pageNum}">${pageNum}</a>
				        </li>
				    </c:forEach>
				
				    <!-- 다음처리 -->
				    <c:if test="${pageMaker.next}">
				        <li class="paginate_button next page-item">
				            <a class="page-link" href="${cpath}/board/cate?cate=${cate}&page=${pageMaker.endPage+1}">Next</a>
				        </li>
				    </c:if>
				</ul>
			</div>
			<!--  -->
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