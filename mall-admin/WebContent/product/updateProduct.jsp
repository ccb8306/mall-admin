<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateProduct</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	.thTitle{text-align:right}
	.tdContent{width:80%}
</style>
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");
		
			int productId = Integer.parseInt(request.getParameter("productId"));
			System.out.println(productId + "<-- productId");
			
			CategoryDao categoryDao = new CategoryDao();
			ArrayList<Category> categoryList = categoryDao.selectCategoryList();
			
			Product p = new Product();
			
			ProductDao productDao = new ProductDao();
			p = productDao.selectProductOne(productId);
		%>
		<br><br>
		
		<!-- 상품 수정  폼 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>상품 수정</h3></th>
			</tr>
		</table>
		<form method="post" action="/mall-admin/product/updateProductAction.jsp?productId=<%=productId%>">
			<table class="table table-bordered">
				<tr>
					<th>상품명 : </th>
					<td><input class="form-control" type="text" name="productName" value="<%=p.getProductName()%>"></td>
				</tr>
				<tr>
					<th>가격 : </th>
					<td><input class="form-control" type="text" name="productPrice" value="<%=p.getProductPrice()%>"></td>
				</tr>
				<tr>
					<th>재고 : </th>
					<td>
						<input type="hidden" name="productSoldout" value="<%=p.getProductSoldout()%>">
						<%if(p.getProductSoldout() == "Y"){ %>품절
						<%}else { %>판매중<%} %>
						
					</td>
				</tr>
				<tr>
					<th>카테고리 : </th>
					<td>
						<select class="form-control" id="sel1" name="categoryId">
							<%
								for(Category c : categoryList){
							%>
									<option value=<%=c.getCategoryId() %>
									<%
										if(c.getCategoryId() == p.getCategoryId()){
									%>
											selected="selected"
									<%
										}
									%>
									><%=c.getCategoryName() %></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용 : </th>
					<td><textarea name="productContent" class="form-control" cols="50" rows="10"><%=p.getProductContent()%></textarea></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-primary">수정완료</button>
		</form>
	</div>
</body>
</html>