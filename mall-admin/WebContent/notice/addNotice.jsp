<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
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
				<th><h3>상품 수정</h3></th>
			</tr>
		</table>
		<form method="post" action="<%=request.getContextPath() %>/notice/addNoticeAction.jsp">
			<table class="table table-bordered">
				<tr>
					<th>제목 : </th>
					<td><input class="form-control" type="text" name="noticeTitle"></td>
				</tr>
				<tr>
					<th>내용 : </th>
					<td><textarea name="noticeContent" class="form-control" cols="50" rows="10"></textarea></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-primary">작성</button>
		</form>
	</div>
</body>
</html>