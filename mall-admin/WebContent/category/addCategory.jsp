<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- 
	/*addCategory.jsp*/
	
	카테고리 추가 페이지.
	
	카테고리 이름을 넣고 추가버튼을 누르면 addCategoryAction.jsp페이지로 이동
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
<meta charset="utf-8">
<title>addCategory</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function() {
			if($("#categoryName").val().length < 1){
				alert("카테고리 이름을 입력해 주세요.");
				return;
			}
			$("#addCategoryForm").submit();
		});
	});
</script>
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
					<form id="addCategoryForm" method="post" action="/mall-admin/category/addCategoryAction.jsp">
						<div class="input-group mb-3">	
							<input id="categoryName" type="text" name="categoryName" class="form-control"  placeholder="Category Name">
							<div class="input-group-prepend">	
								<button id="btn" type="button" class="btn btn-outline-warning">카테고리 추가</button>
							</div>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>