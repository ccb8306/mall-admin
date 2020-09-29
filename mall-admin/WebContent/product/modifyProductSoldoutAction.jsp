<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<!-- 
	/*modifyProductSoldoutAction.jsp*/
	
	productOne.jsp에서 상품의 상태를 클릭시 오는 액션 페이지
	
	상품의 상태가 판매중이면 품절로 , 품절이면 판매중으로 변경함
	
	변경후 productOne.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 데이터 받기
	int productId = Integer.parseInt(request.getParameter("productId"));
	String productSoldout = request.getParameter("productSoldout");
	
	ProductDao productDao = new ProductDao();
	
	// 상품 상태 수정
	productDao.updateProductSoldout(productId, productSoldout);
	
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productId=" + productId);
%>