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
	
	// �α��� ����
	if(loginAdmin == null){
		System.out.println("�α��� ����");
		response.sendRedirect("/mall-admin/login.jsp");
	}
	// �α��� ����
	else{
		System.out.println("�α��� ����");
		// �α��� ������ �α��� ������ session�� ���� 
		session.setAttribute("loginAdminId", loginAdmin.getAdminId());
		response.sendRedirect("/mall-admin/index.jsp");
	}
	
%>
