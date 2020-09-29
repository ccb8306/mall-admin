<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*loginAction.jsp*/
	
	login.jsp페이지에서 로그인 버튼으로 오는 액션 페이지
	
	입력한 아이디와 비밀번호가 데이터베이스와 일치하면 index.jsp페이지로,
	일치하지 않으면 login.jsp페이지로 이동
 -->
<%
	request.setCharacterEncoding("utf-8");

	// 입력한 id와 pw
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	
	// Admin에 id와 pw저장
	Admin paramAdmin = new Admin();
	paramAdmin.setAdminId(adminId);
	paramAdmin.setAdminPw(adminPw);
	
	// 존재하는 계정인지 확인
	AdminDao adminDao = new AdminDao();
	Admin loginAdmin = adminDao.login(paramAdmin);
	
	// 로그인 실패
	if(loginAdmin == null){
		System.out.println("로그인 실패");
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
	// 로그인 성공
	else{
		System.out.println("로그인 성공");
		// 로그인 성공시 로그인 정보를 session에 저장 
		session.setAttribute("loginAdminId", loginAdmin.getAdminId());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
%>
