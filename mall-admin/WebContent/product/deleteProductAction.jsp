<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<!-- 
	/*deleteProductAction.jsp*/
	
	productOne.jsp페이지에서 삭제버튼 클릭시 오는 상품 삭제 페이지
	해당 상품 삭제 후 productList.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");

	// 상품 아이디 받기
	int productId = Integer.parseInt(request.getParameter("productId"));
	
	// 상품 삭제
	ProductDao productDao = new ProductDao();
	productDao.deleteProduct(productId);
	
	response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
%>