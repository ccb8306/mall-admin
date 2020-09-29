<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	String memberEmail = request.getParameter("memberEmail");
	String memberName = request.getParameter("memberName");
	String memberState = request.getParameter("memberState");

	Member m = new Member();
	m.setMemberEmail(memberEmail);
	m.setMemberName(memberName);
	m.setMemberState(memberState);
	
	MemberDao memberDao = new MemberDao();
	memberDao.updateMember(m);
	
	System.out.println(memberEmail + "<--Action - email");
	
	response.sendRedirect(request.getContextPath() + "/member/memberOne.jsp?memberEmail=" + memberEmail);
%>