<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*updateProductAction.jsp*/
	
	updateProduct.jsp에서 수정버튼으로 오는 액션 페이지
	
	변경사항을 db에 적용시킨 후 productOne.jsp로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");

	
	// 상품 데이터 받기
	int productId = Integer.parseInt(request.getParameter("productId"));
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	String productSoldout = request.getParameter("productSoldout");
	String productContent = request.getParameter("productContent");
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	
	// Product에 상품 데이터 저장
	Product p = new Product();
	p.setProductId(productId);
	p.setProductName(productName);
	p.setProductPrice(productPrice);
	p.setProductContent(productContent);
	p.setProductSoldout(productSoldout);
	p.setCategoryId(categoryId);
	
	// 상품 수정
	ProductDao productDao = new ProductDao();
	productDao.updateProduct(p);
	
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productId=" + productId);
%>