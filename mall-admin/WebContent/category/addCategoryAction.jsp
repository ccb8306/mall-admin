<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 데이터 받기
	String categoryName = request.getParameter("categoryName");
	Category category = new Category();
	category.setCategoryName(categoryName);
	
	// 받은 데이터를 데이터베이스에 추가해주는 메서드 호출
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	
	response.sendRedirect("/mall-admin/category/categoryList.jsp");
%>