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
<title>Insert title here</title>
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

			int categoryId = 0; // 받아올 카테고리 아이디
			
			// 수정할 카테고리 id 받기
			if(request.getParameter("categoryId") != null)
				categoryId = Integer.parseInt(request.getParameter("categoryId"));
			
			CategoryDao categoryDao = new CategoryDao();
			Category c = categoryDao.selectCategoryOne(categoryId);
		%>
		
		<!-- 카테고리 상세보기 -->
		<table class="table table-secondary">
			<tr><td><h3>카테고리 상세보기</h3></td></tr>
		</table>	
		<table class="table table-bordered">
			<tr>
				<th>이미지 : </th>
				<td>
					<img width="50%" src="/mall-admin/images/<%=c.getCategoryPic() %>"><br>
					<a href="<%=request.getContextPath() %>/category/modifyCategoryPic.jsp?categoryId=<%=c.getCategoryId() %>">이미지 수정</a>
				</td>
			</tr>
			<tr>
				<th>카테고리 이름 : </th>
				<td class="tdContent"><%=c.getCategoryName()%></td>
			</tr>
			<tr>
				<th>추천 카테고리 여부 : </th>
				<td><%=c.getCategoryCk()%></td>
			</tr>
			<tr>
			</tr>
		</table>
		
		<!-- 네비게이션 -->
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp">목록</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=c.getCategoryId() %>">수정</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/deleteCategoryAction.jsp?categoryId=<%=c.getCategoryId() %>">삭제</a></li>
		</ul>
	</div>
</body>
</html>