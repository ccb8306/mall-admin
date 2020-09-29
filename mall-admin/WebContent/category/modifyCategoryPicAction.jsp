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

	int size = 1024 * 1024 * 100; // 100MB
	String path = application.getRealPath("images"); // 이미지 폴더의 실제 위치
	
	// (request, 경로, 사이즈, 인코딩, 파일 이름(자동생성))
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	int categoryId = Integer.parseInt(multi.getParameter("categoryId"));
	String categoryPic = multi.getFilesystemName("categoryPic");
	
	System.out.println(categoryId + "<--categoryId");
	System.out.println(categoryPic + "<--categoryPic");
	
	// 저장, 쿼리 실행
	CategoryDao categoryDao = new CategoryDao();
	Category c = new Category();
	c.setCategoryId(categoryId);
	c.setCategoryPic(categoryPic);
	
	categoryDao.updateCategoryPic(c);
	
	response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
%>