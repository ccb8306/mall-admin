<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*addCategoryAction.jsp*/
	
	addCategory.jsp에서 추가 버튼을 누르면 올 수 있는 액션 페이지
	
	카테고리 이름을 넘겨받고 db에 저장한 뒤 categoryList.jsp로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
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
	
	
	response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
%>