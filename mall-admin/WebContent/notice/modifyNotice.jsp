<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*modifyNotice.jsp*/
	
	noticeOne.jsp에서 수정버튼으로 올 수 있는 페이지
	해당 공지사항의 내용을 다 불러와
	수정 할 수 있게 출력해줌.
	
	수정 버튼 클릭시 modifyNoticeAction.jsp 페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyNotice</title>
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
			
			// 수정할 공지사항 id
			int noticeId = Integer.parseInt(request.getParameter("noticeId"));

			NoticeDao noticeDao = new NoticeDao();
			Notice n = noticeDao.selectNoticeOne(noticeId);
		%>
		<br><br>
		
		<!-- 공지사항 수정 폼 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>상품 수정</h3></th>
			</tr>
		</table>
		<form id="addNoticeForm" method="post" action="<%=request.getContextPath() %>/notice/modifyNoticeAction.jsp">
			<input type="hidden" name="noticeId" value="<%=n.getNoticeId()%>">
			<table class="table table-bordered">
				<tr>
					<th>제목 : </th>
					<td><input id="noticeTitle" class="form-control" type="text" name="noticeTitle" value="<%=n.getNoticeTitle()%>"></td>
				</tr>
				<tr>
					<th>작성일 : </th>
					<td><input class="form-control" readonly="readonly"  type="text" name="noticeDate" value="<%=n.getNoticeDate()%>"></td>
				</tr>
				<tr>
					<th>내용 : </th>
					<td><textarea id="noticeContent" name="noticeContent" class="form-control" cols="50" rows="10"><%=n.getNoticeContent()%></textarea></td>
				</tr>
			</table>
			<button id="btn" type="button" class="btn btn-outline-primary">수정완료</button>
		</form>
	</div>
</body>
</html>