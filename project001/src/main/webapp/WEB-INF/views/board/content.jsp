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
  <link rel="stylesheet" href="${cpath }/resources/css/signUp.css"/>
  <script src="${cpath }/resources/summernote/summernote-lite.min.js"></script>
  <script src="${cpath }/resources/summernote/summernote-ko-KR.min.js"></script>
  <link rel="stylesheet" href="${cpath }/resources/summernote/summernote-lite.min.css">
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  
  <style type="text/css">
  input[id="writer"]{
    border: none;
    outline: none;
	}
	
	.note-editable {
	    min-height: 200px;
	    max-width: 100%;
	    height: auto;
	    overflow-y: hidden;
	    background-color: #f9f9f9; /* 배경색 추가 */
	    border: 1px solid #ddd; /* 테두리 추가 */
	    border-radius: 5px; /* 모서리 둥글게 */
	    box-shadow: inset 0 1px 3px rgba(0,0,0,0.1); /* 내부 그림자 효과 */
	}

	
  </style>
  
  <script type="text/javascript">
	  $(document).ready(function(){
		  Kakao.init("782641dcfe4027b981fa21c61b108159");
		  $('#summernote').summernote({
			  airMode: true,             // 에어모드 활성화
			  disableResizeEditor: true, // 에디터 크기 조절 비활성화
			  toolbar: [],               // 툴바 비활성화
			}).summernote('disable');    // 에디터를 읽기 전용으로 설정


		  
		  loadReply();
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
	  
	  function loadReply(){
		  var post_id = ${b.idx};
		  $.ajax({
				 url : "${cpath}/board/replylist",
				 type : "get",
				 data : {"post_id" : post_id},
				 dataType : "json",
				 success : replyView,
				 error : function(){alert("error");}
			  });
	  }
	  function goReplyDelete(idx){
		  $('#deleteModal').modal('show');
		  $('#confirmDelete').on('click', function() {
			  $.ajax({
				  url: "${cpath}/board/replyDelete",
				  type: "get",
				  data: {"idx":idx},
				  success: function(){
					  $('#deleteModal').modal('hide');
					  loadReply();
				  },
				  error: function(){alert("error");}
			  });
		  });
	  }
	  
	  function replyView(data){
		    var listHtml = "";
		    listHtml+="<tr><td><span><img class='img-circle' src='${cpath}/images/profile/${u.user.userProfile}'></span>&nbsp ${u.user.userId }</td>";
		    listHtml+="<td colspan='4'><textarea id='replyContent' name='replyContent' class='form-control'"
		    listHtml+="placeholder='${empty u ? '로그인 후 이용하세요' : '댓글을 입력하세요'}'";
		    listHtml+="${empty u ? ' readonly' : ''}></textarea>";
		    listHtml+="<td align='center'>";
		    listHtml+="<button type='button' class='btn btn-primary btn-sm' onclick='reply(${b.idx})' ${empty u ? 'disabled' : ''}>등록</button>";
		    listHtml+="</td>";
		    listHtml+="</tr>";

		    $.each(data, function(index, obj){
		        //들여쓰기
		    	var indentTd = "";
		        var colspanValue = 6;
		        if (obj.reLevel == 1) {
		            indentTd = "<td style='text-align: right;'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'>";
		            indentTd+="<path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5'/>";
		            indentTd+="</svg></td>";
		        }
		        if (obj.reLevel >= 2) {
		            indentTd = "<td></td>";
		            indentTd+= "<td style='text-align: right;'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'>";
		            indentTd+="<path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5'/>";
		            indentTd+="</svg></td>";
		        }
		        
		     	// 댓글 출력
		        listHtml+= "<tr>";
		        listHtml+= indentTd;
		        listHtml+= "<td colspan='" + colspanValue + "'>";
		        listHtml+= "<div style='display: flex; justify-content: space-between; align-items: flex-start;'>";
		        listHtml+= "<div style='flex-grow: 1;'>";
		        listHtml+= "<div>";
		        listHtml+= "<span style='display: inline-block; vertical-align: middle;'>" + obj.userId + "</span>";
		        listHtml+= "<span style='display: inline-block; vertical-align: middle; margin-left: 10px; font-size: 12px; color: #999999;'>" + obj.indate.substring(0,16) + "</span>";
		        listHtml+= "</div>";
		        listHtml+= "<div style='margin-top: 5px; min-height: 50px; height: auto; overflow: auto; word-wrap: break-word; padding: 10px;'>" + obj.content + "</div>";
		        listHtml+= "</div>";
		        listHtml+= "<div style='text-align: right; white-space: nowrap;'>";
		        listHtml+= "<a href='javascript:goReReply(" + obj.idx + ")' class='glyphicon glyphicon-comment'></a>&nbsp;";
		        if ("${u.user.userId}" == obj.userId) {
		            listHtml+= "<a href='javascript:goReplyDelete(" + obj.idx + ")' class='glyphicon glyphicon-trash'></a>";
		        }
		        listHtml+= "</div></div></td></tr>";


		        // 대댓글 입력폼
		        listHtml+="<tr id='rr"+obj.idx+"' style='display:none;'>";
		        listHtml+=indentTd; // 대댓글 입력폼에도 동일한 들여쓰기 적용
		        listHtml+="<td>${u.user.userId}</td>";
		        listHtml+="<td colspan='"+colspanValue+"'>";
		        listHtml+="<textarea id='reContent"+obj.idx+"' class='form-control' placeholder='댓글을 입력하세요.'></textarea>";
		        listHtml+="<button type='submit' class='btn btn-primary btn-sm' onclick='replyAdd("+obj.idx+")'>등록</button>";
		        listHtml+="</td>";
		        listHtml+="</tr>";
		    });

		    $("#replyView").html(listHtml);
		}

	  
	  function reply(idx){
		  var content = $("#replyContent").val();
		  $.ajax({
			 url: "${cpath}/board/reply",
			 type: "post",
			 data: {"post_id":idx, "content":content},
			 beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			 },
			 success: function(){
				 $("#replyContent"+idx).val("");
				 loadReply();
			 },
			 error: function(){alert("error");}
		  });
	  }
	  
	  function goReReply(idx){
		  if($("#rr"+idx).css("display")=="none"){
			  $("tr[id^='rr']").css("display", "none");	//닫기
			  $("#rr"+idx).css("display","table-row");
		  }else{
			  $("#rr"+idx).css("display","none");
		  }
	  }
	  
	  function replyAdd(idx){
		  var content = $("#reContent"+idx).val();
		  $.ajax({
			 url: "${cpath}/board/replyAdd",
			 type: "post",
			 data: {"idx":idx, "content":content},
			 beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			 },
			 success: function(){
				 loadReply();
			 },
			 error: function(){alert("error");}
		  });
	  }
	  
	  function goWish(idx){
		  $.ajax({
				 url : "${cpath}/board/wish/"+idx,
				 type : "put",
				 dataType : "json",
				 beforeSend : function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				 },
				 success : function(data){
					 $("#wish"+idx).text(data.wish);
				 },
			  	 error : function(){
			  		 alert("error");
			  	 }
			  });
	  }
	  
	  function showDeleteModal(idx){
		  $('#deleteModal').modal('show');
		  
	      $('#confirmDelete').on('click', function() {
	        location.href = '${cpath}/board/delete?idx=' + idx;
	      });
	  }
	  
	  function shareKakao() {
		    var currentURL = window.location.href;

		    Kakao.Share.sendDefault({
		        objectType: 'text',
		        text: 'Trip Friends에서 내용을 확인하세요!',
		        link: {
		            mobileWebUrl: currentURL, 
		            webUrl: currentURL
		        },
		        buttons: [
		            {
		                title: '웹으로 보기',
		                link: {
		                    mobileWebUrl: currentURL,
		                    webUrl: currentURL
		                }
		            }
		        ]
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
		  <p class="title">게시글 </p>
				<table class="table">
					<tr>
						<td>작성자</td>
						<td>${b.userId }</td>
						<td>작성일</td>
						<td>${b.indate.split(' ')[0] }</td>
						<td>조회수</td>
						<td>${b.count }</td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td>제목</td>
						<td colspan="5">${b.title }</td>
					</tr>
					<tr>
					    <td>내용</td>
					    <td colspan="5">
					        <textarea class="form-control" id="summernote" style="padding: 20px;">
					        	${b.content }
					        </textarea>
					    </td>
					</tr>

					<tr>
						<td colspan="6" align="center">
							<c:if test="${empty u}">
								<button data-btn="list" class="btn btn-success btn-sm" onclick="history.go(-1);">목록</button>
							</c:if>
							<c:if test="${!empty u }">
								<c:if test="${u.user.userId eq b.userId }">
									<button data-btn="modify" class="btn btn-info btn-sm" onclick="location.href='${cpath}/board/modify?idx=${b.idx}'">수정화면</button>
									<button data-btn="delete" class="btn btn-warning btn-sm" onclick="showDeleteModal(${b.idx})">삭제</button>
									<button data-btn="list" class="btn btn-success btn-sm" onclick="history.go(-1);">목록</button>
								</c:if>
								<c:if test="${u.user.userId ne b.userId }">
									<button class="btn btn-info btn-sm" onclick="goWish(${b.idx})">
										찜 <span id="wish${b.idx }">${b.wish }</span>
									</button>
									<button data-btn="list" class="btn btn-success btn-sm" onclick="history.go(-1);">목록</button>
								</c:if>
							</c:if>
							<a id="kakaotalk-sharing-btn" href="javascript:shareKakao();" style="float: right;">
  								<img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_small.png" alt="카카오톡 공유 보내기 버튼" />
  							</a>
						</td>
					</tr>
					<tbody id="replyView">
						<tr>
							<td>작성자 이름</td>
							<td colspan="3">댓글 내용</td>
							<td>댓글 작성일</td>
							<td align="right">답글 달기 버튼</td>
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

<!-- 삭제 확인여부 모달창 -->
<div id="deleteModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
    <div class="modal-content panel-info">
        <div class="modal-header panel-heading">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">삭제 확인</h4>
        </div>
        <div class="modal-body">
          <p>정말 삭제하시겠습니까?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">아니오</button>
          <button type="button" class="btn btn-danger" id="confirmDelete">예</button>
        </div>
      </div>
    </div>
</div>
  
</body>
</html>