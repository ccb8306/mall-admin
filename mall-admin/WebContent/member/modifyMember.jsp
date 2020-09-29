<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
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
			
			String memberEmail = request.getParameter("memberEmail");
			MemberDao memberDao = new MemberDao();
			Member m = memberDao.selectMemberOne(memberEmail);
			
			// 회원 상태 변경 변수
			String toggle = "";			
			if(request.getParameter("toggle") != null){
				toggle = request.getParameter("toggle");
			}

			// 변경 요청이 들어올 시 회원 상태 변경
			if(toggle.equals("Y")){
				m.setMemberState("N");
			}else if(toggle.equals("N")){
				m.setMemberState("Y");
			}
			
			// 디버깅
			System.out.println(m.getMemberState() +"<--state");
			System.out.println(toggle +"<--toggle");
		%>
		<br><br>
		
		<!-- 회원 정보 수정 폼 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>회원 정보 수정</h3></th>
			</tr>
		</table>
		<form method="post" action="<%=request.getContextPath() %>/member/modifyMemberAction.jsp">
			<table class="table table-bordered">
				<tr>
					<th>Email : </th>
					<td><input class="form-control" readonly="readonly" type="text" name="memberEmail" value="<%=m.getMemberEmail() %>"></td>
				</tr>
				<tr>
					<th>이름 : </th>
					<td><input class="form-control" type="text" name="memberName" value="<%=m.getMemberName()%>"></td>
				</tr>
				<tr>
					<th>가입일 : </th>
					<td><input class="form-control" readonly="readonly" type="text" name="memberDate" value="<%=m.getMemberDate()%>"></td>
				</tr>
				<tr>
					<th>상태 : </th>
					<td>		
						<input type="hidden" name="memberState" value="<%=m.getMemberState()%>">			
						<%
							if(m.getMemberState().equals("Y")){
						%>
							<a href="<%=request.getContextPath()%>/member/modifyMember.jsp?memberEmail=<%=m.getMemberEmail()%>&toggle=Y">활동중</a>
						<%
							}else{
						%>
							<a href="<%=request.getContextPath()%>/member/modifyMember.jsp?memberEmail=<%=m.getMemberEmail()%>&toggle=N">탈퇴</a>
						<%
							}
						%>
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-primary">수정완료</button>
		</form>
	</div>
</body>
</html>