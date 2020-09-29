<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<!-- 
	/modifyMemberAction.jsp*/
	
	modifyMember.jsp에서 수정 버튼을 누를시 회원 정보를 수정시켜주는 Action페이지
	
	수정 후 memberOne.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시.
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 정보 받기
	String memberEmail = request.getParameter("memberEmail");
	String memberName = request.getParameter("memberName");
	String memberState = request.getParameter("memberState");

	// 정보를 Member에 저장
	Member m = new Member();
	m.setMemberEmail(memberEmail);
	m.setMemberName(memberName);
	m.setMemberState(memberState);
	
	// 정보 수정 메서드 호출
	MemberDao memberDao = new MemberDao();
	memberDao.updateMember(m);
	
	System.out.println(memberEmail + "<--Action - email");
	
	response.sendRedirect(request.getContextPath() + "/member/memberOne.jsp?memberEmail=" + memberEmail);
%>