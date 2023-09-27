<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/> --%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>WebBBS</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
		var msg = "${msg}";
		if(msg == "WRT_ERR") {
			alert('게시물 등록에 실패했습니다. 다시 시도해 주세요.');
		}
	</script>
</head>
<body>
	<div id="menu">
		<ul>
			<li id="logo">WebBBS</li>
		<li><a href="<c:url value='/'/>">Home</a></li>
		<li><a href="<c:url value='/board/list'/>">Board</a></li>
		<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
		<li><a href="<c:url value='/register/add'/>">Sign in</a></li>
		<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul> 
	</div>
	<div style="text-align:center">
		<h2>게시물 ${mode == "new" ? "글쓰기" : "읽기"}</h2>
		<form action="" id="form">
			<input type="hidden" name="bno" 	value="${boardDto.bno}" 	readonly="readonly"/>
			<input type="text" 	 name="title" 	value="${boardDto.title}" 	${mode == "new" ? '' : 'readonly = "readonly"' }/>
			<textarea id=""    	 name="content"  cols="30" 	rows="10" 		${mode == "new" ? '' : 'readonly = "readonly"' }>
				${boardDto.content}
			</textarea>
			<button type="button" id="writeBtn"  class="btn">글쓰기</button>
			<button type="button" id="modifyBtn" class="btn">수정</button>
			<button type="button" id="removeBtn" class="btn">삭제</button>
			<button type="button" id="listBtn"   class="btn">목록</button>
		</form>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function () {
			// 목록 버튼
			$("#listBtn").on("click", function() {
				location.href="<c:url value='/board/list'/>?page=${page}&pageSize=${pageSize}";
			});
			
			
			// 쓰기
			$("#writeBtn").on("click", function(){
				var form = $("#form");
				form.attr("action", "<c:url value='/board/write'/>");
				form.attr("method", "post");
				form.submit();
			});
			
			
			// 수정
			$("#modifyBtn").on("click", function(){
				// 1. 읽기 상태이면 수정 상태로 변경
				var form = $("#form");
				var isReadOnly = $("input[name=title]").attr("readonly");
				
				if(isReadOnly == 'readonly') {
					$("input[name=title]").attr('readonly', false);
					$("textarea[name=content]").attr('readonly', false);
					$("#modifyBtn").html('등록');
					$("h2").html('게시물 수정');
					return; // 수정 모드로 바꾼 상태에서 빠져나와야 함.
				}
				
				// 2. 수정 상태이면, 수정된 내용을 서버로 전송
				form.attr("action", "<c:url value='/board/modify'/>");
				form.attr("method", "post");
				form.submit();
			});
			
			
			// 삭제
			$("#removeBtn").on("click", function(){
				if(!confirm("정말로 삭제하시겠습니까?")) return;
				let form = $("#form");
				form.attr("action", "<c:url value='/board/remove'/>?page=${page}&pageSize=${pageSize}");
				form.attr("method", "post");
				form.submit();
			});
			
			
			
			
		});
	</script>
</body>
</html>