<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*deleteCategoryAction.jsp*/
	
	categoryList.jsp에서 한 카테고리의 삭제버튼을 누를시 올 수 있는 페이지
	삭제할 카테고리 id를 받아오고 Dao에서 삭제쿼리 메서드를 불러옴
	
	삭제 후 categoryList.jsp페이지로 이동
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
	
	// Category클래스에 받은 데이터 저장
	Category category = new Category();
	category.setCategoryId(Integer.parseInt(categoryId));
	
	// 카테고리 메서드를 호출 --> 저장한 categoryId에 해당하는 데이터 삭제
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.deleteCategory(category);
	
	
	response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
%>