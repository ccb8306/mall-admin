<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*updateCategory.jsp*/
	
	categoryList.jsp에서 한 카테고리 수정을 누르면 오는 페이지.
	해당 카테고리를 수정 할 수 있으며 수정 버튼을 누르면
	updateCategoryAction.jsp페이지로 이동.
	
	취소버튼을 누르면 categoryList.jsp로 이동
 -->
<%
	// 비정상적인 접근 시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>updateCategory</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	.tdname{width:60%}
	.tdexc{background-color:#a0a0a0}
</style>
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴바 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<!-- jsp -->
		<%
			int currentPage = 1; // 현재 페이지
			int endPage = 0; // 마지막 페이지
			int categoryId = 0; // 받아올 카테고리 아이디
			
			// 페이지 값 받기
			if(request.getParameter("currentPage") != null)
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
			// 수정할 카테고리 id 받기
			if(request.getParameter("categoryId") != null)
				categoryId = Integer.parseInt(request.getParameter("categoryId"));
			
			CategoryDao categoryDao = new CategoryDao();
			ArrayList<Category> list = categoryDao.selectCategoryList(currentPage);
			
			// Dao클래스에서 최대 페이지 값 메소드 호출
			endPage = categoryDao.getCategoryEndPage();
		%>
		
		<!-- 카테고리 수정 폼 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>카테고리 수정</h3></th>
			</tr>
		</table>
		<form method="post" action="/mall-admin/category/updateCategoryAction.jsp">
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th>category_id</th>
						<th class="tdname">category_name</th>
						<th>수정완료</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Category c : list){
							// 수정할 카테고리 열
							if(categoryId == c.getCategoryId()){
					%>
							<tr>
								<td><input class="form-control" type="text" readonly="readonly" name="categoryId" value=<%=c.getCategoryId() %>></td>
								<td class="tdname"><input class="form-control" type="text" name="categoryName" value=<%=c.getCategoryName() %>></td>
								<td><button class="btn btn-outline-primary" type="submit">수정완료</button></td>
							</tr>
					<%
							}
							// 그 외의 카테고리 열
							else{	
					%>
							<tr>
								<td class="tdexc"><%=c.getCategoryId() %></td>
								<td class="tdexc tdname"><%=c.getCategoryName() %></td>
								<td class="tdexc" colspan="2"></td>
							</tr>
					<%
							}
						}
					%>
				</tbody>
			</table>
		</form>
		
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=categoryId %>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
		
		<!-- 카테고리 리스트로 복귀 -->
		<ul class="pagination">
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp">취소</a>
			</li>
		</ul>
	</div>
</body>
</html>