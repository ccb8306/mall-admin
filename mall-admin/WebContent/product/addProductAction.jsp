<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*addProductAction.jsp*/
	
	addProduct.jsp페이지에서 추가 버튼 클릭시 오는 페이지
	입력한 정보의 상품을 db에 추가 한 후
	productList.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 상품 정보 받기
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	String productSoldout = request.getParameter("productSoldout");
	String productContent = request.getParameter("productContent");
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	
	// 상품 정보 Product에 저장
	Product p = new Product();
	p.setProductName(productName);
	p.setProductPrice(productPrice);
	p.setProductContent(productContent);
	p.setProductSoldout(productSoldout);
	p.setCategoryId(categoryId);
	
	// 상품 추가
	ProductDao productDao = new ProductDao();
	productDao.insertProduct(p);
	
	response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
%>
