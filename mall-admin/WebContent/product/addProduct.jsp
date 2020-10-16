<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*addProduct.jsp*/
	
	productList.jsp에 있는 상품 추가 버튼으로
	올 수 있는 상품 추가 페이지.
	
	상품 정보를 입력 한 후 추가 버튼을 누르면 addProductAction.jsp페이지로 이동
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
<title>addProduct</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function() {
			if($("#productName").val() < 1){
				alert("상품명을 입력해 주세요.");
				return;
			}else if($("#productPrice").val().length < 1){
				alert("가격을 입력해 주세요.");
				return;
			}else if($("#productContent").val().length < 1){
				alert("내용을 입력해 주세요.");
				return;
			}
			$("#addProductForm").submit();	
		});
	});
</script>
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴바 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<!-- jsp -->
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
		<form id="addProductForm" method="post" action="<%=request.getContextPath() %>/product/addProductAction.jsp">
			<table class="table table-bordered">
				<tr>
					<th>상품명 : </th>
					<td><input id="productName" class="form-control" type="text" name="productName"></td>
				</tr>
				<tr>
					<th>가격 : </th>
					<td><input id="productPrice" class="form-control" type="text" name="productPrice"></td>
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
					<td><textarea id="productContent" name="productContent" class="form-control" cols="50" rows="10" id="comment" ></textarea></td>
				</tr>
			</table>
			<button id="btn" class="btn btn-outline-primary" type="button">추가하기</button>
		</form>
	</div>
</body>
</html>