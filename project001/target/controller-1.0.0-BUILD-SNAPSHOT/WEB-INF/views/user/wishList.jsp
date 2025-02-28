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
<title>찜목록</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="${cpath }/resources/summernote/summernote-lite.min.js"></script>
  <script src="${cpath }/resources/summernote/summernote-ko-KR.min.js"></script>
  <link rel="stylesheet" href="${cpath }/resources/summernote/summernote-lite.min.css">
  
  
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
			$("[data-toggle='popover']").popover();
			
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
        <jsp:include page="/WEB-INF/views/header.jsp" />
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
                        <tbody>
                            <!-- JSP에서 데이터를 바로 출력 -->
                            <c:forEach var="item" items="${wishList}">
                                <tr>
                                    <td>${item.idx}</td>
                                    <td><a href="${cpath }/board/content?idx=${item.idx}">${item.title}</a></td>
                                    <td><a href="#" data-toggle="popover" data-placement="right" data-trigger="focus" data-content="채팅하기">${item.userId}</a></td>
                                    <td>${item.indate.split(" ")[0] }</td>
                                    <td>${item.count}</td>
                                </tr>
                            </c:forEach>
                            <!-- 찜한 게시물이 없을 경우 -->
                            <c:if test="${empty wishList}">
                                <tr>
                                    <td colspan="5" align="center">아직 찜한 게시물이 없습니다.</td>
                                </tr>
                            </c:if>
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