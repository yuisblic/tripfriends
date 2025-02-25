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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${cpath }/resources/css/signUp.css"/>
  <script src="${cpath }/resources/summernote/summernote-lite.min.js"></script>
  <script src="${cpath }/resources/summernote/summernote-ko-KR.min.js"></script>
  <link rel="stylesheet" href="${cpath }/resources/summernote/summernote-lite.min.css">
  
  <style type="text/css">
	  input[id="writer"]{
	    border: none;
	    outline: none;
		}
  </style>
  
  <script type="text/javascript">
	  $(document).ready(function(){
		  var csrfHeaderName = "${_csrf.headerName}";
		  var csrfTokenValue = "${_csrf.token}";
		  
		  $('#summernote').summernote({
		        placeholder: '내용을 입력하세요.',
		        tabsize: 2,
		        height: 200,
		        toolbar: [
		            ['style', ['style']],
		            ['font', ['bold', 'underline', 'clear']],
		            ['color', ['color']],
		            ['para', ['ul', 'ol', 'paragraph']],
		            ['table', ['table']],
		            ['insert', ['link', 'picture']],
		            ['view', ['fullscreen', 'codeview', 'help']]
		        ],
		        callbacks : {                                                    
					onImageUpload : function(files, editor, welEditable) {
						for (var i = 0; i < files.length; i++) {
							imageUploader(files[i], this);
						}
					}
				}
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
	  
	  function imageUploader(file, el){
		  var formData = new FormData();
		  formData.append('file',file);
		  
		  $.ajax({
			  url: "${cpath}/board/imageUpload",
			  type: "post",
			  data: formData,
			  contentType: false,
			  processData: false,
			  enctype: "multipart/form-data",
			  beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			  },
			  success: function(data){
				  $(el).summernote("insertImage","${cpath}"+data, function($image){
					  $image.css("width","100%");
				  });
			  },
			  error: function(){alert("error!");}
		  })
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
		  <p class="title">글쓰기 </p>
			<form action="${cpath }/board/register" method="post">
				<input type="hidden" name="userId" value="${u.user.userId }"/>
				<table class="table table-bordered">
					<tr>
						<td>여행지</td>
						<td>
						  <select name="categori" required>
						  	<option value="" disabled selected>카테고리를 선택하세요.</option>
						  	<option value="jp">일본</option>
						  	<option value="eu">유럽</option>
						  	<option value="sa">동남아</option>
						  	<option value="mg">몽골</option>
						  	<option value="etc">그 외 국가</option>
						  </select>
		      			</td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" id="title" name="title" class="form-control" required/></td>
					</tr>
					<tr>
						<td colspan="2"><textarea id="summernote" name="content" class="form-control" required></textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" id="writer" name="writer" value="${u.user.userName }" readonly/></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button type="submit" class="btn btn-success btn-sm">등록</button>
							<button type="reset" class="btn btn-warning btn-sm">취소</button>
							<button type="button" class="btn btn-info btn-sm" onclick="location.href='${cpath}/'">목록</button>
						</td>
					</tr>
				</table>
				<!-- 스프링 시큐리티 토큰값 전달 -->
    	 		<input type="hidden"name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
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