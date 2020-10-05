<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*updateCategoryAction.jsp*/
	
	updateCategory.jsp에서 수정버튼을 누르면 오는 페이지.
	카테고리 id와 수정할 name을 가져와 해당 카테고리의 이름을 수정하며
	수정 후 categoryList.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");

	// 데이터 받기
	String categoryId = request.getParameter("categoryId");
	String categoryName = request.getParameter("categoryName");
	String categoryCk = request.getParameter("categoryCk");
	
	// 받은 데이터를 Category클래스에 저장
	Category category = new Category();
	category.setCategoryId(Integer.parseInt(categoryId));
	category.setCategoryName(categoryName);
	category.setCategoryCk(categoryCk);
	
	// 수정 메서드 호출
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.updateCategory(category);
	
	
	response.sendRedirect(request.getContextPath() + "/category/categoryOne.jsp?categoryId=" + categoryId);
%>