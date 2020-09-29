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
<title>addOrders</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container form-group">
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<br><br>
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");
			
			// 상품 리스트 
			ProductDao productDao = new ProductDao();
			ArrayList<Product> productList = productDao.selectProductList();
			
			// 주문 상태 리스트 
			OrdersDao ordersDao = new OrdersDao();
			ArrayList<String> stateList = ordersDao.selectOrdersStateList();
		%>
		
		<!-- 주문 내역 추가 폼 -->
		<table class="table table-secondary">
			<tr><td><h3>주문 추가</h3></td></tr>
		</table>	
		<form action="<%=request.getContextPath() %>/orders/addOrdersAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<th style="width:20%">주문 상품 : </th>
					<td>
						<div class="input-group-prepend">	
							<select style="width:40%" class="form-control" id="sel1" name="productId">
								<%
									// 선택 상품과 가격을 출력 - Action으로 보낼시 상품 id와 상품 가격 두개를 보내줌
									for(Product p : productList){
										
										// 품절이 아닌 상품만 선택 항목에 추가
										if(p.getProductSoldout().equals("N")){
								%>
										<option value="<%=p.getProductId() %>,<%=p.getProductPrice() %>"><%=p.getProductName() %> : <%=p.getProductPrice() %>원</option> 
								<%
										}
									}
								%>
							</select>
						</div>
					</td>		
				</tr>
				<tr>
					<th>주문 개수 : </th>
					<td><input type="text" name="ordersAmount" class="form-control"></td>
				</tr>
				<tr>
					<th>주문자 이메일 : </th>
					<td><input type="text" name="memberEmail" class="form-control"></td>
				</tr>
				<tr>
					<th>배송지 : </th>
					<td><input type="text" name="ordersAddr" class="form-control"></td>
				</tr>
				<tr>
					<th>주문 상태 : </th>
					<td>
						<div class="input-group-prepend">	
							<select style="width:40%" class="form-control" id="sel1" name="ordersState">
								<%
									for(String s : stateList){
								%>
									<option value=<%=s %>><%=s %></option>
								<%
									}
								%>
							</select>
						</div>
					</td>
				</tr>
			</table>
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp">목록</a></li>
				<li class="page-item"><button class="btn btn-outline-primary" type="submit">주문 추가</button></li>
			</ul>
		</form>
	</div>
</body>
</html>