<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*addNotice.jsp*/
	
	noticeList.jsp에서 공지사항 추가 버튼을 통해서 올 수 있는 페이지.
	공지사항을 추가 할 수 있음.
	
	내용 입력 후 작성 버튼을 누르면 addNoticeAction.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근 시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addNotice</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	.tdContent{width:80%}
</style>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function() {
			if($("#noticeTitle").val().length < 1){
				alert("제목을 작성해 주세요.");
				return;
			}else if($("#noticeContent").val().length < 1){
				alert("내용을 작성해 주세요.");
				return;
			}
			$("#addNoticeForm").submit();
		});
	});
</script>
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");	
		%>
		<br><br>
		
		<!-- 공지사항 작성 폼 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>공지사항 작성</h3></th>
			</tr>
		</table>
		<form id="addNoticeForm" method="post" action="<%=request.getContextPath() %>/notice/addNoticeAction.jsp">
			<table class="table table-bordered">
				<tr>
					<th>제목 : </th>
					<td><input id="noticeTitle" class="form-control" type="text" name="noticeTitle"></td>
				</tr>
				<tr>
					<th>내용 : </th>
					<td><textarea id="noticeContent" name="noticeContent" class="form-control" cols="50" rows="10"></textarea></td>
				</tr>
			</table>
			<button id="btn" type="button" class="btn btn-outline-primary">작성</button>
		</form>
	</div>
</body>
</html>