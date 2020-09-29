<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	
	Admin paramAdmin = new Admin();
	paramAdmin.setAdminId(adminId);
	paramAdmin.setAdminPw(adminPw);
	
	AdminDao adminDao = new AdminDao();
	
	Admin loginAdmin = adminDao.login(paramAdmin);
	
	// 로그인 실패
	if(loginAdmin == null){
		System.out.println("로그인 실패");
		response.sendRedirect("/mall-admin/login.jsp");
	}
	// 로그인 성공
	else{
		System.out.println("로그인 성공");
		// 로그인 성공시 로그인 정보를 session에 저장 
		session.setAttribute("loginAdminId", loginAdmin.getAdminId());
		response.sendRedirect("/mall-admin/index.jsp");
	}
	
%>
