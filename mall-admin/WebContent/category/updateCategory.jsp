<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	
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
<title>updateCategory</title>
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
			if($("#categoryName").val().length < 1){
				alert("카테고리 이름을 입력해 주세요.");
				return;
			}
			$("#updateCategoryForm").submit();
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
		<br><br>
		
		<!-- jsp -->
		<%
			int categoryId = 0; // 받아올 카테고리 아이디
			String categoryCk = null;
			// 수정할 카테고리 id 받기
			if(request.getParameter("categoryId") != null)
				categoryId = Integer.parseInt(request.getParameter("categoryId"));
			
			CategoryDao categoryDao = new CategoryDao();
			Category c = categoryDao.selectCategoryOne(categoryId);
			
			// 토글버튼이 입력되면
			if(request.getParameter("categoryCk") != null){
				categoryCk = request.getParameter("categoryCk");
				
				// 토글 버튼 분기문
				if(categoryCk.equals("Y")){
					c.setCategoryCk("Y");
				}else if(categoryCk.equals("N")){
					c.setCategoryCk("N");
				}
			}
			
		%>
		
		<!-- 카테고리 수정 -->
		<table class="table table-secondary">
			<tr><td><h3>카테고리 수정</h3></td></tr>
		</table>	
		<form id="updateCategoryForm" action="<%=request.getContextPath() %>/category/updateCategoryAction.jsp" method="post">
			<input type="hidden" name="categoryId" value=<%=c.getCategoryId() %>>
			<table class="table table-bordered">
				<tr>
					<th>카테고리 이름 : </th>
					<td class="tdContent"><input id="categoryName" class="form-control" type="text" name="categoryName" value=<%=c.getCategoryName()%>></td>
				</tr>
				<tr>
					<th>추천 카테고리 여부 : </th>
					<td>
					<input type="hidden" name="categoryCk" value=<%=c.getCategoryCk() %>>
					<%
						// 토글버튼
						// Y 이면 N 전달 (N으로 변경)
						if(c.getCategoryCk().equals("Y")){
					%>
						<a href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=c.getCategoryId() %>&categoryCk=N"><%=c.getCategoryCk()%></a>
					<%
						// N 이면 Y 전달 (Y로 변경)
						}else{
					%>
						<a href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=c.getCategoryId() %>&categoryCk=Y"><%=c.getCategoryCk()%></a>
					<%
						}
					%>
					</td>
				</tr>
				<tr>
				</tr>
			</table>	
			<button id="btn" class="btn btn-outline-primary" type="button">수정 완료</button>
		</form>
	</div>
</body>
</html>