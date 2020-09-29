<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyCategoryPic</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<%
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));	
		
			System.out.println(categoryId + "<--categoryId");
		%>
		
		<!-- 이미지 수정 폼 -->
		<form action="<%=request.getContextPath() %>/category/modifyCategoryPicAction.jsp" method="post" enctype="multipart/form-data">	
			<input type="hidden" name="categoryId" value="<%=categoryId %>">
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th colspan="2"><h3>카테고리 이미지 수정</h3></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:15%">이미지 선택 : </td>
						<td><input class="form-control-file border" type="file" name="categoryPic"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn btn-outline-primary" type="submit">수정완료</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>