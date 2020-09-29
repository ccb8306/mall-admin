<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}

	/*
	int productId = Integer.parseInt(request.getParameter("productId"));
	String productPic = request.getParameter("productPic");
	System.out.println(productId + "<--productId");
	System.out.println(productPic + "<--productPic");
	*/
	
	int size = 1024 * 1024 * 100; // 100MB
	String path = application.getRealPath("images"); // 이미지 폴더의 실제 위치
	
	// (request, 경로, 사이즈, 인코딩, 파일 이름(자동생성))
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	int productId = Integer.parseInt(multi.getParameter("productId"));
	String productPic = multi.getFilesystemName("productPic");
	
	System.out.println(productId + "<--productId");
	System.out.println(productPic + "<--productPic");
	
	// 저장, 쿼리 실행
	Product p = new Product();
	p.setProductId(productId);
	p.setProductPic(productPic);
	
	ProductDao productDao = new ProductDao();
	productDao.updateProductPic(p);
	
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productId=" + productId);
%>