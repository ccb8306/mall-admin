<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*noticeList.jsp*/
	
	공지사항 목록을 출력해주는 페이지.
	
	공지사항 작성 클릭시 addNotice.jsp로 이동하여 공지사항 추가 가능
	공지사항 선택시 noticeOne.jsp페이지로 이동하여 공지사항을 상세볼 수 있음
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<!-- 자바 -->
		<%
			request.setCharacterEncoding("utf-8");
		
			int currentPage = 1; // 현재 페이지
			int rowPage = 10;	// 한 페이지당 출력 개수
			int endPage = 1;	// 최대 페이지
			String searchNotice = "";
			
			// 현재페이지 값 받기
			if(request.getParameter("currentPage") != null){
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			
			// 검색 키워드 받기
			if(request.getParameter("searchNotice") != null){
				searchNotice = request.getParameter("searchNotice");
			}
			
			NoticeDao noticeDao = new NoticeDao();
			ArrayList<Notice> noticeList;
			
			// 검색 x
			if(searchNotice.equals("")){
				noticeList = noticeDao.selectNoticeList(currentPage, rowPage);
				endPage = noticeDao.getNoticeEndPage(rowPage);
			// 검색 o
			}else{
				noticeList = noticeDao.selectNoticeListbySearch(searchNotice, currentPage, rowPage);
				endPage = noticeDao.getNoticeEndPagebySearch(searchNotice, rowPage);
			}
		%>

		<!-- 공지사항 목록 헤드 -->
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th colspan="2"><h3>공지사항 목록</h3></th>
				</tr>
				<tr>
					<th style="text-align:middle">
						<a style="background-color:white; width:13%" class="page-link" href="<%=request.getContextPath()%>/notice/addNotice.jsp">[공지사항 작성]</a>
					</th>
				</tr>
			</thead>
		</table>
		
		<!-- 공지사항 리스트 출력 -->
		<table class="table table-striped table-hover">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<th>공지 ID</th>
					<th>공지 제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : noticeList){
				%>
				<tr>
					<td><%=n.getNoticeId() %></td>
					<td style="width:60%"><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>"><%=n.getNoticeTitle() %></a></td>
					<td><%=n.getNoticeDate() %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<br>
		<!-- 상품 검색 -->
		<form method="post" action="<%=request.getContextPath() %>/notice/noticeList.jsp">
			<div class="input-group mb-3">
				<input type="text" class="form-control" name="searchNotice" placeholder="Search Notice Title" value="<%=searchNotice%>">
				<div class="input-group-prepend">	
					<button class="btn btn-outline-primary" type="submit">공지사항 검색</button>
				</div>
			</div>
		</form>
		
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=1&searchNotice=<%=searchNotice%>">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1 %>&searchNotice=<%=searchNotice%>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=1&searchNotice=<%=searchNotice%>">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1 %>&searchNotice=<%=searchNotice%>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&searchNotice=<%=searchNotice%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=endPage %>&searchNotice=<%=searchNotice%>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&searchNotice=<%=searchNotice%>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=endPage %>&searchNotice=<%=searchNotice%>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
</body>
</html>