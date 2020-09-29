<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");


	int productId = Integer.parseInt(request.getParameter("productId"));
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	String productSoldout = request.getParameter("productSoldout");
	String productContent = request.getParameter("productContent");
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	
	Product p = new Product();
	p.setProductId(productId);
	p.setProductName(productName);
	p.setProductPrice(productPrice);
	p.setProductContent(productContent);
	p.setProductSoldout(productSoldout);
	p.setCategoryId(categoryId);
	
	ProductDao productDao = new ProductDao();
	productDao.updateProduct(p);
	
	response.sendRedirect("/mall-admin/product/productOne.jsp?productId=" + productId);
%>