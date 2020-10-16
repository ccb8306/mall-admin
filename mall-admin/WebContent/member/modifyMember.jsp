<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*modifyMember.jsp*/
	
	memberOne.jsp에서 수정버튼으로 올 수 있는 페이지.
	
	한 회원의 이름을 수정하거나 상태를 변경 할 수 있음.
	
	회원상태 수정은 토글버튼으로 클릭시, 활동중 -> 탈퇴로, 탈퇴 -> 활동중 으로 변경 가능
	
	모든 수정사항은 수정버튼을 눌러야 적용되며
	수정버튼 클릭시 modifyMemberAction.jsp페이지로 이동
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
			if($("#memberName").val().length < 1){
				alert("이름을 입력해 주세요.");
				return;
			}
			$("#modifyMemberForm").submit();
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
			
			String memberEmail = request.getParameter("memberEmail");
			MemberDao memberDao = new MemberDao();
			Member m = memberDao.selectMemberOne(memberEmail);
			
			// 회원 상태 변경 변수
			String state = "";			
			if(request.getParameter("state") != null){
				state = request.getParameter("state");

				// 변경 요청이 들어올 시 회원 상태 변경
				if(state.equals("N")){
					m.setMemberState("N");
				}else if(state.equals("Y")){
					m.setMemberState("Y");
				}
			}			
			
			// 디버깅
			System.out.println(m.getMemberState() +"<--state");
			System.out.println(state +"<--state");
		%>
		<br><br>
		
		<!-- 회원 정보 수정 폼 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>회원 정보 수정</h3></th>
			</tr>
		</table>
		<form id="modifyMemberForm" method="post" action="<%=request.getContextPath() %>/member/modifyMemberAction.jsp">
			<table class="table table-bordered">
				<tr>
					<th>Email : </th>
					<td><input class="form-control" readonly="readonly" type="text" name="memberEmail" value="<%=m.getMemberEmail() %>"></td>
				</tr>
				<tr>
					<th>이름 : </th>
					<td><input id="memberName" class="form-control" type="text" name="memberName" value="<%=m.getMemberName()%>"></td>
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
							<a href="<%=request.getContextPath()%>/member/modifyMember.jsp?memberEmail=<%=m.getMemberEmail()%>&state=N">활동중</a>
						<%
							}else{
						%>
							<a href="<%=request.getContextPath()%>/member/modifyMember.jsp?memberEmail=<%=m.getMemberEmail()%>&state=Y">탈퇴</a>
						<%
							}
						%>
					</td>
				</tr>
			</table>
			<button id="btn" type="button" class="btn btn-outline-primary">수정완료</button>
		</form>
	</div>
</body>
</html>