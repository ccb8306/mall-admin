<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	if(session.getAttribute("loginAdminId") != null){
		response.sendRedirect("/mall-admin/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div style="width:60%" class="container form-group">
		<table class="table table-striped table-hover">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<td><h2>������ �α���</h2></td>
				</tr>
			</thead>
		</table>
		<form method="post" action="/mall-admin/loginAction.jsp">
			<table class="table">
				<tr>
					<td style="width:20%">������ID : </td>
					<td><input type="text" name="adminId" class="form-control"></td>
				</tr>
				<tr>
					<td>������PW : </td>
					<td><input type="password" name="adminPw" class="form-control"></td>
				</tr>
			</table>
			<button style="width:30%" class="btn btn-outline-primary" type="submit">�α���</button>
		</form>
	</div>
</body>
</html>