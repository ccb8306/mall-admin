<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*deleteNoticeAction.jsp*/
	
	noticeOne.jsp에서 삭제버튼을 누를시 오는 페이지
	받아온 noticeId에 해당하는 공지사항을 삭제한 후
	
	noticeList.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
	
	// 삭제할 공지사항 id
	int noticeId = Integer.parseInt(request.getParameter("noticeId"));
	System.out.println(noticeId + "<--noticeId");
	
	NoticeDao noticeDao = new NoticeDao();
	
	// 삭제
	noticeDao.deleteNotice(noticeId);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>