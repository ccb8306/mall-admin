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
		
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");
			
			// 수정할 주문 내역 id 받기
			int ordersId = Integer.parseInt(request.getParameter("ordersId"));
			System.out.println(ordersId + "<-- productId");
			
			
			// 수정할 주문 내역 상세보기 메서드 호출
			OrdersDao ordersDao = new OrdersDao();
			Orders o = new Orders();
			o = ordersDao.selectOrdersOne(ordersId);
			
			ArrayList<String> stateList = ordersDao.selectOrdersStateList();
		%>
		
		<table class="table table-secondary">
			<tr><td><h3>주문내역 상세보기</h3></td></tr>
		</table>	
		
		<!-- 주문상태 수정 폼 -->	
		<form action="/mall-admin/orders/modifyOrdersStateAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<th>주문 ID : </th>
					<td class="tdContent"><%=o.getOrdersId()%> <input type="hidden" name="ordersId" value="<%=o.getOrdersId()%>"></td>
				</tr>
				<tr>
					<th>주문 상태 : </th>
					<td>
						<div class="input-group-prepend">	
							<select style="width:40%" class="form-control" id="sel1" name="ordersState">
								<%
									for(String s : stateList){
								%>
									<option value=<%=s %> 
									<%
										if(o.getOrdersState().equals(s)){
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
							<button class="btn btn-outline-primary" type="submit">수정</button>
						</div>
					</td>
				</tr>
			</table>
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="/mall-admin/orders/ordersList.jsp">목록</a></li>
			</ul>
		</form>
	</div>
</body>
</html>