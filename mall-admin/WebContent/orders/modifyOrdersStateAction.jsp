<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%

	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	/*
	주문 수정 액션
	주문내역에서 주문 상태만 수정 가능
	*/
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