<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*noticeOne.jsp*/
	
	noticeList.jsp에서 한 공지사항 클릭시 오는
	공지사항 상세보기 페이지.
	
	공지사항을 수정,삭제 하는 페이지로 이동할 수 있으며
	공지사항 제목 검색이 가능함.
	
	공지사항 수정시 modifyNotice.jsp페이지로 이동
	공지시항 삭제시 deleteNoticeAction.jsp페이지로 이동
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
<title>noticeOne</title>
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
		<br><br>
		
		<!-- jsp -->
		<%
			request.setCharacterEncoding("utf-8");
		
			int noticeId = Integer.parseInt(request.getParameter("noticeId"));
			System.out.println(noticeId + "<-- noticeId");
		
			NoticeDao noticeDao = new NoticeDao();
			Notice n = noticeDao.selectNoticeOne(noticeId);
		%>
		
		<!-- 공지사항 상세보기 -->
		<table class="table table-secondary">
			<tr><td><h3>공지사항 상세보기</h3></td></tr>
		</table>	
		<table class="table table-bordered">
			<tr>
				<th>제목 : </th>
				<td class="tdContent"><%=n.getNoticeTitle()%></td>
			</tr>
			<tr>
				<th>작성일 : </th>
				<td class="tdContent"><%=n.getNoticeDate()%></td>
			</tr>
			<tr>
				<th>내용 : </th>
				<td class="tdContent"><%=n.getNoticeContent()%></td>
			</tr>
		</table>
		
		<!-- 네비게이션 -->
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/notice/noticeList.jsp">목록</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/notice/modifyNotice.jsp?noticeId=<%=n.getNoticeId() %>">수정</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/notice/deleteNoticeAction.jsp?noticeId=<%=n.getNoticeId()%>">삭제</a></li>
		</ul>
	</div>
</body>
</html>