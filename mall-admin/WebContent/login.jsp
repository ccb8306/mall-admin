<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
	/*login.jsp*/
	
	������ ������ ������ ���� ���� ���� ���ľ� �ϴ� �α��� ������
	
	�α��� ��ư Ŭ���� loginAction.jsp�������� �̵�
 -->
<%
	// ���������� ���ٽ�
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
				alert("���̵� �Է��� �ּ���.");
				return;
			}else if($("#adminPw").val().length < 1){
				alert("��й�ȣ�� �Է��� �ּ���.");
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
					<td><h2>������ �α���</h2></td>
				</tr>
			</thead>
		</table>
		<form id="loginForm" method="post" action="<%=request.getContextPath() %>/loginAction.jsp">
			<table class="table">
				<tr>
					<td style="width:20%">������ID : </td>
					<td><input id="adminId" type="text" name="adminId" class="form-control" value="admin@goodee.com"></td>
				</tr>
				<tr>
					<td>������PW : </td>
					<td><input id="adminPw" type="password" name="adminPw" class="form-control" value="1234"></td>
				</tr>
			</table>
			<button id="btn" style="width:30%" class="btn btn-outline-primary" type="button">�α���</button>
		</form>
	</div>
</body>
</html>