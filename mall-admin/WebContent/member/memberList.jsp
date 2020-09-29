<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*memberList.jsp*/
	
	회원 리스트를 출력해주는 페이지.
	
	한 회원을 상세 볼 수 있거나 이메일 검색으로 회원을 찾을 수 있음.
	
	회원 클릭시 memberOne.jsp페이지로 이동 하여 상세보기 가능
	
 -->
<%
	// 비정상적인 접근시.
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
		
			int currentPage = 1; // 현재페이지
			int rowPage = 10;	// 한 페이지당 출력 개수
			int endPage = 1;	// 최대 페이지
			String searchOption = "";	// 검색 옵션
			String searchMember = "";	// 검색 키워드
			// 현재페이지 값 받기
			if(request.getParameter("currentPage") != null){
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}

			// 검색 옵션 받기
			if(request.getParameter("searchOption") != null){
				searchOption = request.getParameter("searchOption");
			}
			// 검색 키워드 받기
			if(request.getParameter("searchMember") != null){
				searchMember = request.getParameter("searchMember");
			}
			
			MemberDao memberDao = new MemberDao();
			ArrayList<Member> memberList = null;
			
			
			// 이름 검색
			if(searchOption.equals("name") && !searchMember.equals("")){
				memberList = memberDao.selectMemberListbyName(searchMember, currentPage, rowPage);
				endPage = memberDao.getMemberEndPagebyName(searchMember, rowPage);		
			// 이메일 검색
			}else if(searchOption.equals("email") && !searchMember.equals("")){
				memberList = memberDao.selectMemberListbyEmail(searchMember, currentPage, rowPage);
				endPage = memberDao.getMemberEndPagebyEmail(searchMember, rowPage);				
			}
			// 검색 안할 시
			else{
				memberList = memberDao.selectMemberList(currentPage, rowPage);
				endPage = memberDao.getMemberEndPage(rowPage);
			}
		%>

		<!-- 공지사항 목록 헤드 -->
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th colspan="2"><h3>회원 목록</h3></th>
				</tr>
			</thead>
		</table>
		
		<!-- 공지사항 리스트 출력 -->
		<table class="table table-striped table-hover">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<th>회원 Email</th>
					<th>회원 이름</th>
					<th>가입일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Member m : memberList){
						if(m.getMemberState().equals("Y")){
				%>
				<tr>
					<td><a href="<%=request.getContextPath()%>/member/memberOne.jsp?memberEmail=<%=m.getMemberEmail()%>"><%=m.getMemberEmail() %></a></td>
					<td><%=m.getMemberName() %></td>
					<td><%=m.getMemberDate() %></td>
					<td>활동중</td>
				</tr>
				<%
						}else{
				%>
				<tr style="color:red">
					<td><del><a href="<%=request.getContextPath()%>/member/memberOne.jsp?memberEmail=<%=m.getMemberEmail()%>"><%=m.getMemberEmail() %></a></del></td>
					<td><del><%=m.getMemberName() %></del></td>
					<td><del><%=m.getMemberDate() %></del></td>
					<td><del>탈퇴</del></td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>
		
		<br>
		<!-- 상품 검색 -->
		<form method="post" action="<%=request.getContextPath() %>/member/memberList.jsp">
			<div class="input-group mb-3">
				<select class="btn btn-outline-dark" name="searchOption">
					<option 
						<%
							if(searchOption.equals("name")){
						%>
								selected="selected"
						<%
							}
						%>value="name">이름</option>
					<option 
						<%
							if(searchOption.equals("email")){
						%>
								selected="selected"
						<%
							}
						%>value="email">이메일</option>
				</select>
				<input type="text" class="form-control" name="searchMember" placeholder="Search Member" value="<%=searchMember%>">
				<div class="input-group-prepend">	
					<button class="btn btn-outline-primary" type="submit">회원 검색</button>
				</div>
			</div>
		</form>
		
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=1&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=<%=currentPage-1 %>&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=1&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=<%=currentPage-1 %>&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=<%=currentPage+1%>&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=<%=endPage %>&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=<%=currentPage+1%>&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/memberList.jsp?currentPage=<%=endPage %>&searchOption=<%=searchOption%>&searchMember=<%=searchMember%>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
</body>
</html>