<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*modifyOrdersState.jsp*/
	
	ordersList.jsp에서 한 주문 선택 시 올 수 있는
	주문 상태 수정 페이지.
	
	주문상태를 변경 할 수 있으며 변경후 수정버튼을 누르면
	modifyOrdersStateAction.jsp페이지로 이동
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
		<form action="<%=request.getContextPath() %>/orders/modifyOrdersStateAction.jsp" method="post">
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
			
			<!-- 네비게이션 -->
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/orders/ordersList.jsp">목록</a></li>
			</ul>
		</form>
	</div>
</body>
</html>