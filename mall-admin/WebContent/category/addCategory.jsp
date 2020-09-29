<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>addCategory</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<!-- 입력 폼 -->
		<table class="table table-dark">
			<tr>
				<th><h3>Category List</h3></th>
			</tr>
			<tr>
				<td>
					<form method="post" action="/mall-admin/category/addCategoryAction.jsp">
						<div class="input-group mb-3">	
							<input type="text" name="categoryName" class="form-control"  placeholder="Category Name">
							<div class="input-group-prepend">	
								<button type="submit" class="btn btn-outline-warning">카테고리 추가</button>
							</div>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>