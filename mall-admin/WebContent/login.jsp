<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
	/*login.jsp*/
	
	관리자 페이지 접속을 위해 제일 먼저 거쳐야 하는 로그인 페이지
	
	로그인 버튼 클릭시 loginAction.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") != null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function() {
			if($("#adminId").val().length < 1){
				alert("아이디를 입력해 주세요.");
				return;
			}else if($("#adminPw").val().length < 1){
				alert("비밀번호를 입력해 주세요.");
				return;
			}
			$("#loginForm").submit();
		});
	});
</script>
</head>
<body>
	<div style="width:60%" class="container form-group">
		<table class="table table-striped table-hover">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<td><h2>관리자 로그인</h2></td>
				</tr>
			</thead>
		</table>
		<form id="loginForm" method="post" action="<%=request.getContextPath() %>/loginAction.jsp">
			<table class="table">
				<tr>
					<td style="width:20%">관리자ID : </td>
					<td><input id="adminId" type="text" name="adminId" class="form-control" value="admin@goodee.com"></td>
				</tr>
				<tr>
					<td>관리자PW : </td>
					<td><input id="adminPw" type="password" name="adminPw" class="form-control" value="1234"></td>
				</tr>
			</table>
			<button id="btn" style="width:30%" class="btn btn-outline-primary" type="button">로그인</button>
		</form>
	</div>
</body>
</html>