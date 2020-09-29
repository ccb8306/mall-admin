<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	/*logoutAction.jsp*/
	
	메뉴바에 있는 로그아웃 버튼으로 오는 로그아웃 액션 페이지
	
	세션을 초기화 시켜줌
 -->
<%
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/login.jsp");
%>