<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*addOrdersAction.jsp*/
	
	addOrders.jsp에서 추가 버튼으로 올 수 있는 액션 페이지
	addOrders에서 입력한 정보로 주문을 추가해주며
	추가 후 ordersList.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 상품의 id와 가격이 "id,price" 형식으로 전달됨
	// 쉼표를 기준으로 상품의 id와 가격을 나누어 각각 다른 배열에 저장
	String[] product = request.getParameter("productId").split(",");
	
	int productId = Integer.parseInt(product[0]); // 분리된 상품 id
	int productPrice = Integer.parseInt(product[1]); // 분리된 상품 가격
	int ordersAmount = Integer.parseInt(request.getParameter("ordersAmount")); // 주문 개수
	String memberEmail = request.getParameter("memberEmail"); // 주문자 이메일
	int ordersPrice = productPrice * ordersAmount; // 주문 총 금액 = 상품 가격 * 주문 개수 
	String ordersAddr = request.getParameter("ordersAddr"); // 배송지
	String ordersState = request.getParameter("ordersState"); // 주문 상태
	
	// 데이터를 Orders 클래스에 저장
	Orders o = new Orders();
	o.setProductId(productId);
	o.setOrdersAmount(ordersAmount);
	o.setOrdersPrice(ordersPrice);
	o.setMemberEmail(memberEmail);
	o.setOrdersAddr(ordersAddr);
	o.setOrdersState(ordersState);
	
	// Orders 클래스에 저장된 데이터를 데이터베이스에 저장하는 메소드 호출
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.insertOrders(o);
	
	// 주문 리스트로 복귀
	response.sendRedirect(request.getContextPath() + "/orders/ordersList.jsp");
%>
