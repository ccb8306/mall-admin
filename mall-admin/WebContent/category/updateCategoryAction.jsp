<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
	request.setCharacterEncoding("utf-8");

	// 데이터 받기
	String categoryId = request.getParameter("categoryId");
	String categoryName = request.getParameter("categoryName");
	
	// 받은 데이터를 Category클래스에 저장
	Category category = new Category();
	category.setCategoryId(Integer.parseInt(categoryId));
	category.setCategoryName(categoryName);
	
	// 수정 메서드 호출
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.updateCategory(category);
	
	
	response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
%>