<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 
	/*modifyProductPicAction.jsp*/
	
	modifyProductPic.jsp에서 수정 버튼으로 오는 액션 페이지
	수정할 상품 id와 상품 이미지를 받아 해당 상품의 이미지를 수정해줌
	
	수정 후 productOne.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}
	
	int size = 1024 * 1024 * 100; // 100MB - 최대 사이즈
	String path = application.getRealPath("images"); // 이미지 폴더의 실제 위치
	
	// (request, 경로, 사이즈, 인코딩, 파일 이름(자동생성))
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	int productId = Integer.parseInt(multi.getParameter("productId"));
	String productPic = multi.getFilesystemName("productPic");
	
	// 디버깅
	System.out.println(productId + "<--productId");
	System.out.println(productPic + "<--productPic");
	
	// Product에 아이디, 사진이름 저장
	Product p = new Product();
	p.setProductId(productId);
	p.setProductPic(productPic);
	
	// db에 저장
	ProductDao productDao = new ProductDao();
	productDao.updateProductPic(p);
	
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productId=" + productId);
%>