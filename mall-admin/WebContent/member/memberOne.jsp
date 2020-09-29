<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
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
		
		<!-- 자바 -->
		<%
			String memberEmail = request.getParameter("memberEmail");
			System.out.println(memberEmail + "<-- memberEmail");
			
			MemberDao memberDao = new MemberDao();
			Member m = memberDao.selectMemberOne(memberEmail);

		
		%>
		
		<!-- 회원 상세보기 -->
		<table class="table table-secondary">
			<tr><td><h3>회원 상세보기</h3></td></tr>
		</table>	
		<table class="table table-bordered">
			<tr>
				<th>Email : </th>
				<td class="tdContent"><%=m.getMemberEmail()%></td>
			</tr>
			<tr>
				<th>이름 : </th>
				<td class="tdContent"><%=m.getMemberName()%></td>
			</tr>
			<tr>
				<th>가입일 : </th>
				<td class="tdContent"><%=m.getMemberDate()%></td>
			</tr>
			<tr>
				<th>상태 : </th>
				<td class="tdContent">		
						<%
							if(m.getMemberState().equals("Y")){
						%>
							활동중
						<%
							}else{
						%>
							탈퇴
						<%
							}
						%>
				</td>
			</tr>
		</table>
		
		<!-- 네비게이션 -->
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/member/memberList.jsp">목록</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/member/modifyMember.jsp?memberEmail=<%=m.getMemberEmail() %>">수정</a></li>
		</ul>
	</div>
</body>
</html>