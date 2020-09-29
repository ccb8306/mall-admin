<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*ordersList.jsp*/
	
	모든 회원들의 주문내역을 출력해주며
	
	주문 상태에 따라 정렬 가능
	
	주문 한개 클릭시 주문상태를 수정할 수 있는
	modifyOrdersState.jsp페이지로 이동
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
<title>ordersList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");
		
			int currentPage = 1; // 현재 페이지
			int rowPage = 10;	// 한 페이지당 출력 개수
			int endPage = 1;	// 최대 페이지
			
			// 현재페이지 값 받기
			if(request.getParameter("currentPage") != null){
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			
			// 주문 상태 값 받기
			String ordersState = "전체"; 
			if(request.getParameter("ordersState") != null){
				ordersState = request.getParameter("ordersState");		
			}
					
			OrdersDao ordersDao = new OrdersDao(); 
			ArrayList<OrdersAndProduct> opList = null;
			ArrayList<String> stateList = ordersDao.selectOrdersStateList();
			
			// 주문 전체 출력
			if(ordersState.equals("전체")){
				opList = ordersDao.selectOrdersList(currentPage, rowPage);
				endPage = ordersDao.getProductEndPage(rowPage);
			// 주문 상태 선택 출력
			}else{
				opList = ordersDao.selectOrdersListbyState(ordersState, currentPage, rowPage);
				endPage = ordersDao.getProductEndPageByState(ordersState, rowPage);
			}
		%>
		
		<!-- 주문 리스트 헤드 -->
		<!-- 주문 상태 선택 옵션 -->
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th colspan="2"><h3>주문 목록</h3></th>
				</tr>
				<tr>
					<th style="text-align:middle">
						<a style="background-color:white; width:35%" class="page-link" href="<%=request.getContextPath() %>/orders/addOrders.jsp">[주문내역 추가하기]</a>
					</th>
					<th style="text-align:right">
						<form method="post" action="/mall-admin/orders/ordersList.jsp">
							<div class="input-group-prepend">	
								<select style="width:50%" class="form-control" id="sel1" name="ordersState">
									<option>전체</option>
									<%
										for(String s : stateList){
									%>
										<option value=<%=s %> 
										<%
											if(ordersState.equals(s)){
										%>
											selected="selected"
										<%
											}
										%>
										><%=s %></option>
									<%
										}
									%>
								</select>
								<button class="btn btn-outline-primary" type="submit">조회</button>
							</div>
						</form>	
					</th>
				</tr>
			</thead>
		</table>
		
		<!-- 주문 리스트 출력 -->
		<table class="table table-striped table-hover">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<th>주문 ID</th>
					<th>상품 ID</th>
					<th style="width:15%">상품 이름</th>
					<th>상품 개수</th>
					<th>총 금액</th>
					<th>주문자 Email</th>
					<th>배달 주소</th>
					<th>상태</th>
					<th style="width:15%">주문일</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(OrdersAndProduct op : opList){
				%>
				<tr>
					<td><%=op.getOrders().getOrdersId() %></td>
					<td><%=op.getOrders().getProductId() %></td>
					<td><%=op.getProduct().getProductName() %></td>
					<td><%=op.getOrders().getOrdersAmount() %></td>
					<td><%=op.getOrders().getOrdersPrice() %></td>
					<td><%=op.getOrders().getMemberEmail() %></td>
					<td><%=op.getOrders().getOrdersAddr() %></td>
					<td><%=op.getOrders().getOrdersState() %></td>
					<td><%=op.getOrders().getOrdersDate() %></td>
					<td><a href="<%=request.getContextPath() %>/orders/modifyOrdersState.jsp?ordersId=<%=op.getOrders().getOrdersId()%>">수정</a></td>
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
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp?ordersState=<%=ordersState %>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
</body>
</html>