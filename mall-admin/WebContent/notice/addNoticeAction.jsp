<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*addNoticeAction.jsp*/
	
	addNotice.jsp에서 작성 버튼으로 올수있는 페이지.
	받아온 내용을 공지사항에 추가 한 뒤 noticeList.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");		
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 정보 받기
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 디버깅
	System.out.println(noticeTitle + "<--noticeTitle");
	System.out.println(noticeContent + "<--noticeContent");
	
	// Notice에 정보저장
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	// 공지사항 추가
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insertNotice(notice);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>