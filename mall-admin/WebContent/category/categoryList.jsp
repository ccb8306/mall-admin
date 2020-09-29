<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*categoryList.jsp*/
	
	카테고리 목록들을 출력해주는 페이지.
	
	카테고리마다 이름과 사진을 수정하거나 삭제 할 수 있는 페이지로 이동 가능
	이름 수정시 updateCategory.jsp 페이지로 이동
	사진 수정시 modifyCategory.jsp 페이지로 이동
	삭제시 deleteCategoryAction.jsp 페이지로 이동
	
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
<title>categoryList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	.tdname{width:40%}
</style>
</head>
<body>
	<div class="container">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
				
		<!-- jsp -->
		<%
			int currentPage = 1; // 현재 페이지
			int endPage = 1; // 마지막 페이지
			
			// 페이지 값 받기
			if(request.getParameter("currentPage") != null)
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
			// 카테고리 리스트 받기
			CategoryDao categoryDao = new CategoryDao();
			ArrayList<Category> list = categoryDao.selectCategoryList(currentPage);
			
			// Dao클래스에서 최대 페이지 값 메소드 호출
			endPage = categoryDao.getCategoryEndPage();
		%>
		<br><br>
		
		<!-- 카테고리 리스트 출력 -->
		<table class="table table-dark">
			<thead class="thead-light">
				<tr>
					<th><h3>Category List</h3></th>
				</tr>
				<tr>
					<th>
						<ul class="pagination" >	
							<li class="page-item">
								<a style="background-color:white" class="page-link" href="/mall-admin/category/addCategory.jsp">[카테고리 추가하기]</a>
							</li>
						</ul>
					</th>
				</tr>
			</thead>
		</table>
		<table class="table table-striped table-hover]">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<th>category_id</th>
					<th>category_img</th>
					<th class="tdname">category_name</th>
					<th>카테고리 추천</th>
					<th>이름수정</th>
					<th>사진수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Category c : list){
				%>
						<tr>
							<td><%=c.getCategoryId() %></td>
							<td><img src="<%=request.getContextPath() %>/images/<%=c.getCategoryPic() %>" width="50px" height="50px" class="rounded-circle"></td>
							<td class="tdname"><%=c.getCategoryName() %></td>
							<td><%=c.getCategoryCk() %></td>
							<td><a href="<%=request.getContextPath() %>/category/updateCategory.jsp?categoryId=<%=c.getCategoryId()%>&currentPage=<%=currentPage%>">이름수정</a></td>
							<td><a href="<%=request.getContextPath() %>/category/modifyCategoryPic.jsp?categoryId=<%=c.getCategoryId() %>">사진수정</a></td>
							<td><a href="<%=request.getContextPath() %>/category/deleteCategoryAction.jsp?categoryId=<%=c.getCategoryId()%>">삭제</a></td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/category/categoryList.jsp?currentPage=<%=endPage %>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
</body>
</html>