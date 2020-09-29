<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*modifyNoticeAction.jsp*/
	
	modifyNotice.jsp에서 수정버튼 클릭시 오는 액션 페이지
	해당 공지사항의 변경사항을 적용시키고
	noticeList.jsp로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 데이터 받기
	int noticeId = Integer.parseInt(request.getParameter("noticeId"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// Notice에 데이터 저장
	Notice notice = new Notice();
	notice.setNoticeId(noticeId);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	// 공지사항 수정
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNotice(notice);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>