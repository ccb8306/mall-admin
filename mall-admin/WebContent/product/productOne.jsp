<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*productOne.jsp*/
	
	productList.jsp에서 상품 선택시
	해당상품을 상세 보는 페이지.
	
	해당 상품의 이미지 수정, 상태 수정, 내용 수정, 삭제가 가능하며
	이미지 수정시 modifyProductPic.jsp 페이지로 이동,
	상태 수정시 modifyProductSoldoutAction.jsp 페이지로 이동, 
	내용 수정시 updateProduct.jsp 페이지로 이동,
	삭제시 deleteProduct.jsp 페이지로 이동함
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
			request.setCharacterEncoding("utf-8");
		
			int productId = Integer.parseInt(request.getParameter("productId"));
			System.out.println(productId + "<-- productId");
		
			CategoryDao categoryDao = new CategoryDao();
			ArrayList<Category> categoryList = categoryDao.selectCategoryList();
					
			Product p = new ProductDao().selectProductOne(productId);
		%>
		
		<!-- 상품 상세보기 -->
		<table class="table table-secondary">
			<tr><td><h3>상품 상세보기</h3></td></tr>
		</table>	
		<table class="table table-bordered">
			<tr>
				<th>이미지 : </th>
				<td>
					<img width="100%" src="/mall-admin/images/<%=p.getProductPic() %>">
					<a href="<%=request.getContextPath() %>/product/modifyProductPic.jsp?productId=<%=p.getProductId() %>">이미지 수정</a>
				</td>
			</tr>
			<tr>
				<th>상품명 : </th>
				<td class="tdContent"><%=p.getProductName()%></td>
			</tr>
			<tr>
				<th>가격 : </th>
				<td><%=p.getProductPrice()%></td>
			</tr>
			<tr>
				<th>재고 : </th>
				<td>
					<%
						if(p.getProductSoldout().equals("Y")) {
					%>
						<a href="<%=request.getContextPath() %>/product/modifyProductSoldoutAction.jsp?productId=<%=p.getProductId() %>&productSoldout=<%=p.getProductSoldout()%>">[품절]</a>
					<%
						}else{
					%>
						<a href="<%=request.getContextPath() %>/product/modifyProductSoldoutAction.jsp?productId=<%=p.getProductId() %>&productSoldout=<%=p.getProductSoldout()%>">[판매중]</a>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<th>카테고리 : </th>
				<td><%=p.getCategoryId() %></td>
			</tr>
			<tr>
				<th>내용 : </th>
				<td><%=p.getProductContent()%></td>
			</tr>
			<tr>
			</tr>
		</table>
		
		<!-- 네비게이션 -->
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp">목록</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/updateProduct.jsp?productId=<%=p.getProductId() %>">수정</a></li>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/deleteProductAction.jsp?productId=<%=p.getProductId() %>">삭제</a></li>
		</ul>
	</div>
</body>
</html>