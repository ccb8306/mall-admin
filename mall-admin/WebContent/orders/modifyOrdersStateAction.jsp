<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*modifyOrdersStateAction.jsp*/
	
	modifyOrdersState.jsp에서 수정버튼으로 오는 액션 페이지.
	해당 주문내역을 입력한 state값으로 수정해줌
	
	수정후 modifyOrdersState.jsp로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");

	int ordersId = Integer.parseInt(request.getParameter("ordersId")); // 주문 id
	String ordersState = request.getParameter("ordersState"); // 주문 상태
	
	// 받은 값드을 Orders에 저장
	Orders o = new Orders();
	o.setOrdersId(ordersId);
	o.setOrdersState(ordersState);
	
	// Orders에 저장된 내용을 데이터 베이스에 적용시키는 메서드 호출
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.updateOrdersState(o);
	
	// 이전 페이지로 복귀
	response.sendRedirect(request.getContextPath() + "/orders/modifyOrdersState.jsp?ordersId=" + ordersId);
%>