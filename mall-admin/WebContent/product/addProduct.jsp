<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addProduct</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container form-group">
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");
			
			CategoryDao categoryDao = new CategoryDao();
			ArrayList<Category> categoryList = categoryDao.selectCategoryList();
			
		%>
		<br><br>
		<!-- 상품 추가 헤드 -->
		<table class="table table-secondary">
			<tr>
				<th><h3>상품 추가</h3></th>
			</tr>
		</table>
		
		<!-- 상품 추가 폼 -->
		<form method="post" action="<%=request.getContextPath() %>/product/addProductAction.jsp">
			<table class="table table-bordered">
				<tr>
					<th>상품명 : </th>
					<td><input class="form-control" type="text" name="productName"></td>
				</tr>
				<tr>
					<th>가격 : </th>
					<td><input class="form-control" type="text" name="productPrice"></td>
				</tr>
				<tr>
					<th>재고 : </th>
					<td>
						<input type="radio" name="productSoldout" value="N" checked="checked"> 판매중&nbsp;&nbsp;&nbsp;  
						<input type="radio" name="productSoldout" value="Y"> 품절
					</td>
				</tr>
				<tr>
					<th>카테고리 : </th>
					<td>
						<select class="form-control" id="sel1" name="categoryId">
							<%
								for(Category c : categoryList){
							%>
									<option value=<%=c.getCategoryId() %>><%=c.getCategoryName() %></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용 : </th>
					<td><textarea name="productContent" class="form-control" cols="50" rows="10" id="comment" ></textarea></td>
				</tr>
			</table>
			<button class="btn btn-outline-primary" type="submit">추가하기</button>
		</form>
	</div>
</body>
</html>