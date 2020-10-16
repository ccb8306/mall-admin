<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*addOrders.jsp*/
	
	ordersList.jsp에서 주문 추가버튼으로 올 수 있는 페이지
	
	주문을 추가하는 페이지이며
	주문 추가시 addOrdersAction.jsp페이지로 이동
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
<title>addOrders</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function() {
			if($("#ordersAmount").val() < 1){
				alert("비정상적인 주문 개수입니다.");
				return;
			}else if($("#memberEmail").val() == "선택"){
				alert("주문자를 선택해 주세요.");
				return;
			}else if($("#ordersAddr").val().length < 1){
				alert("배송지를 입력해 주세요.");
			}
			$("#addOrdersForm").submit();
		});
	});
</script>
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
			
			// 주문자 리스트
			MemberDao memberDao = new MemberDao();
			ArrayList<Member> memberList = memberDao.selectMemberList();
		%>
		
		<!-- 주문 내역 추가 폼 -->
		<table class="table table-secondary">
			<tr><td><h3>주문 추가</h3></td></tr>
		</table>	
		<form id="addOrdersForm" action="<%=request.getContextPath() %>/orders/addOrdersAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<th style="width:20%">주문 상품 : </th>
					<td>
						<div class="input-group-prepend">	
							<select style="width:40%" class="form-control" id="sel1" name="productId">
								<%
									// 선택 상품과 가격을 함께출력 - Action으로 보낼시 상품 id와 상품 가격 두개를 보내줌
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
					<td><input type="text" id="ordersAmount" name="ordersAmount" class="form-control"></td>
				</tr>
				<tr>
					<th>주문자 이메일 : </th>
					<td>
						<select name="memberEmail" id="memberEmail" class="form-control">
							<option>선택</option>
							<%
								for(Member m : memberList){
							%>
								<option value=<%=m.getMemberEmail() %>><%=m.getMemberEmail() %></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>배송지 : </th>
					<td><input type="text" id="ordersAddr" name="ordersAddr" class="form-control"></td>
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
				<li class="page-item"><button id="btn" class="btn btn-outline-primary" type="button">주문 추가</button></li>
			</ul>
		</form>
	</div>
</body>
</html>