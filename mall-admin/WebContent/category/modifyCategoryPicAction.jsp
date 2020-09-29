<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 
	/*modifyCategoryPicAction.jsp*/
	
	modifyCategoryPic.jsp에서 사진을 첨부하고 수정 버튼을 누르면 오는 페이지.
	사진이름과 카테고리 id를 받아와서 해당 카테고리에 사진을 수정해줌.
	
	수정 후 categoryList.jsp로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	int size = 1024 * 1024 * 100; // 100MB - 최대 크기
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