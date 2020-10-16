<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*updateProduct.jsp*/
	
	productOne.jsp에서 수정버튼으로 올 수 있는
	상품 내용 수정 페이지.
	
	상품의 내용을 수정 후 수정버튼을 누르면 updateProductAction.jsp페이지로 이동
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
<title>updateProduct</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	.thTitle{text-align:right}
	.tdContent{width:80%}
</style>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function() {
			if($("#productName").val().length < 1){
				alert("상품명을 입력해 주세요.");
				return;
			}else if($("#productPrice").val().length < 1){
				alert("가격을 입력해 주세요.");
				return;				
			}else if($("#productContent").val().length < 1){
				alert("내용을 입력해 주세요.");
				return;				
			}
			$("#modifyProductPicForm").submit();
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
		
		<!-- jsp -->
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
		<form id="updateProductForm" method="post" action="<%=request.getContextPath() %>/product/updateProductAction.jsp?productId=<%=productId%>">
			<table class="table table-bordered">
				<tr>
					<th>상품명 : </th>
					<td><input id="productName" class="form-control" type="text" name="productName" value="<%=p.getProductName()%>"></td>
				</tr>
				<tr>
					<th>가격 : </th>
					<td><input id="productPrice" class="form-control" type="text" name="productPrice" value="<%=p.getProductPrice()%>"></td>
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
					<td><textarea id="productContent" name="productContent" class="form-control" cols="50" rows="10"><%=p.getProductContent()%></textarea></td>
				</tr>
			</table>
			<button id="btn" type="button" class="btn btn-outline-primary">수정완료</button>
		</form>
	</div>
</body>
</html>